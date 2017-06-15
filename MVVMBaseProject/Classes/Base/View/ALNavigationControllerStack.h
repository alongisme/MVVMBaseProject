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

@property (nonatomic, strong) ALNavigationController *currentController;

- (instancetype)initWithServices:(id<ALNavigationProtocol>)services;
@end
