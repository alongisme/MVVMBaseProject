//
//  ALBaseThreeView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/28.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseThreeView.h"

@implementation ALBaseThreeView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self);
    }];
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

@end
