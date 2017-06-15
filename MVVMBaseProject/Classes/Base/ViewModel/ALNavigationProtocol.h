//
//  ALNavigationProtocol.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

@class ALBaseViewModel;

@protocol ALNavigationProtocol <NSObject>
- (void)pushViewModel:(ALBaseViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(ALBaseViewModel *)viewModel animated:(BOOL)animated completion:(void (^)())completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(void (^)())completion;

- (void)resetRootViewModel:(ALBaseViewModel *)viewModel;
@end
