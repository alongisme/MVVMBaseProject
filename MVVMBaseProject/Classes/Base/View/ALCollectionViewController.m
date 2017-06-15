//
//  ALCollectionViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALCollectionViewController.h"
#import "ALCollectionViewModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NSString * const ALCollectionViewControllerLayoutSizeForItem = @"ALCollectionViewControllerLayoutSizeForItem";
NSString * const ALCollectionViewControllerLayoutInsetForSection = @"ALCollectionViewControllerLayoutInsetForSection";
NSString * const ALCollectionViewControllerLayoutMinimumLineSpacingForSection = @"ALCollectionViewControllerLayoutMinimumLineSpacingForSection";
NSString * const ALCollectionViewControllerLayoutMinimumInteritemSpacingForSection = @"ALCollectionViewControllerLayoutMinimumInteritemSpacingForSection";

@interface ALCollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) ALCollectionViewModel *viewModel;
@property (nonatomic, strong) UICollectionView *alCollectionView;
@property (nonatomic, strong) NSDictionary *itemLayoutOptionDictionary;
@end

@implementation ALCollectionViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collection = self.alCollectionView;
    
    [self.alCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ALCollectionCellIdentifier"];
    
    @weakify(self);
    if(self.viewModel.shouldPullToRefresh) {
        self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.requestRemoteDataCommand execute:@1];
        }];
        
        [[self.viewModel.requestRemoteDataCommand.executing skip:1] subscribeNext:^(NSNumber *executing) {
            @strongify(self);
            if(executing.boolValue) {
                [self.collection.mj_header beginRefreshing];
            }
            else {
                [self.collection.mj_header endRefreshing];
            }
        }];
    }
    
    if(self.viewModel.shouldPullDownLoadMore) {
        self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self.viewModel.requestLoadMoreDataCommand execute:@1];
        }];
        
        [[self.viewModel.requestLoadMoreDataCommand.executing skip:1] subscribeNext:^(NSNumber *executing) {
            @strongify(self);
            if(executing.boolValue) {
                [self.collection.mj_footer beginRefreshing];
            }
            else {
                [self.collection.mj_footer endRefreshing];
            }
        }];
    }
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

- (NSDictionary *)UICollectionViewDelegateFlowLayoutOption {return nil;}

- (void)dealloc {
    self.collection.dataSource = nil;
    self.collection.delegate = nil;
    self.collection.emptyDataSetDelegate = nil;
    self.collection.emptyDataSetSource = nil;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[self UICollectionViewDelegateFlowLayoutOption][ALCollectionViewControllerLayoutSizeForItem] CGSizeValue];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [[self UICollectionViewDelegateFlowLayoutOption][ALCollectionViewControllerLayoutInsetForSection] UIEdgeInsetsValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [[self UICollectionViewDelegateFlowLayoutOption][ALCollectionViewControllerLayoutMinimumLineSpacingForSection] floatValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [[self UICollectionViewDelegateFlowLayoutOption][ALCollectionViewControllerLayoutMinimumInteritemSpacingForSection] floatValue];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id itemArray = self.viewModel.dataSource[section];
    if(![itemArray isVaild])
        return 0;
    NSParameterAssert([itemArray isKindOfClass:[NSArray class]]);
    return [(NSArray *)itemArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self collection:collectionView dequeueReusableCellWithIdentifier:@"ALCollectionCellIdentifier" forIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

- (UICollectionViewCell *)collection:(UICollectionView *)collection dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [collection dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

- (void)reloadData {
    [self.collection reloadData];
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
    [self.collection.mj_header beginRefreshing];
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(ALNavigationBarHeight - ALTabBarHeight) / 2);
}

- (UICollectionView *)alCollectionView {
    if(!_alCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _alCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _alCollectionView.backgroundColor = [UIColor clearColor];
        _alCollectionView.delegate = self;
        _alCollectionView.dataSource = self;
        _alCollectionView.emptyDataSetSource = self;
        _alCollectionView.emptyDataSetDelegate = self;
        [self.view addSubview:_alCollectionView];
        
        [_alCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ALNavigationBarHeight);
            make.width.equalTo(self.view);
            make.centerX.equalTo(self.view);
            make.height.mas_equalTo(self.view.bounds.size.height - ALNavigationBarHeight - ALTabBarHeight);
        }];
    }
    return _alCollectionView;
}
@end
