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
    //标题
    [RACObserve(self, navigationTitle) subscribeNext:^(id x) {
        @strongify(self);
        self.item.title = x;
    }];
    //左按钮
    [RACObserve(self, leftBarButtonItem) subscribeNext:^(id x) {
        @strongify(self);
        self.item.leftBarButtonItem = x;
    }];
    //右按钮
    [RACObserve(self, rightBarButtonItem) subscribeNext:^(id x) {
        @strongify(self);
        self.item.rightBarButtonItem = x;
    }];
    //左按钮组
    [RACObserve(self, leftBarButtonItems) subscribeNext:^(id x) {
        @strongify(self);
        self.item.leftBarButtonItems = x;
    }];
    //右按钮组
    [RACObserve(self, rightBarButtonItems) subscribeNext:^(id x) {
        @strongify(self);
        self.item.rightBarButtonItems = x;
    }];
}

#pragma mark lazy load
- (UINavigationItem *)item {
    if(!_item) {
        _item = [[UINavigationItem alloc] initWithTitle:@""];
    }
    return _item;
}
@end
