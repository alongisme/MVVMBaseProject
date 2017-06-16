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
    
    RACSignal *loginEnableSignal = [RACCommonTools combineLatestInputSignal:@[RACObserve(self, account), RACObserve(self, password)]];
    
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithEnabled:loginEnableSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [[[self.services.networkService requestUserLoginWithAccount:self.account Password:self.password] doNext:^(NSDictionary *sourceData) {
            [sourceData AL_saveLocalWithLocalKey:UserDefult_UserInfoKey];
            
            ALTabBarViewModel *tabbarViewModel = [[ALTabBarViewModel alloc] initWithServices:self.services params:nil];
            [self.services resetRootViewModel:tabbarViewModel];
            
        }] takeUntil:self.rac_willDeallocSignal];
    }];
    
    [self.loginCommand.errors subscribe:self.errors];
}

@end
