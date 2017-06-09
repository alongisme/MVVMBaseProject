//
//  NSString+ALCheck.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/31.
//  Copyright © 2017年 along. All rights reserved.
//

#import "NSString+ALCheck.h"

@implementation NSString (NSString_ALCheck)

- (BOOL)al_checkPhoneNumber {
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    BOOL isMatch = [pred evaluateWithObject:number];
    
    if(self.length == 11 && [[self substringToIndex:1] isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)al_checkEmail {
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:self];
    
}

- (BOOL)al_checkPassword {
    NSString *pattern = @"^[\\dA-Za-z_,.!@#$%^&*]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
    
}

- (BOOL)al_checkNickName {
    NSString *pattern = @"^[\\u4e00-\\u9fa5]{1,10}$|^[\\dA-Za-z_,.!@#$%^&*]{1,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}
@end
