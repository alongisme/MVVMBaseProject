//
//  NineView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "NineView.h"

@implementation NineView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.nineName;
}

@end
