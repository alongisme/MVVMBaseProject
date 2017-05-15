//
//  UIButton+countDown.h
//  NetworkEgOc
//
//  Created by iosdev on 15/3/17.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ALCountDown)
/**
 *  定时显示title （验证码）
 *
 *  @param timeout    定时器时间
 *  @param tittle     最后要显示的文字
 *  @param waitTittle 定时器每次刷新的文字
 */
-(void)AL_startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;
@end
