//
//  ALNativeLocation.h
//  CoolBananas
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 3ti. All rights reserved.
//

@interface ALNativeLocation : NSObject
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCallBackCity:(void (^)(NSString *cityName,CLPlacemark *placemark))block;
- (void)stopLocation;
@end
