//
//  ALViewModelServicesImpl.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALViewModelServicesImpl.h"
#import "ALNetworkServicelmpl.h"

@implementation ALViewModelServicesImpl

@synthesize networkService = _networkService;

- (instancetype)init {
    if(self = [super init]) {
        _networkService = [[ALNetworkServicelmpl alloc]init];
    }
    return self;
}

- (void)pushViewModel:(ALBaseViewModel *)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(ALBaseViewModel *)viewModel animated:(BOOL)animated completion:(void (^)())completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^)())completion {}

- (void)resetRootViewModel:(ALBaseViewModel *)viewModel {}
@end
