//
//  ALLoginViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLoginViewModel.h"
#import "ALUserModel.h"
#import "ALTabBarViewModel.h"

@implementation ALLoginViewModel

- (void)initialize {
    [super initialize];
    
    self.loginEnableSignal = [RACCommonTools combineLatestInputSignal:@[RACObserve(self, account), RACObserve(self, password)]];
    
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params jk_setString:self.account forKey:@"mobile"];
        [params jk_setString:self.password forKey:@"password"];
        
        return [[[self.services.networkService requestDataWithUrl:Request_UserLoginUrl params:params] doNext:^(NSDictionary *sourceData) {
            @strongify(self);
            [sourceData AL_saveLocalWithLocalKey:UserDefult_UserInfoKey];
            
            ALTabBarViewModel *tabbarViewModel = [[ALTabBarViewModel alloc] initWithServices:self.services params:nil];
            [self.services resetRootViewModel:tabbarViewModel];
            
        }] takeUntil:self.rac_willDeallocSignal];
    }];
    
    [self.loginCommand.errors subscribe:self.errors];
}

@end