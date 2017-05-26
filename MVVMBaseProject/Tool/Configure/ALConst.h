//
//  ALConst.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//


#ifndef ALConst_h
#define ALConst_h

//生产环境 标记
static NSString * const DebugEnv = @"0";
//正式环境 标记
static NSString * const ReleaseEnv = @"1";
//生产环境 URL
static NSString * const Debug_URL = @"http://www.suprc.org:8082/work-first";//@"http://app.ankangtong.com/ankangtong/";
//正式环境 URL
static NSString * const Release_URL = @"http://www.suprc.org:8082/work-first";

//数据库保存路径名
static NSString * const JRDB_DataBasePath = @"test.sqlite";

//tabBarController
static NSString * const AL_tabBarTitle = @"AL_tabBarTitle";
static NSString * const AL_tabBarImage = @"AL_tabBarImage";
static NSString * const AL_tabBarSelectedImage = @"AL_tabBarSelectedImage";
static NSString * const AL_tabBarImageSize = @"AL_tabBarImageSize";

#endif /* ALConst_h */
