//
//  ALBaseViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"
#import "ALViewModelServices.h"

@implementation ALBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    ALBaseViewModel *baseViewModel = [super allocWithZone:zone];
    
    @weakify(baseViewModel);
    [[baseViewModel rac_signalForSelector:@selector(initWithServices:params:)] subscribeNext:^(id x) {
        @strongify(baseViewModel);
        [baseViewModel initialize];
    }];
    return baseViewModel;
}

- (instancetype)initWithServices:(id<ALViewModelServices>)services params:(NSDictionary *)params {
    if(self = [super init]) {
        self.services = services;
        self.params = params;
    }
    return self;
}

- (void)initialize {
    //赋值标题
    self.title = self.params[@"title"];
    
    @weakify(self);
    //数据获取
    self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [[self requestDataSignal] takeUntil:self.rac_willDeallocSignal];
    }];
    
    //导航栏返回按钮 点击信号 默认做统一返回处理
    [[self.backBtnItemClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.services popViewModelAnimated:YES];
    }];
}

- (RACSignal *)requestDataSignal {return [RACSignal empty];}

#pragma mark lazy load
- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (RACReplaySubject *)backBtnItemClick {
    if(!_backBtnItemClick) {
        _backBtnItemClick = [RACReplaySubject replaySubjectWithCapacity:1];
    }
    return _backBtnItemClick;
}

- (RACReplaySubject *)touchReplaySubject {
    if(!_touchReplaySubject) {
        _touchReplaySubject = [RACReplaySubject replaySubjectWithCapacity:4];
    }
    return _touchReplaySubject;
}
@end
