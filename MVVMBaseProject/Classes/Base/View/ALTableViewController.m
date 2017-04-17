//
//  ALTableViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALTableViewController.h"
#import "ALTableViewModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface ALTableViewController () <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ALTableViewModel *viewModel;
@property (nonatomic, strong) UITableView *alTableView;
@end

@implementation ALTableViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = self.alTableView;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellIdentifier"];

    @weakify(self);
    if(self.viewModel.shouldPullToRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.requestRemoteDataCommand execute:@1];
        }];
        
        [[self.viewModel.requestRemoteDataCommand.executing skip:1] subscribeNext:^(NSNumber *executing) {
            @strongify(self);
            if(executing.boolValue) {
                [self.tableView.mj_header beginRefreshing];
            }
            else {
                [self.tableView.mj_header endRefreshing];
            }
        }];
    }
    
    if(self.viewModel.shouldPullDownLoadMore) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.requestLoadMoreDataCommand execute:@1];
        }];
        
        [[self.viewModel.requestLoadMoreDataCommand.executing skip:1] subscribeNext:^(NSNumber *executing) {
            @strongify(self);
            if(executing.boolValue) {
                [self.tableView.mj_footer beginRefreshing];
            }
            else {
                [self.tableView.mj_footer endRefreshing];
            }
        }];
    }
}

- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _alTableView.emptyDataSetDelegate = nil;
    _alTableView.emptyDataSetSource = nil;
}

- (void)bindViewModel {
    [super bindViewModel];

    RAC(self,emptyDataTitle) = [RACObserve(self.viewModel, emptyDataTitle) distinctUntilChanged];
    
    @weakify(self);
    [[[RACObserve(self.viewModel, dataSource) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        [self reloadData];
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCellIdentifier" forIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.viewModel.sectionIndexTitles.count) return nil;
    return self.viewModel.sectionIndexTitles[section];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if(_emptyDataTitle && _emptyDataTitle.length > 0) return [[NSAttributedString alloc] initWithString:_emptyDataTitle];
    return [[NSAttributedString alloc] initWithString:@"No Data"];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.viewModel.dataSource == nil || self.viewModel.dataSource.count == 0;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self.tableView.mj_header beginRefreshing];
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(self.tableView.contentInset.top - self.tableView.contentInset.bottom) / 2);
}

#pragma mark lazy load
- (UITableView *)alTableView {
    if(!_alTableView) {
        _alTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ALNavigationBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - ALNavigationBarHeight - ALTabBarHeight) style:UITableViewStylePlain];
        _alTableView.delegate = self;
        _alTableView.dataSource = self;
        _alTableView.emptyDataSetSource = self;
        _alTableView.emptyDataSetDelegate = self;
        _alTableView.tableFooterView = [UIView new];
        [self.view addSubview:_alTableView];
    }
    return _alTableView;
}
@end