//
//  ALAlertController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAlertController.h"
#define  ALAlertShowTime 1.0

@implementation ALAlertController
// 单个或没有按钮
+ (RACSignal *)SiganlShowAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle buttonStyle:(ALAlertViewActionStyle)buttonStyle {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if (btnTitle.length) {
            UIAlertActionStyle actionStyle = (buttonStyle == ALAlertViewActionStyleDefault) ? UIAlertActionStyleDefault : ((buttonStyle ==  ALAlertViewActionStyleCancel) ? UIAlertActionStyleCancel : UIAlertActionStyleDestructive);
            UIAlertAction * alertAction = alertAction = [UIAlertAction actionWithTitle:btnTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
                [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:ALAlertShowTime];
                [subscriber sendCompleted];
            }];;
            [alertController addAction:alertAction];
            [viewController presentViewController:alertController animated:YES completion:nil];
        } else {
            [viewController presentViewController:alertController animated:YES completion:nil];
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:ALAlertShowTime];
            [subscriber sendCompleted];
        }
        
        return [RACDisposable disposableWithBlock:^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

// 单个或多个按钮
+ (RACSignal *)SignalShowAlertViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle destructiveButtonTitle:(NSString *)destructiveBtnTitle otherButtonTitles:(NSArray *)otherBtnTitles {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        //添加按钮
        if (cancelBtnTitle.length) {
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancelAction];
        }
        if (destructiveBtnTitle.length) {
            UIAlertAction * destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:@(-1)];
                [subscriber sendCompleted];
            }];
            [alertController addAction:destructiveAction];
        }
        if (otherBtnTitles.count > 0) {
            
            for (unsigned int i = 0; i < otherBtnTitles.count; i++) {
                UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherBtnTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [subscriber sendNext:@(i+1)];
                    [subscriber sendCompleted];
                }];
                [alertController addAction:otherActions];
            }
        }
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (!cancelBtnTitle.length && !destructiveBtnTitle.length && !otherBtnTitles) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:ALAlertShowTime];
        }
        
        return [RACDisposable disposableWithBlock:^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

// 有输入框

+ (RACSignal *)SignalShowAlertTextFieldViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSArray *)otherBtnTitle {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {

        }];
        if (cancelBtnTitle.length) {
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissAlertController:alertController];
            }];
            [alertController addAction:cancelAction];
        }
        if (otherBtnTitle.count > 0) {
            for (unsigned int i = 0; i < otherBtnTitle.count; i++) {
                UIAlertAction * otherAction = [UIAlertAction actionWithTitle:otherBtnTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [subscriber sendNext:@{@"selectedIndex":@(i),@"textFiledArray":alertController.textFields}];
                    [subscriber sendCompleted];
                }];
                [alertController addAction:otherAction];
            }
        }
        [viewController presentViewController:alertController animated:YES completion:nil];
        //如果没有按钮，自动延迟消失
        if (!cancelBtnTitle.length && otherBtnTitle.count == 0) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:ALAlertShowTime];
        }
        
        return [RACDisposable disposableWithBlock:^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}
// ======================================================================== ----- AlertView end----- ==================================================================================
#pragma mark ==== 点击事件 ======
+ (void)dismissAlertController:(UIAlertController *)alert {
    [alert dismissViewControllerAnimated:YES completion:nil];
}

// ======================================================================== -- ActionSheet Start -- ====================================================================================

+ (RACSignal *)SignalShowAlertActionSheetViewWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle buttonStyle:(ALAlertViewActionStyle)buttonStyle {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        UIAlertController * actionController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        if (btnTitle.length) {
            UIAlertActionStyle actionStyle = (buttonStyle == ALAlertViewActionStyleDefault) ? UIAlertActionStyleDefault : ((buttonStyle ==  ALAlertViewActionStyleCancel) ? UIAlertActionStyleCancel : UIAlertActionStyleDestructive);
            UIAlertAction * alertAction = alertAction = [UIAlertAction actionWithTitle:btnTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
                [self performSelector:@selector(dismissAlertController:) withObject:actionController afterDelay:ALAlertShowTime];
                [subscriber sendCompleted];
            }];;
            [actionController addAction:alertAction];
            [viewController presentViewController:actionController animated:YES completion:nil];
        } else {
            [viewController presentViewController:actionController animated:YES completion:nil];
            //如果没有按钮，自动延迟消失
            [self performSelector:@selector(dismissAlertController:) withObject:actionController afterDelay:ALAlertShowTime];
            [subscriber sendCompleted];
        }
        
        return [RACDisposable disposableWithBlock:^{
            [actionController dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}

+ (RACSignal *)SignalShowAlertActionSheetWith:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message destructiveButtonTitle:(NSString *)destructiveBtnTitle cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSArray *)otherBtnTitles {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        UIAlertController * actionController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        if (otherBtnTitles.count > 0)
        {
            for (unsigned int i = 0; i < otherBtnTitles.count; i++) {
                UIAlertAction * otherActions = [UIAlertAction actionWithTitle:otherBtnTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [subscriber sendNext:@(i + 1)];
                }];
                [actionController addAction:otherActions];
            }
        }
        [viewController presentViewController:actionController animated:YES completion:nil];
        
        if (cancelBtnTitle.length) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            [actionController addAction:cancelAction];
        }
        
        if (destructiveBtnTitle.length) {
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [subscriber sendNext:@-1];
            }];
            [actionController addAction:destructiveAction];
        }
        
        //如果没有按钮，自动延迟消失
        if (!cancelBtnTitle.length && !destructiveBtnTitle.length && !otherBtnTitles.count) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:actionController afterDelay:ALAlertShowTime];
            [subscriber sendCompleted];
        }
        
        return [RACDisposable disposableWithBlock:^{
            [actionController dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}
@end
