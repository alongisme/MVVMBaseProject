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
@property (nonatomic, strong) NSArray *subViewControllers;
@end

@implementation ALTabBarController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    
    self.tabBarController.viewControllers = self.subViewControllers;
    
    AL_MyAppDelegate.navigationControllerStack.currentController = [_subViewControllers firstObject];
    
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:) fromProtocol:@protocol(UITabBarControllerDelegate)] subscribeNext:^(RACTuple *tuple) {
        AL_MyAppDelegate.navigationControllerStack.currentController = tuple.second;
    }];
    
}

- (NSArray *)tabBarItemOptionDictionary {
    return @[
             @{
                 AL_tabBarTitle : @"One",
                 AL_tabBarImage : @"one",
                 AL_tabBarSelectedImage : @"one_sel",
                 AL_tabBarImageSize : [NSValue valueWithCGSize:CGSizeMake(25, 25)]
                 },
             @{
                 AL_tabBarTitle : @"Two",
                 AL_tabBarImage : @"two",
                 AL_tabBarSelectedImage : @"two_sel",
                 AL_tabBarImageSize : [NSValue valueWithCGSize:CGSizeMake(25, 25)]
                 },
             @{
                 AL_tabBarTitle : @"Three",
                 AL_tabBarImage : @"three",
                 AL_tabBarSelectedImage : @"three_sel",
                 AL_tabBarImageSize : [NSValue valueWithCGSize:CGSizeMake(25, 25)]
                 },
             @{
                 AL_tabBarTitle : @"Four",
                 AL_tabBarImage : @"four",
                 AL_tabBarSelectedImage : @"four_sel",
                 AL_tabBarImageSize : [NSValue valueWithCGSize:CGSizeMake(25, 25)]
                 },
             ];
}

- (UITabBarItem *)getTabBarItemWithIndex:(NSUInteger)index {
    UIImage *image = [[UIImage imageNamed:[self tabBarItemOptionDictionary][index][AL_tabBarImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:[self tabBarItemOptionDictionary][index][AL_tabBarSelectedImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return [[UITabBarItem alloc]initWithTitle:[self tabBarItemOptionDictionary][index][AL_tabBarTitle] image:[UIImage reSizeImage:image toSize:[[self tabBarItemOptionDictionary][index][AL_tabBarImageSize] CGSizeValue]] selectedImage:[UIImage reSizeImage:selectedImage toSize:[[self tabBarItemOptionDictionary][index][AL_tabBarImageSize] CGSizeValue]]];
}

- (NSArray *)subViewControllers {
    if(!_subViewControllers) {
        
        ALNavigationController *navOne = ({
            OneViewController *oneVC = [[OneViewController alloc] initWithViewModel:self.viewModel.oneViewModel];
            oneVC.tabBarItem = [self getTabBarItemWithIndex:0];
            [[ALNavigationController alloc]initWithRootViewController:oneVC];
        });
        
        ALNavigationController *navTwo = ({
            TwoViewController *twoVC = [[TwoViewController alloc] initWithViewModel:self.viewModel.twoViewModel];
            twoVC.tabBarItem = [self getTabBarItemWithIndex:1];
            [[ALNavigationController alloc]initWithRootViewController:twoVC];
        });
        
        ALNavigationController *navThree = ({
            ThreeViewController *threeVC = [[ThreeViewController alloc] initWithViewModel:self.viewModel.threeViewModel];
            threeVC.tabBarItem = [self getTabBarItemWithIndex:2];
            [[ALNavigationController alloc]initWithRootViewController:threeVC];
        });
        
        ALNavigationController *navFour = ({
            FourViewController *fourVC = [[FourViewController alloc]initWithViewModel:self.viewModel.fourViewModel];
            fourVC.tabBarItem = [self getTabBarItemWithIndex:3];
            [[ALNavigationController alloc]initWithRootViewController:fourVC];
        });
        
        _subViewControllers = @[navOne,navTwo,navThree,navFour];
    }
    return _subViewControllers;
}

- (UITabBarController *)tabBarController {
    if(!_tabBarController) {
        _tabBarController = [[UITabBarController alloc] init];
        _tabBarController.delegate = self;
        [self addChildViewController:_tabBarController];
        [self.view addSubview:_tabBarController.view];
    }
    return _tabBarController;
}
@end
