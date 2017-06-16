//
//  ALLoginViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALLoginViewController.h"
#import "ALLoginViewModel.h"
#import "ALRegistViewModel.h"
#import "ALForgetPasswordViewModel.h"

@interface ALLoginViewController ()
@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UITextField *pwdTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) ALLoginViewModel *viewModel;
@end

@implementation ALLoginViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.height.equalTo(@40);
        make.top.equalTo(@250);
    }];
    
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.height.equalTo(@40);
        make.top.equalTo(_accountTF.mas_bottom).offset(15);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@35);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(10);
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-35);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(10);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.height.equalTo(@40);
        make.top.equalTo(_pwdTF.mas_bottom).offset(100);
    }];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.viewModel, account) = self.accountTF.rac_textSignal;
    RAC(self.viewModel, password) = self.pwdTF.rac_textSignal;
    
    self.accountTF.text = @"11111111111";
    self.pwdTF.text = @"111111";
    self.viewModel.account = @"11111111111";
    self.viewModel.password = @"111111";
    self.loginBtn.enabled = YES;
    
    @weakify(self);
    {
        [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [[self.viewModel.loginCommand execute:nil] subscribeNext:^(id x) {
                @strongify(self);
                [self.view showHudSuccess:@"登录成功！"];
            }];
        }];

        [[self.viewModel.loginCommand.executing doNext:^(id x) {
            @strongify(self);
            [self.view endEditing:YES];
        }] subscribeNext:^(NSNumber *executing) {
            @strongify(self);
            executing.boolValue?[self.view showHud]:[self.view hideHud];
        }];
    }
    
    {
        [[self.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            ALForgetPasswordViewModel *forgetPasswordViewModel = [[ALForgetPasswordViewModel alloc] initWithServices:self.viewModel.services params:@{@"title":@"忘记密码"}];
            [self.viewModel.services pushViewModel:forgetPasswordViewModel animated:YES];
        }];
    }
    
    {
        [[self.registBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            ALRegistViewModel *registViewModel = [[ALRegistViewModel alloc] initWithServices:self.viewModel.services params:@{@"title":@"注册用户"}];
            [self.viewModel.services pushViewModel:registViewModel animated:YES];
        }];
    }
    
}

#pragma mark lazy load subviews
- (UITextField *)accountTF {
    if(!_accountTF) {
        _accountTF = [UITextField new];
        _accountTF.placeholder = @"请输入手机号码或用户名";
        _accountTF.borderStyle = UITextBorderStyleBezel;
        _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_accountTF];
    }
    return _accountTF;
}

- (UITextField *)pwdTF {
    if(!_pwdTF) {
        _pwdTF = [UITextField new];
        _pwdTF.placeholder = @"请输入密码";
        _pwdTF.borderStyle = UITextBorderStyleBezel;
        _pwdTF.secureTextEntry = YES;
        _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_pwdTF];
    }
    return _pwdTF;
}

- (UIButton *)loginBtn {
    if(!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.borderColor = [UIColor blueColor].CGColor;
        _loginBtn.layer.borderWidth = 1;
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (UIButton *)registBtn {
    if(!_registBtn) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"注册用户" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:_registBtn];
    }
    return _registBtn;
}

- (UIButton *)forgetBtn {
    if(!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:_forgetBtn];
    }
    return _forgetBtn;
}
@end
