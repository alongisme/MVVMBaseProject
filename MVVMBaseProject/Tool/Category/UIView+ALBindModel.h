//
//  UIView+ALBindModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/20.
//  Copyright © 2017年 along. All rights reserved.
//

@protocol BindModel <NSObject>
- (void)BindModel:(id)model;
@end

@interface UIView (ALBindModel) <BindModel>

@end
