//
//  ALBaseViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"

@interface ALBaseViewController ()
@property (nonatomic, strong) UIBarButtonItem *backBtnItem;
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
    
    //导航栏首界面不添加返回按钮
    if(self.navigationController.viewControllers.count > 1) {
        self.navigationBar.leftBarButtonItem = self.backBtnItem;
    }
}

- (void)bindViewModel {
    RAC(self,title) = RACObserve(self.viewModel,title);
    RAC(self.navigationBar, navigationTitle) = RACObserve(self,title);
    RAC(self.navigationBar, leftBarButtonItem) = RACObserve(self.navigationItem, leftBarButtonItem);
    RAC(self.navigationBar, rightBarButtonItem) = RACObserve(self.navigationItem, rightBarButtonItem);

    @weakify(self);
    //以下方法控制器不常用所以暂不添加 只添加一个点击代理 避免复杂的判断
    [[RACSignal merge:@[
                        [self rac_signalForSelector:@selector(touchesBegan:withEvent:)],
//                        [self rac_signalForSelector:@selector(touchesEnded:withEvent:)],
//                        [self rac_signalForSelector:@selector(touchesMoved:withEvent:)],
//                        [self rac_signalForSelector:@selector(touchesCancelled:withEvent:)]
                        ]
      ] subscribe:self.viewModel.touchReplaySubject];
    
    //绑定导航栏 返回按钮事件
    [[self.backBtnItem.customView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribe:self.viewModel.backBtnItemClick];
    
    //统一错误处理
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        if(error) {
            NSDictionary *errorInfo = error.userInfo;
            NSString *message = [errorInfo jk_stringForKey:@"message"];
            NSString *localizedDescription = [errorInfo jk_stringForKey:@"NSLocalizedDescription"];
            [self.view showHudInWindowError:message?message:localizedDescription];
        }
    }];
    
}

#pragma mark UIEvent Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

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

- (UIBarButtonItem *)backBtnItem {
    if(!_backBtnItem) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.al_setFrame(0,0,40,25);
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    return _backBtnItem;
}
@end
