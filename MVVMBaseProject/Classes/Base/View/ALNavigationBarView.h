//
//  ALNavigationBarView.h
//  MVVMBaseProject
//
//  Created by along on 2017/6/14.
//  Copyright © 2017年 along. All rights reserved.
//

@interface ALNavigationBarView : UIView
@property (nonatomic, assign) BOOL hideBackBtn;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) NSArray *rightBtns;
@property (nonatomic, strong) NSArray *leftBtns;
@end
