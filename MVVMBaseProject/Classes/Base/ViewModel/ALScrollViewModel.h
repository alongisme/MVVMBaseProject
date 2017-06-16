//
//  ALScrollViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/19.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALScrollViewModel : ALBaseViewModel
//数据源
@property (nonatomic, strong) NSObject *dataModel;
//数据获取
@property (nonatomic, strong) RACCommand *requestRemoteDataCommand;
//head点击
@property (nonatomic, strong) RACCommand *headDidSelectCommand;
//body点击
@property (nonatomic, strong) RACCommand *itemDidSelectCommand;
//foot点击
@property (nonatomic, strong) RACCommand *footDidSelectCommand;
@end
