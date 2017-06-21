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
    
    [self.collection.mj_header beginRefreshing];
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (UICollectionViewCell *)collection:(UICollectionView *)collection dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [collection dequeueReusableCellWithReuseIdentifier:@"oneCollectionCellIdentifier" forIndexPath:indexPath];
}

- (void)configureCell:(OneCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(OneViewModel *)object {
    [cell BindModel:object];
}

- (NSDictionary *)UICollectionViewDelegateFlowLayoutOption {
    return @{
             ALCollectionViewControllerLayoutSizeForItem : [NSValue valueWithCGSize:CGSizeMake(self.view.bounds.size.width/2, 100)],
             ALCollectionViewControllerLayoutInsetForSection : [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)],
             ALCollectionViewControllerLayoutMinimumLineSpacingForSection : @0,
             ALCollectionViewControllerLayoutMinimumInteritemSpacingForSection : @0
             };
}
@end
