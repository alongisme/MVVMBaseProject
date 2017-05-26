//
//  ALLoginViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLoginViewModel.h"
#import "ALUserModel.h"

@implementation ALLoginViewModel

- (void)initialize {

    self.loginEnableSignal = [RACCommonTools combineLatestInputSignal:@[RACObserve(self, account), RACObserve(self, password)]];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSMutableDictionary *params = [NSMutableDictionary requestDictionary];
        [params jk_setString:self.account forKey:@"mobile"];
        [params jk_setString:self.password forKey:@"password"];
        
        return [[[self.services.networkService requestDataWithUrl:@"/m/consumer/login" params:params] doNext:^(NSDictionary *sourceData) {
            ALUserModel *userModel = [ALUserModel mj_objectWithKeyValues:[sourceData jk_dictionaryForKey:@"object"]];
            NSLog(@"%@",userModel);
        }] rac_willDeallocSignal];
    }];
    
}

@end
