//
//  ALScrollViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALScrollViewController.h"
#import "ALScrollViewModel.h"

//head
NSString * const ALScrollViewSizeForHead = @"ALScrollViewSizeForHead";
NSString * const ALScrollViewOffSetForHead = @"ALScrollViewOffSetForHead";
NSString * const ALScrollViewLineSpacingForHead = @"ALScrollViewLineSpacingForHead";
NSString * const ALScrollViewBackgroundColorForHead = @"ALScrollViewBackgroundColorForHead";
NSString * const ALScrollViewDidSelectedForHead = @"ALScrollViewDidSelectedForHead";


//item
NSString * const ALScrollViewSizeForItem = @"ALScrollViewSizeForItem";
NSString * const ALScrollViewOffSetForItem = @"ALScrollViewOffSetForItem";
NSString * const ALScrollViewLineSpacingForItem = @"ALScrollViewLineSpacingForItem";
NSString * const ALScrollViewBackgroundColorForItem = @"ALScrollViewBackgroundColorForItem";
NSString * const ALScrollViewDidSelectedForItem = @"ALScrollViewDidSelectedForItem";

//foot
NSString * const ALScrollViewSizeForFoot = @"ALScrollViewSizeForFoot";
NSString * const ALScrollViewOffSetForFoot = @"ALScrollViewOffSetForFoot";
NSString * const ALScrollViewLineSpacingForFoot = @"ALScrollViewLineSpacingForFoot";
NSString * const ALScrollViewBackgroundColorForFoot = @"ALScrollViewBackgroundColorForFoot";
NSString * const ALScrollViewDidSelectedForFoot = @"ALScrollViewDidSelectedForFoot";

//bottonLineView
NSString * const ALScrollViewSizeForBottomLineView = @"ALScrollViewSizeForBottomLineView";
NSString * const ALScrollViewOffSetForBottomLineView = @"ALScrollViewOffSetForBottomLineView";
NSString * const ALScrollViewBackgroundColorBottomLineView = @"ALScrollViewBackgroundColorBottomLineView";

@interface ALScrollViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *alScrollView;
@property (nonatomic, strong) ALScrollViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *headArray;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *footArray;
@end

