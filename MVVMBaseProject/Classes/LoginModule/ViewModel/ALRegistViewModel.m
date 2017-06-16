//
//  ALRegistViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/5/16.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALRegistViewModel.h"

@implementation ALRegistViewModel

- (void)initialize {
    [super initialize];
    
    RACSignal *registEnable = [RACCommonTools combineLatestInputSignal:@[RACObserve(self, account),RACObserve(self, nickName),RACObserve(self, code),RACObserve(self, password),RACObserve(self, sePassword)]];
    
    @weakify(self);
    self.getCodeCommand = [[RACCommand alloc] initWithEnabled:registEnable signalBlock:^RACSignal *(id input) {
        @strongify(self);
        if([self.account al_checkPhoneNumber]) {
            return [[self.services.networkService requestGetCodeWithAccount:self.code] takeUntil:self.rac_willDeallocSignal];
        } else {
            return [RACSignal return:@(ALErrorPhoneNumberError)];
        }
        return nil;
    }];
    
    self.registCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if([self.password isEqualToString:self.sePassword]) {
            return [[self.services.networkService requestUserRegistWithAccount:self.account Password:self.password code:self.code] takeUntil:self.rac_willDeallocSignal];
        } else {
            return [RACSignal return:@(ALErrorPasswordNotEquel)];
        }
    }];
    
    [[RACSignal merge:@[self.getCodeCommand.errors,self.registCommand.errors]] subscribe:self.errors];
}

@end
