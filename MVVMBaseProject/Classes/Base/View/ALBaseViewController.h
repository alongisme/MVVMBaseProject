//
//  ALBaseViewController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

@class ALNavigationBarView;

@interface ALBaseViewController : UIViewController
//业务处理类
@property (nonatomic, strong) ALBaseViewModel *viewModel;
//自定义导航栏
@property (nonatomic, strong) ALNavigationBarView *navigationBar;
//初始化
- (instancetype)initWithViewModel:(ALBaseViewModel *)viewModel;
//绑定数据和信号
- (void)bindViewModel;
@end
