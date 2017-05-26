//
//  NSDictionary+NetParams.h
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const ALShowHudIdentifier = @"ALShowHudIdentifier";
static NSString * const ALLogResponseIdentifier = @"ALLogResponseIdentifier";

@interface NSDictionary (NSDictionary_NetParams)

+ (instancetype)requestDictionary;

@end
