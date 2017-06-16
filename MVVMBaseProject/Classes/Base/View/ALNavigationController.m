//
//  ALNavigationController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNavigationController.h"

@interface ALNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ALNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏
    self.navigationBar.hidden = YES;
    //启动滑动返回手势
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
}

@end
