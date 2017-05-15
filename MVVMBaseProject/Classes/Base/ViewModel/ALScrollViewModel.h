//
//  ALScrollViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALScrollViewModel : ALBaseViewModel
@property (nonatomic, strong) NSObject *dataModel;

@property (nonatomic, assign) BOOL shouldPullToRefresh;

@property (nonatomic, strong) RACCommand *requestRemoteDataCommand;

@property (nonatomic, strong) RACCommand *headDidSelectCommand;
@property (nonatomic, strong) RACCommand *itemDidSelectCommand;
@property (nonatomic, strong) RACCommand *footDidSelectCommand;

@end
