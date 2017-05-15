//
//  TwoView.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

#import "TwoView.h"

@interface TwoView ()

@end

@implementation TwoView

- (void)BindModel:(ThreeModel *)model {
    self.nameLab.text = model.twoName;
    
}

@end

