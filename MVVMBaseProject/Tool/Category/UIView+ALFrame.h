//
//  UIView+ALFrame.h
//  HealthJiaYuan
//
//  Created by along on 2016/12/29.
//  Copyright © 2016年 along. All rights reserved.
//


typedef NS_ENUM(NSInteger,ALFrameAlignmentStyle) {
    ALFrameAlignmentStyleHorizontal = 0, //水平对齐
    ALFrameAlignmentStyleBothHorizontal = 1, // 两端水平对齐
    ALFrameAlignmentStyleVertical = 2, //垂直对齐
    ALFrameAlignmentStyleBothVertical = 3, //两端垂直对齐
    ALFrameAlignmentStyleHorizontalCenter = 4, //水平居中对齐
    ALFrameAlignmentStyleBothHorizontalCenter = 5, //两端水平居中对齐
    ALFrameAlignmentStyleVerticalCenter = 6, //垂直居中对齐
    ALFrameAlignmentStyleBothVerticalCenter = 7, //两端垂直居中对齐
};

@interface UIView (UIView_ALFrame)
//获取值
- (CGFloat)al_x;
- (CGFloat)al_y;
- (CGPoint)al_origin;
- (CGFloat)al_width;
- (CGFloat)al_height;
- (CGSize)al_size;
- (CGPoint)al_center;
- (CGFloat)al_centerX;
- (CGFloat)al_centerY;
- (CGFloat)al_MaxX;
- (CGFloat)al_MaxY;

//设置frame
- (UIView *(^)(CGFloat x))al_setX;
- (UIView *(^)(CGFloat y))al_setY;
- (UIView *(^)(CGFloat x, CGFloat y))al_setOrigin;
- (UIView *(^)(CGFloat width))al_setWidth;
- (UIView *(^)(CGFloat height))al_setHeight;
- (UIView *(^)(CGFloat width, CGFloat height))al_setSize;
- (UIView *(^)(CGFloat x, CGFloat y,CGFloat width, CGFloat height))al_setFrame;

//中心点操作
- (UIView *(^)(CGFloat centerX))al_setCenterX;
- (UIView *(^)(CGFloat centerY))al_setCenterY;
- (UIView *(^)(CGPoint center))al_setCenter;
- (UIView *(^)(CGFloat moveX))al_setCenterMoveX;
- (UIView *(^)(CGFloat moveY))al_setCenterMoveY;

//百分比
- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setXWithMultipliedBy;
- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setYWithMultipliedByw;
- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setWidthWithMultipliedBy;
- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setHeightWithMultipliedBy;

- (UIView *(^)(ALFrameAlignmentStyle style))al_alignment;
@end
