//
//  ALBaseViewController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALBaseViewController : UIViewController

@property (nonatomic, strong) ALBaseViewModel *viewModel;

- (instancetype)initWithViewModel:(ALBaseViewModel *)viewModel;

- (void)bindViewModel;

@end
