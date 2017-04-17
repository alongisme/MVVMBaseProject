//
//  ALTableViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALTableViewModel.h"

@implementation ALTableViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.requestRemoteDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *input) {
        @strongify(self);
            return [[self requestRemoteDataSignal] takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.requestLoadMoreDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *input) {
        @strongify(self);
        return [[self requestLoadMoreDataSignal] takeUntil:self.rac_willDeallocSignal];
    }];
    
}

- (id)fetchLocalData {return nil;}

- (RACSignal *)requestRemoteDataSignal {return [RACSignal empty];}

- (RACSignal *)requestLoadMoreDataSignal {return [RACSignal empty];}
@end
