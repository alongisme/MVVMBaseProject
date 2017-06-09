//
//  UIView+HUD.m
//  MVVNBaseProject
//
//  Created by along on 2016/12/15.
//  Copyright © 2016年 along. All rights reserved.
//

#import "UIView+HUD.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>

#define DefaultTimeInterval 1.5

@interface UIView ()
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) MBProgressHUD *windowHud;
@end

static const void *indieBandHudKey = &indieBandHudKey;
static const void *indieBandWindowHudKey = &indieBandWindowHudKey;


@implementation UIView (UIView_HUD)

- (MBProgressHUD *)hud {
    return objc_getAssociatedObject(self, indieBandHudKey);
}

- (void)setHud:(MBProgressHUD *)hud {
    objc_setAssociatedObject(self, indieBandHudKey, hud, OBJC_ASSOCIATION_RETAIN);
}

- (void)setWindowHud:(MBProgressHUD *)windowHud {
    objc_setAssociatedObject(self, indieBandWindowHudKey, windowHud, OBJC_ASSOCIATION_RETAIN);
}

- (MBProgressHUD *)windowHud {
    return objc_getAssociatedObject(self, indieBandWindowHudKey);
}

- (void)showHud {
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    //有导航栏
    self.hud.offset = CGPointMake(0, -64/2);
    [self.hud showAnimated:YES];
}

- (void)hideHud {
    if([self.hud isVaild]) {
        [self.hud hideAnimated:YES];
    }
}

- (void)showHudInWindow {
    self.windowHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];
    [self.windowHud showAnimated:YES];
}

- (void)hideHudInWindow {
    [self.windowHud hideAnimated:YES];
}

- (void)showHudError:(NSString *)error {
    [self showHudError:error delay:DefaultTimeInterval];
}

- (void)showHudSuccess:(NSString *)success {
    [self showHudSuccess:success delay:DefaultTimeInterval];
}

- (void)showHudInWindowError:(NSString *)error {
    [self showHudInWindowError:error delay:DefaultTimeInterval];
}

- (void)showHudInWindowSuccess:(NSString *)success {
    [self showHudInWindowSuccess:success delay:DefaultTimeInterval];
}

- (void)showHudError:(NSString *)error delay:(float)delay {
    self.hud = [self showIcon:@"MBProgressHUD.bundle/error@2x.png" message:error delay:delay view:self];
}

- (void)showHudSuccess:(NSString *)success delay:(float)delay {
   self.hud = [self showIcon:@"MBProgressHUD.bundle/success@2x.png" message:success delay:delay view:self];
}

- (void)showHudInWindowError:(NSString *)error delay:(float)delay {
   self.windowHud = [self showIcon:@"MBProgressHUD.bundle/error@2x.png" message:error delay:delay view:[UIApplication sharedApplication].windows.lastObject];
}

- (void)showHudInWindowSuccess:(NSString *)success delay:(float)delay {
   self.windowHud = [self showIcon:@"MBProgressHUD.bundle/success@2x.png" message:success delay:delay view:[UIApplication sharedApplication].windows.lastObject];
}

- (MBProgressHUD *)showIcon:(NSString *)icon message:(NSString *)message delay:(float)delay view:(UIView *)view {
    if (delay <= 0) {
        NSLog(@"delay <= 0");
        return nil;
    }

    [self hideHud];
    
    MBProgressHUD *Hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //有导航拦
    Hud.offset = CGPointMake(0, -64/2);
    Hud.label.text = message;
    Hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:icon]];
    Hud.mode = MBProgressHUDModeCustomView;
    Hud.removeFromSuperViewOnHide = YES;
    [Hud hideAnimated:YES afterDelay:delay];
    
    return Hud;
}
@end
