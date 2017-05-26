//
//  ALLoginViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALLoginViewModel : ALBaseViewModel

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) RACSignal *loginEnableSignal;

@property (nonatomic, strong) RACCommand *loginCommand;
@end
