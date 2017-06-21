//
//  ALAlertController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

typedef NS_ENUM(NSInteger, ALAlertViewActionStyle) {
    ALAlertViewActionStyleDefault = 0,
    ALAlertViewActionStyleCancel,
    ALAlertViewActionStyleDestructive
};

@interface ALAlertController : NSObject

+ (RACSignal *)SiganlShowAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle buttonStyle:(ALAlertViewActionStyle)buttonStyle;

+ (RACSignal *)SignalShowAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle destructiveButtonTitle:(NSString *)destructiveBtnTitle otherButtonTitles:(NSArray *)otherBtnTitles;

+ (RACSignal *)SignalShowAlertTextFieldViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSArray *)otherBtnTitle;

+ (RACSignal *)SignalShowAlertActionSheetViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle buttonStyle:(ALAlertViewActionStyle)buttonStyle;

+ (RACSignal *)SignalShowAlertActionSheetWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message destructiveButtonTitle:(NSString *)destructiveBtnTitle cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSArray *)otherBtnTitles;
@end
