//
//  ALCollectionViewController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"

UIKIT_EXTERN NSString * const ALCollectionViewControllerLayoutSizeForItem;
UIKIT_EXTERN NSString * const ALCollectionViewControllerLayoutInsetForSection;
UIKIT_EXTERN NSString * const ALCollectionViewControllerLayoutMinimumLineSpacingForSection;
UIKIT_EXTERN NSString * const ALCollectionViewControllerLayoutMinimumInteritemSpacingForSection;

@interface ALCollectionViewController : ALBaseViewController 
@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) NSString *emptyDataTitle;

- (void)reloadData;
- (UICollectionViewCell *)collection:(UICollectionView *)collection dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end
