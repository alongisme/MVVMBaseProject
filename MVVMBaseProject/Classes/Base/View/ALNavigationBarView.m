//
//  ALNavigationBarView.m
//  MVVMBaseProject
//
//  Created by along on 2017/6/14.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNavigationBarView.h"

@interface ALNavigationBarView ()
@property (nonatomic, strong) UINavigationItem *item;
@end

@implementation ALNavigationBarView

- (instancetype)init {
    if(self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.items = @[self.item];
    
    @weakify(self);
    [RACObserve(self, navigationTitle) subscribeNext:^(id x) {
        @strongify(self);
        if([x isVaild])
            self.item.title = x;
    }];
    
    [RACObserve(self, leftBarButtonItem) subscribeNext:^(id x) {
        @strongify(self);
        if([x isVaild])
            self.item.leftBarButtonItem = x;
    }];
    
    [RACObserve(self, rightBarButtonItem) subscribeNext:^(id x) {
        @strongify(self);
        if([x isVaild])
            self.item.rightBarButtonItem = x;
    }];
    
}

- (UINavigationItem *)item {
    if(!_item) {
        _item = [[UINavigationItem alloc] initWithTitle:@""];
    }
    return _item;
}
@end
