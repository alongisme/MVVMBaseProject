//
//  ALViewModelServices.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALNavigationProtocol.h"
#import "ALNetworkService.h"

@protocol ALViewModelServices <NSObject, ALNavigationProtocol>

@property (nonatomic, strong) id<ALNetworkService> networkService;

@end
