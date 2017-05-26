//
//  UIImage+ALColor.h
//  HealthJiaYuan
//
//  Created by along on 2016/12/30.
//  Copyright © 2016年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (UIImage_ALColor)

/**
 获取指定颜色的图片

 @param color 颜色
 @return 返回图片
 */
+ (UIImage *)al_imageWithColor:(UIColor *)color;
@end
