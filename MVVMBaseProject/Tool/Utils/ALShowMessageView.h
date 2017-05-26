//
//  ALShowMessageView.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALShowMessageView : NSObject

/**
 显示
 */
+ (void)show;
/**
 展示错误信息

 @param message 信息内容
 */
+ (void)showErrorWithMessage:(NSString *)message;

/**
 展示成功信息

 @param message 信息内容
 */
+ (void)showSuccessWithMessage:(NSString *)message;

/**
  展示提交状态

 @param message 信息内容
 */
+ (void)showStatusWithMessage:(NSString *)message;

/**
 隐藏弹出框

 @param message 信息内容
 */
+ (void)dismissSuccessView:(NSString *)message;
+ (void)dismissErrorView:(NSString *)message;
+ (void)dismissMessageView;
@end
