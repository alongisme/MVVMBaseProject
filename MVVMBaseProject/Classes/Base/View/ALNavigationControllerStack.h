//
//  ALNavigationControllerStack.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ALNavigationProtocol;

@interface ALNavigationControllerStack : NSObject

@property (nonatomic, strong) UINavigationController *currentController;

- (instancetype)initWithServices:(id<ALNavigationProtocol>)services;
@end
