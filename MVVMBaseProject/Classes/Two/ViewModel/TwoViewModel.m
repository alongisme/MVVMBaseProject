//
//  TwoViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "TwoViewModel.h"
#import "ThreeViewModel.h"
#import "TwoModel.h"

@implementation TwoViewModel

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
    return [[self.services.networkService requestDataWithUrl:[Request_Domain stringByAppendingString:@"/testData"] params:@{}] map:^id(NSDictionary *dataSource) {
        //        NSArray *chaptersArr = [dataSource jk_arrayForKey:@"object"];
        //        J_TruncateTable(OneModel);
        return [[dataSource.rac_sequence map:^id(id value) {
            TwoModel *model = [TwoModel mj_objectWithKeyValues:value];
            //            J_Insert(model).updateResult;
            return model;
        }] array];
    }];
}

- (RACSignal *)requestLoadMoreDataSignal {
    return [[self.services.networkService requestDataWithUrl:@"/testData" params:@{@"nextPage":@(self.nextPage)}] map:^id(NSDictionary *dataSource) {
        NSArray *chaptersArr = [dataSource jk_arrayForKey:@"data"];
        return [[chaptersArr.rac_sequence map:^id(id value) {
            return [TwoModel mj_objectWithKeyValues:value];
        }] array];
    }];
}
@end
