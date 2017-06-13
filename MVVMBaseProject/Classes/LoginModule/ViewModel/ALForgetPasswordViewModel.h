//
//  ALForgetPasswordViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewModel.h"

@interface ALForgetPasswordViewModel : ALBaseViewModel
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *sePassword;

@property (nonatomic, strong) RACCommand *getCodeCommand;
@property (nonatomic, strong) RACSignal *updateEnable;
@property (nonatomic, strong) RACCommand *updateCommand;
@end
