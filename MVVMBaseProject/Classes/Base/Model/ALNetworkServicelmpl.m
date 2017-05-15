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
        
        NSURLSessionTask *task = [[ALNetworkConnect sharedInstance].sessionManager GET:[[ALHttpConfig getALHttpAddress] stringByAppendingPathComponent:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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
                NSLog(@"--------------------------------------------------------\nRequest:\n Url:  %@\n Params:  %@\n --------------------------------------------------------\nResponse: %@\n--------------------------------------------------------",[[ALHttpConfig getALHttpAddress] stringByAppendingPathComponent:url],params,responseObject);
                [subscriber sendNext:responseObject];
            }
            
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
            NSLog(@"%@",error);
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
