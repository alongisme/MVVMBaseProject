//
//  ALConfig.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#ifndef ALConfig_h
#define ALConfig_h

//DeBug
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s %d Line \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//AppDelegate
#define AL_MyAppDelegate ((ALAppDelegate *)[UIApplication sharedApplication].delegate)

//KeyWindow
#define ALKeyWindow [UIApplication sharedApplication].keyWindow

//ScreenBounds
#define ALScreenBounds [UIScreen mainScreen].bounds
#define ALScreenWidth [UIScreen mainScreen].bounds.size.width
#define ALScreenHeight [UIScreen mainScreen].bounds.size.height

//设置随机颜色
#define AL_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f]
//设置颜色
#define AL_SetColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//导航栏默认高度
#define ALNavigationBarHeight 64.0f
//tabbar默认高度
#define ALTabBarHeight 64.0f

//用户信息
#define UserDefult_UserInfoKey @"UserDefult_UserInfoKey"

//域名
#define Request_Domain @"http://localhost:8181/along"
//图片域名
#define Request_Image @"http://localhost:8181"

//#define Request_Domain @"http://192.168.3.91:8181/along"
#endif /* ALConfig_h */
