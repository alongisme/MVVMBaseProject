//
//  ALBaseViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"
#import <MBProgressHUD.h>

@interface ALBaseViewController ()

@end

@implementation ALBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    ALBaseViewController *baseViewController = [super allocWithZone:zone];
    
    @weakify(baseViewController);
    [[baseViewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(baseViewController);
        [baseViewController bindViewModel];
    }];
    return baseViewController;
}

- (instancetype)initWithViewModel:(ALBaseViewModel *)viewModel {
    if(self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    if(self.navigationController.viewControllers.count <= 1) {
        self.navigationBar.hideBackBtn = YES;
    }
}

- (void)bindViewModel {
    RAC(self,title) = RACObserve(self.viewModel,title);
    RAC(self.navigationBar,title) = RACObserve(self.viewModel,title);

    @weakify(self);
    self.viewModel.touchBeginSignal = [self rac_signalForSelector:@selector(touchesBegan:withEvent:)];
    self.viewModel.touchesEnded = [self rac_signalForSelector:@selector(touchesEnded:withEvent:)];
    self.viewModel.touchesMoved = [self rac_signalForSelector:@selector(touchesMoved:withEvent:)];
    self.viewModel.touchesCancelled = [self rac_signalForSelector:@selector(touchesCancelled:withEvent:)];
    [self.viewModel makeEventAvailable];
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        if(error) {
            NSDictionary *errorInfo = error.userInfo;
            NSString *message = [errorInfo jk_stringForKey:@"message"];
            [self.view showHudInWindowError:message];
        }
    }];
    
    [[self.navigationBar.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.backItemClickCommand execute:nil];
    }];
}

#pragma mark UIEvent Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

#pragma mark lazy load 
- (ALNavigationBarView *)navigationBar {
    if(!_navigationBar) {
        _navigationBar = [[ALNavigationBarView alloc] init];
        [self.view addSubview:_navigationBar];
        
        [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.centerX.equalTo(self.view);
            make.width.equalTo(self.view);
            make.height.mas_equalTo(ALNavigationBarHeight);
        }];
    }
    return _navigationBar;
}
@end
