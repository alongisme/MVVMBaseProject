//
//  ALAppDelegate.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALAppDelegate.h"
#import "ALNetworkConnect.h"
#import "ALHttpConfig.h"
#import "ALTabBarViewModel.h"
#import "ALTabBarController.h"
#import "ALViewModelServicesImpl.h"
#import <AFNetworkActivityIndicatorManager.h>

@interface ALAppDelegate ()
@property (nonatomic, strong) ALViewModelServicesImpl *services;
@end

@implementation ALAppDelegate

#pragma mark - UIApplicationDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置root控制器
    [self configureRootViewController];
    //配置导航栏属性
    [self configureNavigationBarAppearance];
    //设置环境
    [ALHttpConfig setALConfigEnv:DebugEnv];
    //配置监听网络状态
    [self configureNetworkStatus];
    //配置数据库
    [self configureJRDBManager];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[JRDBMgr shareInstance] close];
}

#pragma mark - RootViewController
- (void)configureRootViewController {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.services = [[ALViewModelServicesImpl alloc]init];
    self.navigationControllerStack = [[ALNavigationControllerStack alloc]initWithServices:self.services];
    ALTabBarViewModel *tabbarViewModel = [[ALTabBarViewModel alloc]initWithServices:self.services params:nil];
    ALTabBarController *tabbarC = [[ALTabBarController alloc]initWithViewModel:tabbarViewModel];
    self.window.rootViewController = tabbarC;
    
    [self.window makeKeyAndVisible];
}

#pragma mark - ConfigureNetworkStatus
- (void)configureNetworkStatus {
    ALNetworkConnect *networkConnect = [ALNetworkConnect sharedInstance];
    [networkConnect startNetworkServer];
    self.networkStatus = networkConnect.currentNetworkStatus;
}

#pragma mark - ConfigureNavigationBarAppearance
- (void)configureNavigationBarAppearance {
    
}

- (void)configureJRDBManager {
    [[JRDBMgr shareInstance] setDefaultDatabasePath:[@"/Users/along/Desktop/" stringByAppendingPathComponent:JRDB_DataBasePath]];
    //    [[JRDBMgr shareInstance] setDefaultDatabasePath:[[ALFileManager dirCache] stringByAppendingPathComponent:JRDB_DataBasePath]];
    [[JRDBMgr shareInstance] registerClazzes:@[
                                               NSClassFromString(@"OneModel")
                                               ]];
#if DEBUG
    [JRDBMgr shareInstance].debugMode = YES;
#endif

}
@end
