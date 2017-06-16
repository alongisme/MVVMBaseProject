//
//  ALTableViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALTableViewModel : ALBaseViewModel
//数据源
@property (nonatomic, copy) NSArray *dataSource;
//标题
@property (nonatomic, copy) NSArray *sectionIndexTitles;
//分页
@property (nonatomic, assign) NSUInteger nextPage;
//上下拉刷新加载开关
@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldPullDownLoadMore;
//空数据显示标题
@property (nonatomic, copy) NSString *emptyDataTitle;
//item点击
@property (nonatomic, strong) RACCommand *didSelectCommand;
//request data
@property (nonatomic, strong) RACCommand *requestRemoteDataCommand;
@property (nonatomic, strong) RACCommand *requestLoadMoreDataCommand;
//下拉刷新
- (RACSignal *)requestRemoteDataSignal;
//上拉加载
- (RACSignal *)requestLoadMoreDataSignal;
@end
