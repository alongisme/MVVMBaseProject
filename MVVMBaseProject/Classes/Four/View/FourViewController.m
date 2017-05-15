//
//  FourViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()
@property (nonatomic, strong) UILabel *fourLab;
@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *fatherView = [UIView new];
    fatherView.al_setFrame(0,100,150,250);
    fatherView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:fatherView];
    
    UIView *view1 = [UIView new];
    view1.al_setFrame(0,0,30,40);
    view1.backgroundColor = AL_RandomColor;
    [fatherView addSubview:view1];
    
    UIView *view2 = [UIView new];
    view2.al_setFrame(0,0,30,40);
    view2.backgroundColor = AL_RandomColor;
    [fatherView addSubview:view2];

    UIView *view3 = [UIView new];
    view3.al_setFrame(0,0,30,40);
    view3.backgroundColor = AL_RandomColor;
    [fatherView addSubview:view3];

    UIView *view4 = [UIView new];
    view4.al_setFrame(0,0,30,40);
    view4.backgroundColor = AL_RandomColor;
    [fatherView addSubview:view4];
    
    fatherView.al_alignment(ALFrameAlignmentStyleBothVerticalCenter);
}

- (UILabel *)fourLab {
    if(!_fourLab) {
        _fourLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _fourLab.center = self.view.center;
        _fourLab.textAlignment = NSTextAlignmentCenter;
        _fourLab.font = [UIFont systemFontOfSize:40];
        _fourLab.text = @"Four";
        [self.view addSubview:_fourLab];
    }
    return _fourLab;
}
@end
