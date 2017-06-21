//
//  ALNavigationBarView.h
//  MVVMBaseProject
//
//  Created by along on 2017/6/14.
//  Copyright © 2017年 along. All rights reserved.
//

@interface ALNavigationBarView : UINavigationBar
//标题
@property (nonatomic,strong) NSString *navigationTitle;
//左按钮item
@property (nonatomic,strong) UIBarButtonItem *leftBarButtonItem;
//右按钮item
@property (nonatomic,strong) UIBarButtonItem *rightBarButtonItem;
//左按钮组items
@property (nonatomic,strong) UIBarButtonItem *leftBarButtonItems;
//右按钮组items
@property (nonatomic,strong) UIBarButtonItem *rightBarButtonItems;
@end
