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

- (RACSignal *)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params {
        
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString *requestUrl = [Debug_Domain stringByAppendingPathComponent:url];
        
        NSURLSessionTask *task = [[ALNetworkConnect sharedInstance].sessionManager POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

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
            
            NSLog(@"--------------------------------------------------------\nRequest:\n Url:  %@\n Params:  %@\n --------------------------------------------------------\nResponse: %@\n--------------------------------------------------------",requestUrl,params,logString);
            
            if([dataSource isKindOfClass:[NSDictionary class]]) {
                dataSource = (NSDictionary *)dataSource;
                long code = [dataSource jk_longLongForKey:@"code"];
                
                if(code == 1) {
                    [subscriber sendNext:[dataSource jk_dictionaryForKey:@"object"]?[dataSource jk_dictionaryForKey:@"object"]:[dataSource jk_stringForKey:@"object"]];
                } else {
                    NSError *error = [[NSError alloc] initWithDomain:requestUrl code:code userInfo:dataSource];
                    [subscriber sendError:error];
                }
            } else {
                NSError *error = [[NSError alloc] initWithDomain:requestUrl code:0 userInfo:@{@"message":@"data error"}];
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