@implementation ALScrollViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = self.alScrollView;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [[[RACObserve(self.viewModel, dataModel) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(id x) {
         @strongify(self)
         [self reloadData];
     }];
}

- (void)initSubviews {
    
    if([self itemNumber] > 50) NSAssert(NO, @"要创建的view太多 不建议使用，建议使用tablew 或者collectionView");
    
    CGFloat maxValue = 0;
    
    for (unsigned int i = 0; i < [self itemNumber]; i++) {
        UIView *headItem = [self headViewForItemAtIndex:i];
        UIView *item = [self itemAtIndex:i];
        UIView *lineView = [UIView new];
        UIView *footItem = [self footViewForItemAtIndex:i];
        
        if (!headItem && !item && !footItem) {
            return;
        }
        
        CGSize headSize = [[self headOptionAtIndex:i][ALScrollViewSizeForHead] CGSizeValue];
        CGPoint headOffsetPoint = [[self headOptionAtIndex:i][ALScrollViewOffSetForHead] CGPointValue];
        NSInteger headLineSpacing = [[self headOptionAtIndex:i][ALScrollViewLineSpacingForHead] integerValue];
        UIColor *headBackgroundColor = [self headOptionAtIndex:i][ALScrollViewBackgroundColorForHead];
        NSNumber *headDidSelected = [self headOptionAtIndex:i][ALScrollViewDidSelectedForHead];
        
        CGSize itemSize = [[self itemOptionAtIndex:i][ALScrollViewSizeForItem] CGSizeValue];
        CGPoint itemOffsetPoint = [[self itemOptionAtIndex:i][ALScrollViewOffSetForItem] CGPointValue];
        NSInteger itemLineSpacing = [[self itemOptionAtIndex:i][ALScrollViewLineSpacingForItem] integerValue];
        UIColor *itemBackgroundColor = [self itemOptionAtIndex:i][ALScrollViewBackgroundColorForItem];
        NSNumber *itemDidSelected = [self itemOptionAtIndex:i][ALScrollViewDidSelectedForItem];

        CGSize bottomLineViewSize = [[self itemBottomLineViewAtIndex:i][ALScrollViewSizeForBottomLineView] CGSizeValue];
        CGPoint bottomLineViewOffsetPoint = [[self itemBottomLineViewAtIndex:i][ALScrollViewOffSetForBottomLineView] CGPointValue];
        UIColor *bottomLineViewBackgroundColor = [self itemBottomLineViewAtIndex:i][ALScrollViewBackgroundColorBottomLineView];

        CGSize footSize = [[self footOptionAtIndex:i][ALScrollViewSizeForFoot] CGSizeValue];
        CGPoint footOffsetPoint = [[self footOptionAtIndex:i][ALScrollViewOffSetForFoot] CGPointValue];
        NSInteger footLineSpacing = [[self footOptionAtIndex:i][ALScrollViewLineSpacingForFoot] integerValue];
        UIColor *footBackgroundColor = [self footOptionAtIndex:i][ALScrollViewBackgroundColorForFoot];
        NSNumber *footDidSelected = [self footOptionAtIndex:i][ALScrollViewDidSelectedForFoot];
        
        if([self scrollDirection] == ALScrollViewScrollDirectionDirectionVertical) {
            headItem.frame = CGRectMake(headOffsetPoint.x, maxValue + headLineSpacing + headOffsetPoint.y, headSize.width, headSize.height);
            if(headItem) maxValue = CGRectGetMaxY(headItem.frame);

            item.frame = CGRectMake(itemOffsetPoint.x, maxValue + itemLineSpacing + headOffsetPoint.y, itemSize.width, itemSize.height);
            if(item) maxValue = CGRectGetMaxY(item.frame);

            lineView.frame = CGRectMake(0, maxValue , self.scrollView.bounds.size.width,bottomLineViewSize.height);
            if(lineView) maxValue = CGRectGetMaxY(lineView.frame);

            footItem.frame = CGRectMake(footOffsetPoint.x, maxValue + footLineSpacing + footOffsetPoint.y, footSize.width, footSize.height);
            if(footItem) maxValue = CGRectGetMaxY(footItem.frame);
        } else {
            item.frame = CGRectMake(i * (itemSize.width + itemLineSpacing) + (i + 1) * itemOffsetPoint.x, itemOffsetPoint.y, itemSize.width, itemSize.height);
        }
        
        UIView *line = [UIView new];

        if(headItem) {
            headItem.backgroundColor = headBackgroundColor;
            [self.scrollView addSubview:headItem];
            [self createTapGestureWithTag:i + 100 addView:headItem didSelected:[headDidSelected boolValue]];
            lineView.backgroundColor = headItem.backgroundColor;
        }
        
        if(item) {
            item.backgroundColor = itemBackgroundColor;
            [self.scrollView addSubview:item];
            [self createTapGestureWithTag:i + 200 addView:item didSelected:[itemDidSelected boolValue]];
            lineView.backgroundColor = item.backgroundColor;
            [self.itemArray addObject:item];
        }
        
        if(lineView) {
            [self.scrollView addSubview:lineView];
            
            line.frame = CGRectMake(bottomLineViewOffsetPoint.x, 0, bottomLineViewSize.width, bottomLineViewSize.height);
            line.backgroundColor = bottomLineViewBackgroundColor;
            [lineView addSubview:line];
        }
        
        if(footItem) {
            footItem.backgroundColor = footBackgroundColor;
            [self.scrollView addSubview:footItem];
            [self createTapGestureWithTag:i + 300 addView:footItem didSelected:[footDidSelected boolValue]];
            lineView.backgroundColor = footItem.backgroundColor;
        }
        
    }
    
    if([self scrollDirection] == ALScrollViewScrollDirectionDirectionVertical) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, maxValue);
    } else {
        self.scrollView.contentSize = CGSizeMake(maxValue,self.scrollView.bounds.size.height);
    }
}

