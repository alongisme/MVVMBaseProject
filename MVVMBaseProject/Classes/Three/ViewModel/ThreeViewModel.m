//
//  ThreeViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ThreeViewModel.h"
#import "FourViewModel.h"

@implementation ThreeViewModel

- (void)initialize {
    [super initialize];
    
}

- (void)makeEventAvailable {
    @weakify(self);
    [self.touchBeginSignal subscribeNext:^(id x) {
        @strongify(self);
        FourViewModel *oneVM = [[FourViewModel alloc]initWithServices:self.services params:@{@"title":[NSString stringWithFormat:@"%@-four",self.title]}];
        [self.services pushViewModel:oneVM animated:YES];
    }];
}
@end
