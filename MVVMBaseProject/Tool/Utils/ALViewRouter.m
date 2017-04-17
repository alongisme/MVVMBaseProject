//
//  ALViewRouter.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALViewRouter.h"
#import "ALBaseViewController.h"
#import "ALBaseViewModel.h"

@implementation ALViewRouter

static ALViewRouter *_router = nil;
static NSString * const ViewModelString = @"Model";
static NSString * const ViewControllerString = @"Controller";

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [[super allocWithZone:NULL] init];
    });
    return _router;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [ALViewRouter sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return _router;
}

- (id)mutableCopy {
    return _router;
}

//nameViewModel -> nameViewController
- (ALBaseViewController *)viewControllerForViewModel:(ALBaseViewModel *)viewModel {
    
    NSString *viewControllerString = [NSStringFromClass([viewModel class]) stringByReplacingOccurrencesOfString:ViewModelString withString:ViewControllerString];
        
    NSParameterAssert([NSClassFromString(viewControllerString) isSubclassOfClass:[ALBaseViewController class]]);
    NSParameterAssert([NSClassFromString(viewControllerString) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewControllerString) alloc]initWithViewModel:viewModel];
}
@end
