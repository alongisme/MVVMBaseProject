//
//  ALRegistViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALRegistViewModel : ALBaseViewModel

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *sePassword;

@property (nonatomic, strong) RACSignal *registEnable;
@property (nonatomic, strong) RACCommand *registCommand;
@end
