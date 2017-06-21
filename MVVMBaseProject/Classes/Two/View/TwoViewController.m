//
//  TwoViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "TwoViewController.h"
#import "TwoViewModel.h"
#import "TwoTableViewCell.h"
#import "TwoModel.h"

@interface TwoViewController ()
@property (nonatomic, strong) TwoViewModel *viewModel;
@end

@implementation TwoViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:@"TwoTableViewCell"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(TwoTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(TwoViewModel *)viewModel {
    [cell BindModel:viewModel];
}
@end
