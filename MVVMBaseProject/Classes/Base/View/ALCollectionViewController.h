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
//列表
@property (nonatomic, strong) UICollectionView *collection;
//没有数据时 提示的文字
@property (nonatomic, strong) NSString *emptyDataTitle;
//刷新
- (void)reloadData;
//初始化cell
- (UICollectionViewCell *)collection:(UICollectionView *)collection dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
//自定义数据绑定
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end
