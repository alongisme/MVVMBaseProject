//
//  ALRegistViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRegistViewModel.h"

@implementation ALRegistViewModel

- (void)initialize {
    [super initialize];
    
    self.registEnable = [RACCommonTools combineLatestInputSignal:@[RACObserve(self, account),RACObserve(self, nickName),RACObserve(self, code),RACObserve(self, password),RACObserve(self, sePassword)]];
    
    @weakify(self);
    self.getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if([self.account al_checkPhoneNumber]) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params jk_setString:self.account forKey:@"name"];
            
            return [[self.services.networkService requestDataWithUrl:Request_UserGetCodeUrl params:params] takeUntil:self.rac_willDeallocSignal];
        } else {
            return [RACSignal return:@(ALErrorPhoneNumberError)];
        }
        return nil;
    }];
    
    self.registCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if([self.password isEqualToString:self.sePassword]) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params jk_setString:self.password forKey:@"password"];
            [params jk_setString:self.account forKey:@"name"];
            [params jk_setString:self.code forKey:@"code"];
            
            return [[self.services.networkService requestDataWithUrl:Request_UserRegistUrl params:params] takeUntil:self.rac_willDeallocSignal];
        } else {
            return [RACSignal return:@(ALErrorPasswordNotEquel)];
        }
    }];
    
    [[RACSignal merge:@[self.getCodeCommand.errors,self.registCommand.errors]] subscribe:self.errors];
}

@end
