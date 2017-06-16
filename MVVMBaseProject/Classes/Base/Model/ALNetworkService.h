//
//  ALNetworkService.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

@protocol ALNetworkService <NSObject>
/**
 用户登录

 @param account 账号
 @param password 密码
 @return 信号
 */
- (RACSignal *)requestUserLoginWithAccount:(NSString *)account
                                  Password:(NSString *)password;

/**
 用户注册
 
 @param account 账号
 @param password 密码
 @param code 验证码
 @return 信号
 */
- (RACSignal *)requestUserRegistWithAccount:(NSString *)account
                                   Password:(NSString *)password
                                       code:(NSString *)code;

/**
 用户重置密码(忘记密码)
 
 @param account 账号
 @param password 密码
 @param code 验证码
 @return 信号
 */
- (RACSignal *)requestUserForgetWithAccount:(NSString *)account
                                   Password:(NSString *)password
                                       code:(NSString *)code;

/**
 用户获取短信验证码
 
 @param account 手机号码
 @return 信号
 */
- (RACSignal *)requestGetCodeWithAccount:(NSString *)account;

/**
 创建一个网络请求(POST)
 
 @param url url
 @param params 参数
 @return 信号
 */
- (RACSignal *)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params;

@end
