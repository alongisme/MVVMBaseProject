//
//  ALHttpConfig.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALHttpConfig.h"

static NSString *alconfigEnv;

@implementation ALHttpConfig

+ (void)setALConfigEnv:(NSString *)value {
    alconfigEnv = value;
}

+ (NSString *)ALConfigEnv {
    return alconfigEnv;
}

+ (NSString *)getALHttpAddress {
    if([alconfigEnv isEqualToString:DebugEnv]) {
        return Debug_URL;
    } else {
        return Release_URL;
    }
}

@end
