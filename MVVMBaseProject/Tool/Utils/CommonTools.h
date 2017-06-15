//
//  CommonTools.h
//  HealthJiaYuan
//
//  Created by along on 2016/12/29.
//  Copyright © 2016年 along. All rights reserved.
//


@interface CommonTools : NSObject
//获取设备类型
+ (NSString *)deviceType;
+ (BOOL)isIphone5;
+ (BOOL)isIphone6;
+ (BOOL)isIphone6p;
+ (BOOL)isIphone7;
+ (BOOL)isIphone7p;
//判断手机号码 是否11位 以1开头
+ (BOOL)checkPhoneNumber:(NSString *)number;
//邮箱验证
+ (BOOL)checkEmail:(NSString *)email;
//密码验证 6-20位 字母数字组合
+ (BOOL)checkPassword:(NSString *) password;
//昵称验证 中文1-10 字符1-20 
+ (BOOL)checkNickName:(NSString *)niclkName;
@end
