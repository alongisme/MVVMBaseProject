//
//  ALConst.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//


#ifndef ALConst_h
#define ALConst_h

typedef NS_ENUM(NSUInteger,ALErrorType) {
    ALErrorPhoneNumberError = 600,
    ALErrorPasswordNotEquel = 601,
};

typedef NS_ENUM(NSUInteger,ALCommonType) {
    ALCommonTypeTakePhotos = 700,
    ALCommonTypeDisplayDate = 701,
    ALCommonTypeUserLogout = 709,
};

//数据库保存路径名
static NSString * const JRDB_DataBasePath = @"test.sqlite";

//login module
static NSString * const ALong_User = @"ALong_User";

#endif /* ALConst_h */
