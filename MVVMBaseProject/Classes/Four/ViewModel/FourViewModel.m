//
//  FourViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "FourViewModel.h"
#import "OneViewModel.h"

@implementation FourViewModel

- (void)initialize {
    [super initialize];
}

- (void)makeEventAvailable {
    @weakify(self);
    [self.touchBeginSignal subscribeNext:^(id x) {
        @strongify(self);
        OneViewModel *oneVM = [[OneViewModel alloc]initWithServices:self.services params:@{@"title":[NSString stringWithFormat:@"%@-one",self.title]}];
        [self.services pushViewModel:oneVM animated:YES];
    }];
}
@end
