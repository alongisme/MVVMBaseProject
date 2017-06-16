//
//  ALTabBarViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALTabBarViewModel.h"

@implementation ALTabBarViewModel

- (void)initialize {
    //tabbar不需要调用基类方法
    self.oneViewModel = [[OneViewModel alloc]initWithServices:self.services params:@{@"title":@"One"}];
    self.twoViewModel = [[TwoViewModel alloc]initWithServices:self.services params:@{@"title":@"Two"}];
    self.threeViewModel = [[ThreeViewModel alloc]initWithServices:self.services params:@{@"title":@"Three"}];
    self.fourViewModel = [[FourViewModel alloc]initWithServices:self.services params:@{@"title":@"Four"}];
}

@end
