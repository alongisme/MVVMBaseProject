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
    
    self.nextPage = 0;
    self.pageSize = 10;
    
    @weakify(self);
    [self.requestRemoteDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self);
        self.dataSource = @[array];
    }];
    
    [self.requestLoadMoreDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self);
        NSMutableArray *temp = [[[self.dataSource jk_arrayWithIndex:0] subarrayWithRange:NSMakeRange(0, self.nextPage * self.pageSize)] mutableCopy];
        [temp addObjectsFromArray:array];
        self.dataSource = @[temp];
    }];
    
    self.didSelectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self);
        NSLog(@"%@",indexPath);
        
        return [RACSignal empty];
    }];
    
}

- (RACSignal *)requestRemoteDataSignal {
    self.nextPage = 0;
    return [[self.services.networkService requestDataWithUrl:[Request_Domain stringByAppendingString:@"/testData"] params:@{@"nextPage":@(self.nextPage),@"pageSize":@(self.pageSize)}] map:^id(NSDictionary *dataSource) {
//        NSArray *chaptersArr = [dataSource jk_arrayForKey:@"object"];
//        J_TruncateTable(OneModel);
        return [[dataSource.rac_sequence map:^id(id value) {
            OneModel *model = [OneModel mj_objectWithKeyValues:value];
//            J_Insert(model).updateResult;
            return model;
        }] array];
    }];
}

- (RACSignal *)requestLoadMoreDataSignal {
    if(((NSArray *)self.dataSource[0]).count % self.pageSize == 0)
        self.nextPage++;
    return [[self.services.networkService requestDataWithUrl:[Request_Domain stringByAppendingString:@"/testData"] params:@{@"nextPage":@(self.nextPage),@"pageSize":@(self.pageSize)}] map:^id(NSDictionary *dataSource) {
        return [[dataSource.rac_sequence map:^id(id value) {
            OneModel *model = [OneModel mj_objectWithKeyValues:value];
//            OneModel *model = [OneModel mj_objectWithKeyValues:value];
//            J_Insert(model).updateResult;
            return model;
        }] array];
    }];
}

@end
