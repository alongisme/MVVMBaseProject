//
//  ALLoginViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALLoginViewModel : ALBaseViewModel
//账号
@property (nonatomic, copy) NSString *account;
//密码
@property (nonatomic, copy) NSString *password;
//登录
@property (nonatomic, strong) RACCommand *loginCommand;
@end
