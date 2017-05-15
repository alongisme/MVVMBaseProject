//
//  ALScrollViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALScrollViewModel.h"

@implementation ALScrollViewModel
- (void)initialize {
    [super initialize];
    
    @weakify(self);
    self.requestRemoteDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *input) {
        @strongify(self);
        return [[self requestRemoteDataSignal] takeUntil:self.rac_willDeallocSignal];
    }];
    
}

- (RACSignal *)requestRemoteDataSignal {return [RACSignal empty];}

@end
