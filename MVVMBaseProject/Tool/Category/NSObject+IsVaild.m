//
//  NSObject+IsVaild.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/15.
//  Copyright © 2017年 along. All rights reserved.
//

#import "NSObject+IsVaild.h"

@implementation NSObject (NSObject_IsVaild)
- (BOOL)isVaild {
    
    if(self == nil) {
        NSLog(@"object is nil");
        return NO;
    }
    
    if([self isEqual:[NSNull null]]) {
        NSLog(@"object is equal [NSNull null]");
        return NO;
    }
    
    if([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        if([str isEqualToString:@""]) {
            NSLog(@"object is equal [NSString class] and value == """);
            return NO;
        }
        if([str isEqualToString:@"<null>"]) {
            NSLog(@"object is equal [NSString class] and value == <null>");
            return NO;
        }
    }
    
    if([self isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)self;
        if(arr.count == 0) {
            NSLog(@"object is equal [NSArray class] and count == 0");
            return NO;
        }
    }
    
    if([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self;
        if(dic.count == 0) {
            NSLog(@"object is equal [NSDictionary class] and count == 0");
            return NO;
        }
    }
    
    return YES;
}
@end
