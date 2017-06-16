//
//  ALNativeLocation.h
//  CoolBananas
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 3ti. All rights reserved.
//

@interface ALNativeLocation : NSObject
- (instancetype)init NS_UNAVAILABLE;

/**
 开始定位

 @param block 回传城市和定位信息
 @return self
 */
- (instancetype)initWithCallBackCity:(void (^)(NSString *cityName,CLPlacemark *placemark))block;

/**
 停止定位
 */
- (void)stopLocation;
@end
