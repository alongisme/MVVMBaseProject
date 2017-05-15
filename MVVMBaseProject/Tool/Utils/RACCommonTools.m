//
//  RACCommonTools.m
//  HealthJiaYuan
//
//  Created by along on 2017/1/6.
//  Copyright © 2017年 along. All rights reserved.
//

#import "RACCommonTools.h"

@implementation RACCommonTools
//检验输入框长度
+ (RACSignal *)combineLatestInputSignal:(NSArray *)signalArr {
    return [[[RACSignal combineLatest:signalArr] map:^id(RACTuple *value) {
        for (id key in value.allObjects) {
            if([key isKindOfClass:[NSString class]]) {
                if(((NSString *)key).length == 0) {
                    return @0;
                }
            } else if([key isKindOfClass:[NSNumber class]]) {
                if([((NSNumber *)key) integerValue] == 0) {
                    return @0;
                }
            }
        }
        return @1;
    }] distinctUntilChanged];
}
@end
