//
//  SevenView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "SevenView.h"

@implementation SevenView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.sevenName;
}

@end
