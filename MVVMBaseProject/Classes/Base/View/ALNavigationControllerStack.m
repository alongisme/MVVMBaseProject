//
//  ALNavigationControllerStack.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALNavigationControllerStack.h"
#import "ALTabBarController.h"
#import "ALViewRouter.h"

@interface ALNavigationControllerStack ()
@property (nonatomic, strong) id<ALNavigationProtocol> services;

@end

@implementation ALNavigationControllerStack

- (instancetype)initWithServices:(id<ALNavigationProtocol>)services {
    if(self = [super init]) {
        self.services = services;
        [self registerNavigationHooks];
    }
    return self;
}

- (UINavigationController *)currentController {
#if DEBUG
    if(!_currentController)
        NSLog(@"current navigationController : nil");
#endif
    return _currentController;
}

//bindNavigationPushAction
- (void)registerNavigationHooks {
    @weakify(self);
    [[(NSObject *)self.services rac_signalForSelector:@selector(pushViewModel:animated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        ALBaseViewController *baseViewController = [[ALViewRouter sharedInstance] viewControllerForViewModel:tuple.first];
        baseViewController.hidesBottomBarWhenPushed = YES;
        [self.currentController pushViewController:baseViewController animated:[tuple.second boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.currentController popViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popToRootViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.currentController popToRootViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(presentViewModel:animated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UIViewController *baseViewController = [[ALViewRouter sharedInstance] viewControllerForViewModel:tuple.first];
        
        if (![baseViewController isKindOfClass:UINavigationController.class]) {
            baseViewController = [[UINavigationController alloc] initWithRootViewController:baseViewController];
        }
        
        [self.currentController presentViewController:baseViewController animated:[tuple.second boolValue] completion:^{
            void (^completion)() = tuple.third;
            if(completion) completion();
            
            if (![baseViewController isKindOfClass:UINavigationController.class])
                self.currentController = (UINavigationController *)baseViewController;
        }];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.currentController dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
    }];
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(resetRootViewModel:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        self.currentController = nil;
        UIViewController *baseViewController = [[ALViewRouter sharedInstance] viewControllerForViewModel:tuple.first];
        
        if([baseViewController isKindOfClass:[UINavigationController class]])
            self.currentController = (UINavigationController *)baseViewController;
        
        if(![baseViewController isKindOfClass:[UINavigationController class]] && ![baseViewController isKindOfClass:[ALTabBarController class]]) {
            baseViewController = [[UINavigationController alloc] initWithRootViewController:baseViewController];
            self.currentController = (UINavigationController *)baseViewController;
        }
        
        AL_MyAppDelegate.window.rootViewController = baseViewController;
    }];
}
@end