- (void)createTapGestureWithTag:(NSInteger)tag addView:(UIView *)addView didSelected:(BOOL)didSelected {
    @weakify(self);
    
    if(!didSelected) return;
    
    addView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]init];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    [addView addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.view.tag = tag;
    
    if(tag >= 100 && tag < 200) {
        [[tapGestureRecognizer rac_gestureSignal] subscribeNext:^(UIGestureRecognizer *recognizer) {
            @strongify(self);
            [self.viewModel.headDidSelectCommand execute:@(recognizer.view.tag % 100)];
        }];
    } else if (tag >= 200 && tag < 300) {
        [[tapGestureRecognizer rac_gestureSignal] subscribeNext:^(UIGestureRecognizer *recognizer) {
            @strongify(self);
            [self.viewModel.itemDidSelectCommand execute:@(recognizer.view.tag % 200)];
        }];
    } else {
        [[tapGestureRecognizer rac_gestureSignal] subscribeNext:^(UIGestureRecognizer *recognizer) {
            @strongify(self);
            [self.viewModel.footDidSelectCommand execute:@(recognizer.view.tag % 300)];
        }];
    }
}

#pragma mark configureItemAction

- (NSUInteger)itemNumber {return 0;}

- (ALScrollViewScrollDirection)scrollDirection { return ALScrollViewScrollDirectionDirectionVertical; }

- (NSDictionary *)headOptionAtIndex:(NSUInteger)index { return ALOptionHead(CGSizeZero, CGPointZero, @0, [UIColor whiteColor] , @0);}

- (NSDictionary *)itemOptionAtIndex:(NSUInteger)index { return ALOptionItem(CGSizeZero, CGPointZero, @0, [UIColor whiteColor] ,@1);}

- (NSDictionary *)footOptionAtIndex:(NSUInteger)index {return ALOptionFoot(CGSizeZero, CGPointZero, @0, [UIColor whiteColor] , @0);}

- (UIView *)headViewForItemAtIndex:(NSUInteger)index { return nil; }

- (UIView *)itemAtIndex:(NSUInteger)index {return nil;}

- (UIView *)footViewForItemAtIndex:(NSUInteger)index { return nil; }

- (NSDictionary *)itemBottomLineViewAtIndex:(NSUInteger)index { return ALOptionBottonLine(CGSizeMake(self.scrollView.bounds.size.width - 15, 0.5), CGPointMake(15, 0), AL_SetColor(52, 53, 61, 1)); }

- (void)reloadData {
    
    [_headArray removeAllObjects];
    [_itemArray removeAllObjects];
    [_footArray removeAllObjects];
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self initSubviews];
    
    for (UIView *view in _itemArray) {
        if([view conformsToProtocol:@protocol(BindModel)]) {
            if([view respondsToSelector:@selector(BindModel:)])
                if(self.viewModel.dataModel) {
                    [view BindModel:self.viewModel.dataModel];
                }
        }
    }
}

- (NSMutableArray *)headArray {
    if(!_headArray) {
        _headArray = [NSMutableArray array];
    }
    return _headArray;
}

- (NSMutableArray *)itemArray {
    if(!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (NSMutableArray *)footArray {
    if(!_footArray) {
        _footArray = [NSMutableArray array];
    }
    return _footArray;
}

- (UIScrollView *)alScrollView {
    if(!_alScrollView) {
        _alScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ALNavigationBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - ALNavigationBarHeight - ALTabBarHeight)];
        _alScrollView.delegate = self;
        _alScrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_alScrollView];
    }
    return _alScrollView;
}
@end
