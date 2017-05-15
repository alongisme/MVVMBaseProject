//
//  ALBaseViewModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALNavigationProtocol.h"
#import "ALViewModelServices.h"

@interface ALBaseViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *params;

//UIEvent Signal
@property (nonatomic, strong) RACSignal *touchBeginSignal;
@property (nonatomic, strong) RACSignal *touchesEnded;
@property (nonatomic, strong) RACSignal *touchesMoved;
@property (nonatomic, strong) RACSignal *touchesCancelled;

@property (nonatomic, strong) id<ALViewModelServices> services;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *errors;

- (instancetype)initWithServices:(id<ALViewModelServices>)Services params:(NSDictionary *)params;

- (void)initialize;
- (RACSignal *)requestDataSignal;
- (void)makeEventAvailable;
@end
