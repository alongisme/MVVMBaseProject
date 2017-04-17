//
//  ALNetworkConnect.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import <AFNetworking.h>


typedef NS_ENUM(NSInteger,ALNetworkStatus) {
    ALNetworkStatusNotNet = 0,//无网络
    ALNetworkStatusWWAN = 1,//运营商网络
    ALNetworkStatusWiFi = 2//Wi-Fi
};

@interface ALNetworkConnect : NSObject <NSCopying>

@property (nonatomic, strong ,readonly) AFHTTPSessionManager *sessionManager;
/**
 网络状态
 */
@property (nonatomic, assign) ALNetworkStatus networkStatus;

/**
 是否显示打印
 */
@property (nonatomic, assign) BOOL isDisplayStatus;

/**
 单列

 @return object
 */
+ (instancetype)sharedInstance;

/**
 开始监听服务
 */
- (void)startNetworkServer;

/**
 停止监听服务
 */
- (void)stopServer;

/**
 判断是否运行商状态

 @return yes 是 no 否
 */
- (BOOL)isWWAN;

/**
 判断是否Wi-Fi

 @return yes 是 no 否
 */
- (BOOL)isWiFi;

/**
 获取当前网络状态

 @return enum
 */
- (ALNetworkStatus)currentNetworkStatus;

/**
 获取当前网络状态字符串

 @return string
 */
- (NSString *)currentNetworkString;
@end
