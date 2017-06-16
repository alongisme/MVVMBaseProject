//
//  ALNetworkServicelmpl.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNetworkServicelmpl.h"
#import <AFNetworking.h>

@implementation ALNetworkServicelmpl
#pragma mark 用户登录
/**
 用户登录
 
 @param account 账号
 @param password 密码
 @return 信号
 */
- (RACSignal *)requestUserLoginWithAccount:(NSString *)account
                                  Password:(NSString *)password {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params jk_setString:account forKey:@"name"];
    [params jk_setString:password forKey:@"password"];
    return [self requestDataWithUrl:[Request_Domain stringByAppendingPathComponent:@"/userLogin"] params:params];
}

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
                                       code:(NSString *)code {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params jk_setString:account forKey:@"name"];
    [params jk_setString:password forKey:@"password"];
    [params jk_setString:code forKey:@"code"];
    return [self requestDataWithUrl:[Request_Domain stringByAppendingPathComponent:@"/userRegist"] params:params];
}

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
                                       code:(NSString *)code {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params jk_setString:account forKey:@"name"];
    [params jk_setString:password forKey:@"password"];
    [params jk_setString:code forKey:@"code"];
    return [self requestDataWithUrl:[Request_Domain stringByAppendingPathComponent:@"/forgetPassword"] params:params];
}

#pragma mark 获取短信验证码
/**
 用户获取短信验证码
 
 @param account 手机号码
 @return 信号
 */
- (RACSignal *)requestGetCodeWithAccount:(NSString *)account {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params jk_setString:account forKey:@"name"];
    return [self requestDataWithUrl:[Request_Domain stringByAppendingPathComponent:@"/getCode"] params:params];
}

#pragma mark 创建一个网络请求（POST）
/**
 创建一个网络请求（POST）

 @param url url
 @param params 参数
 @return 信号
 */
- (RACSignal *)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params {
        
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLSessionTask *task = [[ALNetworkConnect sharedInstance].sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            BOOL isJosn = [NSJSONSerialization isValidJSONObject:responseObject];
            id dataSource = nil;
            
            if(!isJosn) {
                @try {
                    dataSource = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                } @catch (NSException *exception) {
                    NSLog(@"%@,%@",exception,exception.userInfo);
                } @finally {
                    
                }
            } else {
                dataSource = responseObject;
            }
            
            NSString *logString = nil;
            @try {
                NSData *data = [NSJSONSerialization dataWithJSONObject:dataSource options:NSJSONWritingPrettyPrinted error:nil];
                
                logString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            } @catch (NSException *exception) {
                NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
                logString = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
            } @finally {
                
            }
            
            NSLog(@"--------------------------------------------------------\nRequest:\n Url:  %@\n Params:  %@\n --------------------------------------------------------\nResponse: %@\n--------------------------------------------------------",url,params,logString);
            
            if([dataSource isKindOfClass:[NSDictionary class]]) {
                dataSource = (NSDictionary *)dataSource;
                long code = [dataSource jk_longLongForKey:@"code"];
                
                if(code == 1) {
                    NSDictionary *dataDictionary = [dataSource jk_dictionaryForKey:@"object"];
                    NSArray *dataArray = [dataSource jk_arrayForKey:@"object"];
                    NSString *dataString = [dataSource jk_stringForKey:@"object"];
                    if ([dataDictionary isVaild]) {
                        [subscriber sendNext:dataDictionary];
                    } else if ([dataArray isVaild]) {
                        [subscriber sendNext:dataArray];
                    } else if ([dataString isVaild]) {
                        [subscriber sendNext:dataString];
                    } else {
                        [subscriber sendNext:nil];
                    }
                } else {
                    NSError *error = [[NSError alloc] initWithDomain:url code:code userInfo:dataSource];
                    [subscriber sendError:error];
                }
            } else {
                NSError *error = [[NSError alloc] initWithDomain:url code:0 userInfo:@{@"message":@"data error"}];
                [subscriber sendError:error];
            }

            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
            NSLog(@"--------------------------------------------------------\n Url:%@ \n error:\n%@",url,error);
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


@end
