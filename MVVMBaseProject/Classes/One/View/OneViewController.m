//
//  OneViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "OneViewController.h"
#import "OneViewModel.h"
#import "OneCollectionViewCell.h"

@interface OneViewController ()
@property (nonatomic, strong) OneViewModel *viewModel;
@end

@implementation OneViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collection registerClass:[OneCollectionViewCell class] forCellWithReuseIdentifier:@"oneCollectionCellIdentifier"];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    [self.collection.mj_header beginRefreshing];
}

- (UICollectionViewCell *)collection:(UICollectionView *)collection dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [collection dequeueReusableCellWithReuseIdentifier:@"oneCollectionCellIdentifier" forIndexPath:indexPath];
}

- (void)configureCell:(OneCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(OneViewModel *)object {
    [cell bindViewModel:object];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width/2, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
@end
