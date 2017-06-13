//
//  ALForgetPasswordViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALForgetPasswordViewModel.h"

@implementation ALForgetPasswordViewModel

- (void)initialize {
    [super initialize];
    
    self.updateEnable = [RACCommonTools combineLatestInputSignal:@[RACObserve(self, account),RACObserve(self, code),RACObserve(self, password),RACObserve(self, sePassword)]];
    
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
    
    self.updateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if([self.password isEqualToString:self.sePassword]) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params jk_setString:self.password forKey:@"newPassword"];
            [params jk_setString:self.account forKey:@"name"];
            [params jk_setString:self.code forKey:@"code"];
            
            return [[self.services.networkService requestDataWithUrl:Request_UserForgotPwdUrl params:params] takeUntil:self.rac_willDeallocSignal];
        } else {
            return [RACSignal return:@(ALErrorPasswordNotEquel)];
        }
    }];
    
    [[RACSignal merge:@[self.getCodeCommand.errors,self.updateCommand.errors]] subscribe:self.errors];
}

@end
