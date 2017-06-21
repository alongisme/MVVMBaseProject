//
//  OneCollectionViewCell.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "OneCollectionViewCell.h"
#import "OneModel.h"

@interface OneCollectionViewCell ()
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation OneCollectionViewCell

- (void)BindModel:(OneModel *)viewModel {
    self.titleLab.text = viewModel.chapterName;
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:[Request_Image stringByAppendingString:viewModel.chapterImage]]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.size.equalTo(self.contentView.mas_height).multipliedBy(0.5);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.iconIV.mas_bottom).offset(6);
    }];
    
}

- (UIImageView *)iconIV {
    if(!_iconIV) {
        _iconIV = [UIImageView new];
        [self.contentView addSubview:_iconIV];
    }
    return _iconIV;
}

- (UILabel *)titleLab {
    if(!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLab];
    }
    return _titleLab;
}

@end
