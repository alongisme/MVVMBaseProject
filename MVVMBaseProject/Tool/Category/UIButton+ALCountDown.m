//
//  UIButton+countDown.m
//  NetworkEgOc
//
//  Created by iosdev on 15/3/17.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import "UIButton+ALCountDown.h"

@implementation UIButton (ALCountDown)

- (void)getCodeTime {
    @weakify(self);
    __block NSUInteger interval = 59;
    [[[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] take:60] doNext:^(id x) {
        @strongify(self);
        if(interval >= 59) {
            self.userInteractionEnabled = NO;
            self.selected = YES;
        }
    }] subscribeNext:^(id x) {
        @strongify(self);
        NSString *strTime = [NSString stringWithFormat:@"%.2ld", interval];
        [self setTitle:[NSString stringWithFormat:@"重新获取(%@)",strTime] forState:UIControlStateNormal];
        interval--;
    } completed:^{
        @strongify(self);
        [self setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        self.selected = NO;
    }];
}
@end
