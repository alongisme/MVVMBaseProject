//
//  ALTabBarViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"
#import "OneViewModel.h"
#import "TwoViewModel.h"
#import "ThreeViewModel.h"
#import "FourViewModel.h"

@interface ALTabBarViewModel : ALBaseViewModel

@property (nonatomic, strong) OneViewModel *oneViewModel;

@property (nonatomic, strong) TwoViewModel *twoViewModel;

@property (nonatomic, strong) ThreeViewModel *threeViewModel;

@property (nonatomic, strong) FourViewModel *fourViewModel;

@end
