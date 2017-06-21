//
//  UIView+ALFrame.m
//  HealthJiaYuan
//
//  Created by along on 2016/12/29.
//  Copyright © 2016年 along. All rights reserved.
//

#import "UIView+ALFrame.h"

@implementation UIView (UIView_ALFrame)
- (CGFloat)al_x {
    return self.frame.origin.x;
}

- (CGFloat)al_y {
    return self.frame.origin.y;
}

- (CGPoint)al_origin {
    return self.frame.origin;
}

- (CGFloat)al_width {
    return self.frame.size.width;
}

- (CGFloat)al_height {
    return self.frame.size.height;
}

- (CGSize)al_size {
    return self.frame.size;
}

- (CGFloat)al_centerX {
    return self.center.x;
}

- (CGFloat)al_centerY {
    return self.center.y;
}

- (CGPoint)al_center {
    return self.center;
}

- (CGFloat)al_MaxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)al_MaxY {
    return CGRectGetMaxY(self.frame);
}

- (UIView *(^)(CGFloat x))al_setX {
    return ^(CGFloat x) {
        CGRect rect = self.frame;
        rect.origin.x = x;
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat y))al_setY {
    return ^(CGFloat y) {
        CGRect rect = self.frame;
        rect.origin.y = y;
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat x,CGFloat y))al_setOrigin {
    return ^(CGFloat x,CGFloat y) {
        CGRect rect = self.frame;
        rect.origin = CGPointMake(x, y);
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat width))al_setWidth {
    return ^(CGFloat width) {
        CGRect rect = self.frame;
        rect.size.width = width;
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat height))al_setHeight {
    return ^(CGFloat height) {
        CGRect rect = self.frame;
        rect.size.height = height;
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat width, CGFloat height))al_setSize {
    return ^(CGFloat width, CGFloat height) {
        CGRect rect = self.frame;
        rect.size = CGSizeMake(width, height);
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat x, CGFloat y,CGFloat width, CGFloat height))al_setFrame {
    return ^(CGFloat x, CGFloat y,CGFloat width, CGFloat height) {
        self.frame = CGRectMake(x, y, width, height);
        return self;
    };
}

- (UIView *(^)(CGFloat centerX))al_setCenterX {
    return ^(CGFloat centerX) {
        self.center = CGPointMake(centerX, self.center.y);
        return self;
    };
}

- (UIView *(^)(CGFloat centerY))al_setCenterY {
    return ^(CGFloat centerY) {
        self.center = CGPointMake(self.center.x, centerY);
        return self;
    };
}

- (UIView *(^)(CGPoint center))al_setCenter {
    return ^(CGPoint center) {
        self.center = center;
        return self;
    };
}

- (UIView *(^)(CGFloat moveX))al_setCenterMoveX {
    return ^(CGFloat moveX) {
        self.center = CGPointMake(self.center.x + moveX, self.center.y);
        return self;
    };
}

- (UIView *(^)(CGFloat moveY))al_setCenterMoveY {
    return ^(CGFloat moveY) {
        self.center = CGPointMake(self.center.x, self.center.y + moveY);
        return self;
    };
}

- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setXWithMultipliedBy {
    return ^(CGFloat multipliedBy,UIView *view) {
        CGRect rect = self.frame;
        rect.origin.x = view.frame.origin.x * multipliedBy;
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setYWithMultipliedByw {
    return ^(CGFloat multipliedBy,UIView *view) {
        CGRect rect = self.frame;
        rect.origin.y = view.frame.origin.y * multipliedBy;
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setWidthWithMultipliedBy {
    return ^(CGFloat multipliedBy,UIView *view) {
        CGRect rect = self.frame;
        rect.size.width = view.frame.size.width * multipliedBy;
        self.frame = rect;
        return self;
    };
}

- (UIView *(^)(CGFloat multipliedBy,UIView *view))al_setHeightWithMultipliedBy {
    return ^(CGFloat multipliedBy,UIView *view) {
        CGRect rect = self.frame;
        rect.size.height = view.frame.size.height * multipliedBy;
        self.frame = rect;
        return self;
    };
}


- (UIView *(^)(ALFrameAlignmentStyle style))al_alignment {
    return ^(ALFrameAlignmentStyle style) {
        NSUInteger count = self.subviews.count;
        if(style == ALFrameAlignmentStyleHorizontal || style == ALFrameAlignmentStyleVertical || style == ALFrameAlignmentStyleVerticalCenter || style == ALFrameAlignmentStyleHorizontalCenter) {
            if(count == 1) {
                UIView *subView = [self.subviews lastObject];
                (style == 0 || style == 4) ? (subView.al_setCenterX(self.al_width * 0.5)) : (subView.al_setCenterY(self.al_height * 0.5));
                style == 4 ? subView.al_setCenterY(self.al_height * 0.5) : subView.al_setCenterX(self.al_width * 0.5);
            } else if(count > 1) {
                CGFloat sum = 0;
                
                for (UIView *subView in self.subviews) {
                    (style == 0 || style == 4) ? (sum += subView.al_width) : (sum += subView.al_height);
                }
                
                if(sum > ((style == 0 || style == 4) ? self.al_width : self.al_height)) {
                    if(style == 0 || style == 4)
                        NSLog(@"subviews sum width > self width");
                    else
                        NSLog(@"subviews sum height > self height");
                } else {
                    CGFloat spacing = (((style == 0 || style == 4) ? self.al_width : self.al_height) - sum) / (count + 1);
                    CGFloat lastMax = 0;
                    for (unsigned int i = 0; i < count; i++) {
                        UIView *subView = self.subviews[i];
                        (style == 0 || style == 4) ? (subView.al_setX(lastMax + spacing)) : (subView.al_setY(lastMax + spacing));
                        style == 4 ? subView.al_setCenterY(self.al_height * 0.5) : subView.al_setCenterX(self.al_width * 0.5);
                        lastMax = (style == 0 || style == 4) ? subView.al_MaxX : subView.al_MaxY;
                    }
                }
            }
        } else if(style == ALFrameAlignmentStyleBothHorizontal || style == ALFrameAlignmentStyleBothVertical || style == ALFrameAlignmentStyleBothVerticalCenter || style == ALFrameAlignmentStyleBothHorizontalCenter) {
            if(count < 2) {
                NSLog(@"subviews count < 2");
            } else {
                CGFloat sum = 0;
                
                for (UIView *subView in self.subviews) {
                    sum += (style == 1 || style == 5) ? subView.al_width : subView.al_height;
                }
                
                if(sum > (style == 1 || style == 5 ? self.al_width : self.al_height)) {
                    if(style == 1 || style == 5)
                        NSLog(@"subviews sum width > self width");
                    else
                        NSLog(@"subviews sum height > self height");
                } else {
                    CGFloat spacing = (((style == 1 || style == 5) ? self.al_width : self.al_height) - sum) / (count - 1);
                    CGFloat lastMax = 0;
                    for (unsigned int i = 0; i < count; i++) {
                        UIView *subView = self.subviews[i];
                        if(i == 0) {
                            (style == 1 || style == 5) ? subView.al_setX(0) : subView.al_setY(0);
                        } else if(i == count - 1) {
                            (style == 1 || style == 5) ? (subView.al_setX(self.al_width - subView.al_width)) : (subView.al_setY(self.al_height - subView.al_height));
                        } else {
                            (style == 1 || style == 5) ? (subView.al_setX(lastMax + spacing)) : (subView.al_setY(lastMax + spacing));
                        }
                        style == 5 ? subView.al_setCenterY(self.al_height * 0.5) : subView.al_setCenterX(self.al_width * 0.5);
                        lastMax = (style == 1 || style == 5) ? subView.al_MaxX : subView.al_MaxY;
                    }
                }
            }
        } 
        
        return self;
    };
}


@end
