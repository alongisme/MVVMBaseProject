//
//  UIFont+DeviceSize.m
//  HealthJiaYuan
//
//  Created by along on 2017/1/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "UIFont+DeviceSize.h"

#define iphone7P_Heigth 736

#define fontScale fontSize*((ALScreenHeight < iphone7P_Heigth) ? ALScreenHeight/iphone7P_Heigth : 1)

@implementation UIFont (UIFont_DeviceSize)
+ (UIFont *)AL_setFont:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontScale];
}

+ (UIFont *)AL_setFontBold:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:fontScale];
}
@end
