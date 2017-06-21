//
//  ThreeViewModel.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ThreeViewModel.h"
#import "ThreeModel.h"

@implementation ThreeViewModel

- (void)initialize {
    [super initialize];
        
    @weakify(self);
    [self.requestRemoteDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self);
        
        ThreeModel *threeModel = [ThreeModel new];
        threeModel.oneName = @"头像";
        threeModel.oneValue = @"head.jpg";
        
        threeModel.twoName = @"姓名";
        threeModel.twoValue = @"swift";
        
        threeModel.threeName = @"性别";
        threeModel.threeValue = @"男";
        
        threeModel.fourName = @"手机号码";
        threeModel.fourValue = @"12345678900";
        
        threeModel.fiveName = @"地址";
        threeModel.fiveValue = @"xxx";
        
        threeModel.sixName = @"身高";
        threeModel.sixValue = @"177";
        
        threeModel.sevenName = @"体重";
        threeModel.sevenValue = @"77";
        
        threeModel.eightName = @"出生年月";
        threeModel.eightValue = @"1900-01-01";
        
        threeModel.nineName = @"照片";
        threeModel.nineValue = @"";
        
        threeModel.tenName = @"退出登录";
        threeModel.tenValue = @"";
        
        self.dataModel = threeModel;
    }];
    
    self.itemDidSelectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *index) {
        if(index.integerValue == 0) {
            return [RACSignal return:@(ALCommonTypeTakePhotos)];
        }
        
        if(index.integerValue == 7) {
            return [RACSignal return:@(ALCommonTypeDisplayDate)];
        }
        
        if(index.integerValue == 9) {
            return [RACSignal return:@(ALCommonTypeUserLogout)];
        }
        return [RACSignal empty];
    }];
    
    self.headDidSelectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *index) {
        NSLog(@"%@",index);
        return [RACSignal empty];
    }];
    
    self.footDidSelectCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *index) {
        NSLog(@"%@",index);
        return [RACSignal empty];
    }];
    
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.networkService requestDataWithUrl:[Request_Domain stringByAppendingString:@"/testData"] params:@{}] map:^id(NSDictionary *dataSource) {
        
        return nil;
    }];
}
@end
