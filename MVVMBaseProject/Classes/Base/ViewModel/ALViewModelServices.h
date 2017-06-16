//
//  ALViewModelServices.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNavigationProtocol.h"
#import "ALNetworkService.h"

@protocol ALViewModelServices <NSObject, ALNavigationProtocol>
//网络服务代理
@property (nonatomic, strong) id<ALNetworkService> networkService;
@end
