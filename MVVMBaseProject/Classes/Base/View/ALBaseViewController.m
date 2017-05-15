//
//  ALBaseViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/11.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALBaseViewController.h"

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)bindViewModel {
    RAC(self,title) = RACObserve(self.viewModel,title);
    
    self.viewModel.touchBeginSignal = [self rac_signalForSelector:@selector(touchesBegan:withEvent:)];
    self.viewModel.touchesEnded = [self rac_signalForSelector:@selector(touchesEnded:withEvent:)];
    self.viewModel.touchesMoved = [self rac_signalForSelector:@selector(touchesMoved:withEvent:)];
    self.viewModel.touchesCancelled = [self rac_signalForSelector:@selector(touchesCancelled:withEvent:)];
    [self.viewModel makeEventAvailable];
}

#pragma mark UIEvent Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}
@end
