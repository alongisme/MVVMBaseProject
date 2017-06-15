//
//  ALViewRouter.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//


@interface ALViewRouter : NSObject <NSCopying>

+ (instancetype)sharedInstance;
/**
 viewModel 映射 viewController

 @param viewModel viewModel
 @return Controller
 */
- (ALBaseViewController *)viewControllerForViewModel:(ALBaseViewModel *)viewModel;
@end
