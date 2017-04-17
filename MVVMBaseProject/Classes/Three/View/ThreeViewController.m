//
//  ThreeViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()
@property (nonatomic, strong) UILabel *threeLab;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self threeLab];
}

- (UILabel *)threeLab {
    if(!_threeLab) {
        _threeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
        _threeLab.center = self.view.center;
        _threeLab.textAlignment = NSTextAlignmentCenter;
        _threeLab.font = [UIFont systemFontOfSize:40];
        _threeLab.text = @"Three";
        [self.view addSubview:_threeLab];
    }
    return _threeLab;
}
@end
