//
//  ALNetworkConnect.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNetworkConnect.h"
#import <Reachability.h>
#import <AFNetworkActivityIndicatorManager.h>

@interface ALNetworkConnect ()
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, strong ,readwrite) AFHTTPSessionManager *sessionManager;

@end

@implementation ALNetworkConnect
static ALNetworkConnect *_networkConnect = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkConnect = [[super allocWithZone:NULL] init];
        _networkConnect.isDisplayStatus = YES;
    });
    return _networkConnect;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [ALNetworkConnect sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return _networkConnect;
}

- (id)mutableCopy {
    return _networkConnect;
}

- (AFHTTPSessionManager *)sessionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [AFHTTPSessionManager manager];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    });
    return _sessionManager;
}

- (void)startNetworkServer {
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    RAC(self, networkStatus) = [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:kReachabilityChangedNotification object:nil] map:^id(NSNotification *notification) {
        return @([notification.object currentReachabilityStatus]);
    }] startWith:@(self.reachability.currentReachabilityStatus)] distinctUntilChanged];
    
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @strongify(self);
         [self.reachability startNotifier];
    });
    
    [RACObserve(self, networkStatus) subscribeNext:^(id x) {
        @strongify(self);
        if(self.isDisplayStatus) NSLog(@"%@",[self currentNetworkString]);
    }];
}

- (void)stopServer {
    [self.reachability stopNotifier];
}

- (BOOL)isWWAN {
    return self.reachability.isReachableViaWWAN;
}

- (BOOL)isWiFi {
    return self.reachability.isReachableViaWiFi;
}

- (ALNetworkStatus)currentNetworkStatus {
    return self.networkStatus;
}

- (NSString*)currentNetworkString {
    ALNetworkStatus temp = [self currentNetworkStatus];
    
    if(temp == ALNetworkStatusWWAN)
    {
        // Updated for the fact that we have CDMA phones now!
        return NSLocalizedString(@"WWAN", @"");
    }
    if (temp == ALNetworkStatusWiFi)
    {
        return NSLocalizedString(@"WiFi", @"");
    }
    
    return NSLocalizedString(@"No Connection", @"");
}
@end
