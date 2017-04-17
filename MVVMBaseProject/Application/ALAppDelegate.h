//
//  ALAppDelegate.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALNetworkConnect.h"
#import "ALNavigationControllerStack.h"

@interface ALAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) ALNavigationControllerStack *navigationControllerStack;

@property (nonatomic, assign) ALNetworkStatus networkStatus;
@end
