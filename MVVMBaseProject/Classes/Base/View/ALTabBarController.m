//
//  ALTabBarController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALTabBarController.h"
#import "ALNavigationController.h"
#import "ALTabBarViewModel.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface ALTabBarController ()
@property (nonatomic, strong) ALTabBarViewModel *viewModel;
@end

@implementation ALTabBarController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
    
    ALNavigationController *navOne = ({
        OneViewController *oneVC = [[OneViewController alloc] initWithViewModel:self.viewModel.oneViewModel];

        UIImage *image = [[UIImage imageNamed:@"one"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"one_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        oneVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"One" image:[UIImage reSizeImage:image toSize:CGSizeMake(25, 25)] selectedImage:[UIImage reSizeImage:selectedImage toSize:CGSizeMake(25, 25)]];

        [[ALNavigationController alloc]initWithRootViewController:oneVC];
    });
    
    ALNavigationController *navTwo = ({
        TwoViewController *twoVC = [[TwoViewController alloc] initWithViewModel:self.viewModel.twoViewModel];
        
        UIImage *image = [[UIImage imageNamed:@"two"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"two_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        twoVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Two" image:[UIImage reSizeImage:image toSize:CGSizeMake(25, 25)] selectedImage:[UIImage reSizeImage:selectedImage toSize:CGSizeMake(25, 25)]];
        
        [[ALNavigationController alloc]initWithRootViewController:twoVC];
    });
    
    ALNavigationController *navThree = ({
        ThreeViewController *threeVC = [[ThreeViewController alloc] initWithViewModel:self.viewModel.threeViewModel];
        
        UIImage *image = [[UIImage imageNamed:@"three"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"three_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        threeVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Three" image:[UIImage reSizeImage:image toSize:CGSizeMake(25, 25)] selectedImage:[UIImage reSizeImage:selectedImage toSize:CGSizeMake(25, 25)]];
        
        [[ALNavigationController alloc]initWithRootViewController:threeVC];
    });
    
    ALNavigationController *navFour = ({
        FourViewController *fourVC = [[FourViewController alloc]initWithViewModel:self.viewModel.fourViewModel];

        UIImage *image = [[UIImage imageNamed:@"four"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"four_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        fourVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Four" image:[UIImage reSizeImage:image toSize:CGSizeMake(25, 25)] selectedImage:[UIImage reSizeImage:selectedImage toSize:CGSizeMake(25, 25)]];
        
        [[ALNavigationController alloc]initWithRootViewController:fourVC];
    });
    
    self.tabBarController.viewControllers = @[navOne,navTwo,navThree,navFour];
    
    ALAPP.navigationControllerStack.currentController = navOne;
    
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:) fromProtocol:@protocol(UITabBarControllerDelegate)] subscribeNext:^(RACTuple *tuple) {
        ALAPP.navigationControllerStack.currentController = tuple.second;
    }];
    
    self.tabBarController.delegate = self;
}

@end
