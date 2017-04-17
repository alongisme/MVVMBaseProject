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
    [self fourLab];
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
