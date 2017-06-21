//
//  EightView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "EightView.h"

@interface EightView ()
@property (nonatomic, strong) UILabel *dateLab;
@end

@implementation EightView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.eightName;
    self.dateLab.text = model.eightValue;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(@-20);
    }];
}

- (UILabel *)dateLab {
    if(!_dateLab) {
        _dateLab = [UILabel new];
        _dateLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:_dateLab];
    }
    return _dateLab;
}
@end
