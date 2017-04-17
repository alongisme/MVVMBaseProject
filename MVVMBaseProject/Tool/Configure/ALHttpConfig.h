//
//  ALHttpConfig.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALConst.h"

@interface ALHttpConfig : NSObject

/**
 设置网络环境

 @param value 生产环境 DebugEnv 正式环境 ReleaseEnv
 */
+ (void)setALConfigEnv:(NSString *)value;

// 返回环境参数 00: 测试环境 01: 生产环境
+ (NSString *)ALConfigEnv;

// 获取服务器地址
+ (NSString *)getALHttpAddress;

@end
