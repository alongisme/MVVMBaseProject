//
//  TenView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "TenView.h"

@implementation TenView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.tenName;
}

@end
