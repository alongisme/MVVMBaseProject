//
//  UIImage+ALColor.m
//  HealthJiaYuan
//
//  Created by along on 2016/12/30.
//  Copyright © 2016年 along. All rights reserved.
//

#import "UIImage+ALColor.h"

@implementation UIImage (UIImage_ALColor)
+ (UIImage *)al_imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
