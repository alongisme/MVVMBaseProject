//
//  ALNetworkServicelmpl.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNetworkServicelmpl.h"
#import <AFNetworking.h>
#import "ALHttpConfig.h"

@implementation ALNetworkServicelmpl

- (RACSignal *)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params {
        
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        if([params jk_integerForKey:ALShowHudIdentifier] == 1) 
            [ALShowMessageView showStatusWithMessage:@"load..."];
        
        NSURLSessionTask *task = [[ALNetworkConnect sharedInstance].sessionManager POST:[[ALHttpConfig getALHttpAddress] stringByAppendingPathComponent:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            BOOL isJosn = [NSJSONSerialization isValidJSONObject:responseObject];
            id dataSource = nil;
            
            if(!isJosn) {
                @try {
                    dataSource = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                } @catch (NSException *exception) {
                    NSLog(@"%@,%@",exception,exception.userInfo);;
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
            
            if([params jk_integerForKey:ALLogResponseIdentifier] == 1)
                NSLog(@"--------------------------------------------------------\nRequest:\n Url:  %@\n Params:  %@\n --------------------------------------------------------\nResponse: %@\n--------------------------------------------------------",[[ALHttpConfig getALHttpAddress] stringByAppendingPathComponent:url],params,logString);
            
            if([dataSource isKindOfClass:[NSDictionary class]]) {
                dataSource = (NSDictionary *)dataSource;
                long code = [dataSource jk_longLongForKey:@"code"];
                
                if(code == 1) {
                    [ALShowMessageView dismissMessageView];
                    [subscriber sendNext:dataSource];
                } else {
                    NSError *error = [[NSError alloc] initWithDomain:url code:code userInfo:@{@"code" : @(code), @"message" : [dataSource jk_stringForKey:@"message"]}];
                    [ALShowMessageView showErrorWithMessage:[error.userInfo jk_stringForKey:@"message"]];
                    [subscriber sendError:error];
                }
            } else {
                [ALShowMessageView showErrorWithMessage:@"data error!"];
            }
            
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [ALShowMessageView dismissMessageView];
            [subscriber sendError:error];
            if([params jk_integerForKey:ALLogResponseIdentifier] == 1)
            NSLog(@"--------------------------------------------------------\n Url:%@ \n error:\n%@",url,error);
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
