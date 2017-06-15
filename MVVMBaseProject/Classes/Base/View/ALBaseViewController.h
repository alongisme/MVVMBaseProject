//
//  ALBaseViewController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

@class ALNavigationBarView;

@interface ALBaseViewController : UIViewController

@property (nonatomic, strong) ALBaseViewModel *viewModel;

@property (nonatomic, strong) ALNavigationBarView *navigationBar;

- (instancetype)initWithViewModel:(ALBaseViewModel *)viewModel;

- (void)bindViewModel;

@end
