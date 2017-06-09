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
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params jk_setString:self.account forKey:@"mobile"];
        
        return [[self.services.networkService requestDataWithUrl:Request_UserGetCodeUrl params:params] takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.registCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params jk_setString:self.account forKey:@"mobile"];
        [params jk_setString:self.password forKey:@"password"];
        [params jk_setString:self.nickName forKey:@"name"];
        [params jk_setString:self.code forKey:@"code"];

        return [[self.services.networkService requestDataWithUrl:Request_UserRegistUrl params:params] takeUntil:self.rac_willDeallocSignal];
    }];
    
    [[RACSignal merge:@[self.getCodeCommand.errors,self.registCommand.errors]] subscribe:self.errors];
}

@end
