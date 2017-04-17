//
//  ALNetworkService.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ALNetworkService <NSObject>

- (RACSignal *)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params;
@end
