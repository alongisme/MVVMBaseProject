//
//  ALTableViewController.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import <MJRefresh.h>

@interface ALTableViewController : ALBaseViewController
//列表
@property (nonatomic, weak) UITableView *tableView;
//没有数据时 提示的文字
@property (nonatomic, strong) NSString *emptyDataTitle;
//刷新
- (void)reloadData;
//初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
//自定义数据绑定
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end
