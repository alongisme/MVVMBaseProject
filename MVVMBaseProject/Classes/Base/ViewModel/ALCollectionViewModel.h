//
//  ALCollectionViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALCollectionViewModel : ALBaseViewModel
@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, copy) NSArray *sectionIndexTitles;

@property (nonatomic, assign) NSUInteger nextPage;

@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldPullDownLoadMore;

@property (nonatomic, copy) NSString *emptyDataTitle;

@property (nonatomic, strong) RACCommand *didSelectCommand;
@property (nonatomic, strong) RACCommand *requestRemoteDataCommand;
@property (nonatomic, strong) RACCommand *requestLoadMoreDataCommand;

- (id)fetchLocalData;

- (RACSignal *)requestRemoteDataSignal;

- (RACSignal *)requestLoadMoreDataSignal;
@end
