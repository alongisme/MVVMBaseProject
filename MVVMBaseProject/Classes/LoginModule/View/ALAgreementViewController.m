//
//  ALAgreementViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/29.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAgreementViewController.h"

@interface ALAgreementViewController ()

@end

@implementation ALAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户协议";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
