//
//  RACCommonTools.h
//  HealthJiaYuan
//
//  Created by along on 2017/1/6.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACCommonTools : NSObject
//检验输入框长度
+ (RACSignal *)combineLatestInputSignal:(NSArray *)signalArr;
@end
