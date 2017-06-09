//
//  ALRegistViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRegistViewController.h"
#import "ALRegistViewModel.h"
#import "ALAgreementViewController.h"

@interface ALRegistViewController ()
@property (nonatomic, strong) ALRegistViewModel *viewModel;
@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UITextField *nickNameTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UITextField *sePasswordTF;
@property (nonatomic, strong) UIButton *agreementBtn;
@property (nonatomic, strong) UIButton *registBtn;

@end

@implementation ALRegistViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@84);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.height.equalTo(@40);
    }];
    
    [self.nickNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTF.mas_bottom).offset(15);
        make.height.trailing.leading.equalTo(self.accountTF);
    }];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameTF.mas_bottom).offset(15);
        make.height.leading.equalTo(self.accountTF);
        make.width.equalTo(self.accountTF).multipliedBy(0.6);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameTF.mas_bottom).offset(15);
        make.height.trailing.equalTo(self.accountTF);
        make.width.equalTo(self.accountTF).multipliedBy(0.4);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.getCodeBtn.mas_bottom).offset(15);
        make.height.trailing.leading.equalTo(self.accountTF);
    }];
    
    [self.sePasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTF.mas_bottom).offset(15);
        make.height.trailing.leading.equalTo(self.accountTF);
    }];
    
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sePasswordTF.mas_bottom).offset(15);
        make.leading.equalTo(self.sePasswordTF).offset(15);
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.agreementBtn.mas_bottom).offset(30);
        make.height.trailing.leading.equalTo(self.accountTF);
    }];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.viewModel,account) = self.accountTF.rac_textSignal;
    RAC(self.viewModel,nickName) = self.nickNameTF.rac_textSignal;
    RAC(self.viewModel,code) = self.nickNameTF.rac_textSignal;
    RAC(self.viewModel,password) = self.passwordTF.rac_textSignal;
    RAC(self.viewModel,sePassword) = self.sePasswordTF.rac_textSignal;
    RAC(self.registBtn,enabled) = self.viewModel.registEnable;
    
    @weakify(self);
    [[self.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if([self.accountTF.text al_checkPhoneNumber]) {
            [self.viewModel.getCodeCommand execute:nil] ;
        } else {
            [self.view showHudError:@"请输入正确的手机号码！"];
        }
    }];
    
    [[self.agreementBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:[ALAgreementViewController new]];
        [self presentViewController:navigationC animated:YES completion:nil];
    }];
    
    [[self.registBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if([self.passwordTF.text isEqualToString:self.sePasswordTF.text])
            [self.viewModel.registCommand execute:nil];
        else
            [self.view showHudError:@"两次密码不一致"];
    }];
    
    [[[RACSignal merge:@[self.viewModel.getCodeCommand.executing,self.viewModel.registCommand.executing]] doNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
    }] subscribeNext:^(NSNumber *executing) {
        @strongify(self);
        executing.boolValue?[self.view showHud]:[self.view hideHud];
    }];
    
}

#pragma lazy load
- (UITextField *)accountTF {
    if(!_accountTF) {
        _accountTF = [UITextField new];
        _accountTF.placeholder = @"请输入手机号码";
        _accountTF.borderStyle = UITextBorderStyleBezel;
        _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_accountTF];
    }
    return _accountTF;
}

- (UITextField *)nickNameTF {
    if(!_nickNameTF) {
        _nickNameTF = [UITextField new];
        _nickNameTF.placeholder = @"请输入昵称";
        _nickNameTF.borderStyle = UITextBorderStyleBezel;
        _nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_nickNameTF];
    }
    return _nickNameTF;
}

- (UITextField *)codeTF {
    if(!_codeTF) {
        _codeTF = [UITextField new];
        _codeTF.placeholder = @"请输入验证码";
        _codeTF.borderStyle = UITextBorderStyleBezel;
        _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:_codeTF];
    }
    return _codeTF;
}

- (UIButton *)getCodeBtn {
    if(!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundImage:[UIImage al_imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundImage:[UIImage al_imageWithColor:[UIColor grayColor]] forState:UIControlStateSelected];
        [self.view addSubview:_getCodeBtn];
    }
    return _getCodeBtn;
}

- (UITextField *)passwordTF {
    if(!_passwordTF) {
        _passwordTF = [UITextField new];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.borderStyle = UITextBorderStyleBezel;
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.secureTextEntry = YES;
        [self.view addSubview:_passwordTF];
    }
    return _passwordTF;
}

- (UITextField *)sePasswordTF {
    if(!_sePasswordTF) {
        _sePasswordTF = [UITextField new];
        _sePasswordTF.placeholder = @"请再次输入密码";
        _sePasswordTF.borderStyle = UITextBorderStyleBezel;
        _sePasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _sePasswordTF.secureTextEntry = YES;
        [self.view addSubview:_sePasswordTF];
    }
    return _sePasswordTF;
}

- (UIButton *)agreementBtn {
    if(!_agreementBtn) {
        _agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreementBtn setTitle:@"注册代表您已阅读xxx协议" forState:UIControlStateNormal];
        [_agreementBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:_agreementBtn];
    }
    return _agreementBtn;
}

- (UIButton *)registBtn {
    if(!_registBtn) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _registBtn.layer.masksToBounds = YES;
        _registBtn.layer.borderColor = [UIColor blueColor].CGColor;
        _registBtn.layer.borderWidth = 1;
        [self.view addSubview:_registBtn];
    }
    return _registBtn;
}
@end
