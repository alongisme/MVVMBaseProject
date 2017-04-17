//
//  OneViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "OneViewModel.h"
#import "TwoViewModel.h"
#import "OneModel.h"

@interface OneViewModel ()
@end

@implementation OneViewModel

- (void)initialize {
    [super initialize];
    
    self.shouldPullToRefresh = YES;
    self.shouldPullDownLoadMore = YES;
    
    @weakify(self);
    [self.requestRemoteDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self);
        self.dataSource = @[array];
    }];
    
    [self.requestLoadMoreDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self);
        NSMutableArray *temp = [self.dataSource[0] mutableCopy];
        [temp addObjectsFromArray:array];
        self.dataSource = @[temp];
    }];
    
    self.didSelectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        NSLog(@"%@",indexPath);
        return [RACSignal empty];
    }];
    
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.networkService requestDataWithUrl:@"/chapter/home" params:@{}] map:^id(NSDictionary *dataSource) {
        NSDictionary *dataDic = dataSource[@"data"];
        NSArray *chaptersArr = dataDic[@"chapters"];
        return [[chaptersArr.rac_sequence map:^id(id value) {
            return [OneModel mj_objectWithKeyValues:value];
        }] array];
    }];
}

- (RACSignal *)requestLoadMoreDataSignal {
    return [[self.services.networkService requestDataWithUrl:@"/chapter/home" params:@{@"nextPage":@(self.nextPage)}] map:^id(NSDictionary *dataSource) {
        NSDictionary *dataDic = dataSource[@"data"];
        NSArray *chaptersArr = dataDic[@"chapters"];
        return [[chaptersArr.rac_sequence map:^id(id value) {
            return [OneModel mj_objectWithKeyValues:value];
        }] array];
    }];
}

@end