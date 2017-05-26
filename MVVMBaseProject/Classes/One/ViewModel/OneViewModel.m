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
    return [[self.services.networkService requestDataWithUrl:@"/testData" params:@{}] map:^id(NSDictionary *dataSource) {
        NSArray *chaptersArr = [dataSource jk_arrayForKey:@"data"];
//        J_TruncateTable(OneModel);
        return [[chaptersArr.rac_sequence map:^id(id value) {
            OneModel *model = [OneModel mj_objectWithKeyValues:value];
//            J_Insert(model).updateResult;
            return model;
        }] array];
    }];
}

- (RACSignal *)requestLoadMoreDataSignal {
    return [[self.services.networkService requestDataWithUrl:@"/testData" params:@{@"nextPage":@(self.nextPage)}] map:^id(NSDictionary *dataSource) {
        NSArray *chaptersArr = [dataSource jk_arrayForKey:@"data"];
        return [[chaptersArr.rac_sequence map:^id(id value) {
            OneModel *model = [OneModel mj_objectWithKeyValues:value];
//            OneModel *model = [OneModel mj_objectWithKeyValues:value];
//            J_Insert(model).updateResult;
            return model;
        }] array];
    }];
}

@end
