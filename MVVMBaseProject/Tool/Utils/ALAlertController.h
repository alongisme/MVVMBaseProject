//
//  ALAlertController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ALAlertViewActionStyle) {
    ALAlertViewActionStyleDefault = 0,
    ALAlertViewActionStyleCancel,
    ALAlertViewActionStyleDestructive
};

typedef void (^CallBackBlock)(NSInteger btnIndex);

typedef void (^TextFieldCallBackBlock)(NSString * text);

@interface ALAlertController : NSObject

+ (void)showAlertViewWith:(UIViewController *)viewController title:(NSString *)title
                  message:(NSString *)message buttonTitle:(NSString *)btnTitle
              buttonStyle:(ALAlertViewActionStyle)buttonStyle;

+ (void)showAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
            CallBackBlock:(CallBackBlock)textBlock cancelButtonTitle:(NSString *)cancelBtnTitle
   destructiveButtonTitle:(NSString *)destructiveBtnTitle
        otherButtonTitles:(NSString *)otherBtnTitles,...NS_REQUIRES_NIL_TERMINATION;

+ (void)showAlertTextFieldViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
            TextFeildCallBackBlock:(TextFieldCallBackBlock)block cancelButtonTitle:(NSString *)cancelBtnTitle
                 otherButtonTitles:(NSString *)otherBtnTitle;

+ (void)showAlertActionSheetViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
                         buttonTitle:(NSString *)btnTitle buttonStyle:(ALAlertViewActionStyle)buttonStyle;

+ (void)showAlertActionSheetWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
                   callbackBlock:(CallBackBlock)block destructiveButtonTitle:(NSString *)destructiveBtnTitle
               cancelButtonTitle:(NSString *)cancelBtnTitle
               otherButtonTitles:(NSString *)otherBtnTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
