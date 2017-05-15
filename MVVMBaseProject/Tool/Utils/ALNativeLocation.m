//
//  ALNativeLocation.m
//  CoolBananas
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 3ti. All rights reserved.
//

#import "ALNativeLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface ALNativeLocation ()<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}
@property (nonatomic,copy) void (^callBackCity)(NSString *cityName,CLPlacemark *placemark);
@end

@implementation ALNativeLocation

- (instancetype)initWithCallBackCity:(void (^)(NSString *cityName,CLPlacemark *placemark))block {
    if(self = [super init]) {
        self.callBackCity = block;
        [self initializeLocationService];
    }
    return self;
}

- (void)stopLocation {
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
    locationManager = nil;
}

- (void)initializeLocationService {
    // 初始化定位管理器
    locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    locationManager.delegate = self;
    // 设置定位精确度到米
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //将经度显示到label上
//    NSLog(@"%@",[NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude]);
    //将纬度现实到label上
//    NSLog(@"%@",[NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude]);
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
//            NSLog(@"%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
//            NSLog(@"city = %@", city);
            
            NSString *cityName = [city substringToIndex:[city length] -1];
            
            if(self.callBackCity) {
                self.callBackCity(cityName,placemark);
            }
            
            NSLog(@"%@", [city substringToIndex:[city length] -1]);
            
            //本地保存
//            [city AL_saveLocalWithLocalKey:LocationCityName];
            
//            NSLog(@"%@",ALAppDelegate.locationCityName);
            
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}
@end
