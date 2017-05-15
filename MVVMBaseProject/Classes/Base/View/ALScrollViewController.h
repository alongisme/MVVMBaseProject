//
//  ALScrollViewController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
/*
 ALScrollViewSize 显示view的大小 默认 0
 ALScrollViewOffSet 显示view的偏移 默认0
 ALScrollViewLineSpacing 显示view的间距 水平 左右间距 垂直 上下间距 默认0
 ALScrollViewBackgroundColor 显示view的背景颜色 默认白色
 ALScrollViewDidSelected 显示view是否可以点击 默认head和foot不能点击 item能点击
 */

#define ALOptionHead(size,offset,spacing,bgcolor,didSelected) @{ \
ALScrollViewSizeForHead : [NSValue valueWithCGSize:size], \
ALScrollViewOffSetForHead : [NSValue valueWithCGPoint:offset], \
ALScrollViewLineSpacingForHead : spacing, \
ALScrollViewBackgroundColorForHead : bgcolor, \
ALScrollViewDidSelectedForHead : didSelected \
}; \

#define ALOptionItem(size,offset,spacing,bgcolor,didSelected) @{ \
ALScrollViewSizeForItem : [NSValue valueWithCGSize:size], \
ALScrollViewOffSetForItem : [NSValue valueWithCGPoint:offset], \
ALScrollViewLineSpacingForItem : spacing, \
ALScrollViewBackgroundColorForItem : bgcolor, \
ALScrollViewDidSelectedForItem : didSelected \
}; \

#define ALOptionFoot(size,offset,spacing,bgcolor,didSelected) @{ \
ALScrollViewSizeForFoot : [NSValue valueWithCGSize:size], \
ALScrollViewOffSetForFoot : [NSValue valueWithCGPoint:offset], \
ALScrollViewLineSpacingForFoot : spacing, \
ALScrollViewBackgroundColorForFoot : bgcolor, \
ALScrollViewDidSelectedForFoot : didSelected \
}; \

#define ALOptionBottonLine(size,offset,bgcolor) @{ \
ALScrollViewSizeForBottomLineView : [NSValue valueWithCGSize:size], \
ALScrollViewOffSetForBottomLineView : [NSValue valueWithCGPoint:offset], \
ALScrollViewBackgroundColorBottomLineView : bgcolor \
}; \

//head
UIKIT_EXTERN NSString * const ALScrollViewSizeForHead;
UIKIT_EXTERN NSString * const ALScrollViewOffSetForHead;
UIKIT_EXTERN NSString * const ALScrollViewLineSpacingForHead;
UIKIT_EXTERN NSString * const ALScrollViewBackgroundColorForHead;
UIKIT_EXTERN NSString * const ALScrollViewDidSelectedForHead;

//item
UIKIT_EXTERN NSString * const ALScrollViewSizeForItem;
UIKIT_EXTERN NSString * const ALScrollViewOffSetForItem;
UIKIT_EXTERN NSString * const ALScrollViewLineSpacingForItem;
UIKIT_EXTERN NSString * const ALScrollViewBackgroundColorForItem;
UIKIT_EXTERN NSString * const ALScrollViewDidSelectedForItem;

//foot
UIKIT_EXTERN NSString * const ALScrollViewSizeForFoot;
UIKIT_EXTERN NSString * const ALScrollViewOffSetForFoot;
UIKIT_EXTERN NSString * const ALScrollViewLineSpacingForFoot;
UIKIT_EXTERN NSString * const ALScrollViewBackgroundColorForFoot;
UIKIT_EXTERN NSString * const ALScrollViewDidSelectedForFoot;

//bottonLineView
UIKIT_EXTERN NSString * const ALScrollViewSizeForBottomLineView;
UIKIT_EXTERN NSString * const ALScrollViewOffSetForBottomLineView;
UIKIT_EXTERN NSString * const ALScrollViewBackgroundColorBottomLineView;

typedef NS_ENUM(NSInteger, ALScrollViewScrollDirection) {
    ALScrollViewScrollDirectionDirectionVertical, //垂直滑动
    ALScrollViewScrollDirectionDirectionHorizontal //水平滑动
};

@interface ALScrollViewController : ALBaseViewController
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 空数据显示文字
 */
@property (nonatomic, strong) NSString *emptyDataTitle;


/**
 item数量 item数量决定了会有多少view 一个item对应会有head 和 foot

 @return 数量
 */
- (NSUInteger)itemNumber;

/**
 滑动方向

 @return 垂直 or 水平
 */
- (ALScrollViewScrollDirection)scrollDirection;

/**
 headView的属性字典

 @param index 第几个
 @return 字典
 */
- (NSDictionary *)headOptionAtIndex:(NSUInteger)index;

/**
 itemView的属性字典

 @param index 第几个
 @return 字典
 */
- (NSDictionary *)itemOptionAtIndex:(NSUInteger)index;

/**
 footView的属性字典

 @param index 第几个
 @return 字典
 */
- (NSDictionary *)footOptionAtIndex:(NSUInteger)index;

/**
 item底部分割线
 
 @param index 第几个
 @return 字典
 */
- (NSDictionary *)itemBottomLineViewAtIndex:(NSUInteger)index;

/**
 headView

 @param index 第几个
 @return view
 */
- (UIView *)headViewForItemAtIndex:(NSUInteger)index;

/**
 itemView

 @param index 第几个
 @return view
 */
- (UIView *)itemAtIndex:(NSUInteger)index;

/**
 footView

 @param index 第几个
 @return view
 */
- (UIView *)footViewForItemAtIndex:(NSUInteger)index;

/**
 刷新
 */
- (void)reloadData;
@end
