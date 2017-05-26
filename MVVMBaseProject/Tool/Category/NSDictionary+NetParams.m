//
//  NSDictionary+NetParams.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "NSDictionary+NetParams.h"

@implementation NSDictionary (NSDictionary_NetParams)
+ (instancetype)requestDictionary {
    NSMutableDictionary *netDictionary = [NSMutableDictionary dictionary];
    [netDictionary setObject:@1 forKey:ALShowHudIdentifier];
    [netDictionary setObject:@1 forKey:ALLogResponseIdentifier];
    return netDictionary;
}
@end
