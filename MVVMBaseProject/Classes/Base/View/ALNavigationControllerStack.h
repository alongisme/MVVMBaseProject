//
//  ALNavigationControllerStack.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNavigationController.h"
@protocol ALNavigationProtocol;

@interface ALNavigationControllerStack : NSObject
//当前控制器 （记录跳转的最后一个控制器）
@property (nonatomic, strong) ALNavigationController *currentController;
//初始化
- (instancetype)initWithServices:(id<ALNavigationProtocol>)services;
@end
