//
//  EightView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "EightView.h"

@implementation EightView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.eightName;
}

@end
