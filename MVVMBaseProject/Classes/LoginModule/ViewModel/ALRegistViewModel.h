//
//  ALRegistViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALRegistViewModel : ALBaseViewModel
//账号
@property (nonatomic, copy) NSString *account;
//昵称
@property (nonatomic, copy) NSString *nickName;
//验证码
@property (nonatomic, copy) NSString *code;
//密码
@property (nonatomic, copy) NSString *password;
//再次输入密码
@property (nonatomic, copy) NSString *sePassword;
//获取验证码
@property (nonatomic, strong) RACCommand *getCodeCommand;
//注册
@property (nonatomic, strong) RACCommand *registCommand;
@end
