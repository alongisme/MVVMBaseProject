//
//  ALShowMessageView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALShowMessageView.h"
#import <MMProgressHUD.h>

@implementation ALShowMessageView

+ (void)show {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD show];
}

+ (void)showErrorWithMessage:(NSString *)message {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStyleBordered];
    [MMProgressHUD dismissWithError:nil title:message afterDelay:2.0];
}

+ (void)showSuccessWithMessage:(NSString *)message {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStyleBordered];
    [MMProgressHUD dismissWithSuccess:nil title:message afterDelay:2.0];
}

+ (void)showStatusWithMessage:(NSString *)message {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithStatus:message];
}

+ (void)dismissSuccessView:(NSString *)message {
    [MMProgressHUD dismissWithSuccess:message];
}

+ (void)dismissErrorView:(NSString *)message {
    [MMProgressHUD dismissWithError:message];
}

+ (void)dismissMessageView {
    [MMProgressHUD dismiss];
}
@end
