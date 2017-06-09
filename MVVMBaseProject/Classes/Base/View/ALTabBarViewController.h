//
//  ALTabBarViewController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALTabBarViewController : ALBaseViewController <UITabBarControllerDelegate>
@property (nonatomic, strong) UITabBarController *tabBarController;
@end
