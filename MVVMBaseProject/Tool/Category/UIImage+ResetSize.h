//
//  UIImage+ResetSize.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResetSize)

/**
 不失真设置指定图片大小

 @param image 图片
 @param reSize 新的size
 @return 新的图片
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
@end
