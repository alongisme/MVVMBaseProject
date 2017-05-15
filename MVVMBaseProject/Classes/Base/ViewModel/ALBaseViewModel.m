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

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (void)initialize {
    self.title = self.params[@"title"];
    
    @weakify(self);
    self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [[self requestDataSignal] takeUntil:self.rac_willDeallocSignal];
    }];
}

- (RACSignal *)requestDataSignal {return [RACSignal empty];}

- (void)makeEventAvailable {}
@end
