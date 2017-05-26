//
//  TwoTableViewCell.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "TwoTableViewCell.h"
#import "TwoModel.h"

@interface TwoTableViewCell ()
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation TwoTableViewCell

- (void)BindModel:(TwoModel *)viewModel {
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:viewModel.chapterImage]];
    self.titleLab.text = viewModel.chapterName;
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(@15);
        make.size.equalTo(self.contentView.mas_height).multipliedBy(0.8);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconIV.mas_right).offset(10);
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
