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
    
    self.registEnable = [RACCommonTools combineLatestInputSignal:@[RACObserve(self, account),RACObserve(self, nickName),RACObserve(self, code),RACObserve(self, password),RACObserve(self, sePassword)]];
    
    @weakify(self);
    self.registCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        return [[self.services.networkService requestDataWithUrl:@"" params:@{}] doNext:^(NSDictionary *sourceData) {
            
        }];
    }];
    
}

@end
