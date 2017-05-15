//
//  ThreeView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ThreeView.h"

@implementation ThreeView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.threeName;
}

@end
