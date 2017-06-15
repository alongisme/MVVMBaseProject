//
//  NSString+ALCheck.h
//  MVVMBaseProject
//
//  Created by along on 2017/5/31.
//  Copyright © 2017年 along. All rights reserved.
//


@interface  NSString (NSString_ALCheck)
//判断手机号码 是否11位 以1开头
- (BOOL)al_checkPhoneNumber;
//邮箱验证
- (BOOL)al_checkEmail;
//密码验证 6-20位 字母数字组合
- (BOOL)al_checkPassword;
//昵称验证 中文1-10 字符1-20
- (BOOL)al_checkNickName;
@end
