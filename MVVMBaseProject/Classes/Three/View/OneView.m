//
//  OneView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "OneView.h"

@interface OneView ()
@property (nonatomic, strong) UIImageView *headIV;
@end

@implementation OneView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.oneName;
    UIImage *img = [UIImage imageNamed:model.oneValue];
    self.headIV.image = img;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.nameLab.mas_right).offset(10);
        make.height.width.equalTo(self.mas_height).multipliedBy(0.7);
    }];
}

- (UIImageView *)headIV {
    if(!_headIV) {
        _headIV = [UIImageView new];
        [self addSubview:_headIV];
    }
    return _headIV;
}
@end
