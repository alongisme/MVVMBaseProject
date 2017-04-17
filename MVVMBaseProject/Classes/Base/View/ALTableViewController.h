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
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSString *emptyDataTitle;

- (void)reloadData;
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end
