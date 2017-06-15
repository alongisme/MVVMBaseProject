//
//  ALNavigationBarView.m
//  MVVMBaseProject
//
//  Created by along on 2017/6/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNavigationBarView.h"

@interface ALNavigationBarView ()
@property (nonatomic, strong) UILabel *titleV;

@property (nonatomic, strong) UIImageView *backgroundIV;

@end

@implementation ALNavigationBarView

- (instancetype)init {
    if(self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor lightGrayColor];
    
    @weakify(self);
    [self.backgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(10);
        make.left.equalTo(@15);
    }];
    
    [RACObserve(self, title) subscribeNext:^(NSString *text) {
        if([text isVaild]) {
            self.titleV.text = text;
            [self.titleV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self).offset(10);
            }];
        }
    }];
    
    [RACObserve(self, hideBackBtn) subscribeNext:^(NSNumber *stateNumber) {
        @strongify(self);
        self.backBtn.hidden = stateNumber.boolValue;
    }];
}

#pragma makr lazy load
- (UIImageView *)backgroundIV {
    if(!_backgroundIV) {
        _backgroundIV = [UIImageView new];
        _backgroundIV.contentMode = UIViewContentModeScaleAspectFit;
        _backgroundIV.autoresizesSubviews = YES;
        _backgroundIV.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_backgroundIV];
    }
    return _backgroundIV;
}

- (UILabel *)titleV {
    if(!_titleV) {
        _titleV = [UILabel new];
        _titleV.textAlignment = NSTextAlignmentCenter;
        _titleV.textColor = [UIColor blackColor];
        [self addSubview:_titleV];
    }
    return _titleV;
}

- (UIButton *)backBtn {
    if(!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}
@end
