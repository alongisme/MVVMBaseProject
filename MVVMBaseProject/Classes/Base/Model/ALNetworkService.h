//
//  ALNetworkService.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

@protocol ALNetworkService <NSObject>
#pragma mark 用户登录
/**
 用户登录

 @param account 账号
 @param password 密码
 @return 信号
 */
- (RACSignal *)requestUserLoginWithAccount:(NSString *)account
                                  Password:(NSString *)password;

#pragma mark 用户注册
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
#pragma mark 用户重置密码（忘记密码）
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
#pragma mark 获取短信验证码
/**
 用户获取短信验证码
 
 @param account 手机号码
 @return 信号
 */
- (RACSignal *)requestGetCodeWithAccount:(NSString *)account;

#pragma mark 上传文件
/**
 上传文件
 
 @param imageArray 文件数组
 @return 信号
 */
- (RACSignal *)requestDataWithImageArray:(NSArray *)imageArray;


#pragma mark 创建一个网络请求（POST）
/**
 创建一个网络请求(POST)
 
 @param url url
 @param params 参数
 @return 信号
 */
- (RACSignal *)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params;

@end
