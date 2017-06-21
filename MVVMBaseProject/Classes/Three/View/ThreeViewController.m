//
//  ThreeViewController.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/12.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ThreeViewController.h"
#import "ALLoginViewModel.h"
#import "ThreeViewModel.h"
#import "HcdDateTimePickerView.h"
#import "OneView.h"
#import "TwoView.h"
#import "ThreeView.h"
#import "FourView.h"
#import "fiveView.h"
#import "SixView.h"
#import "SevenView.h"
#import "EightView.h"
#import "NineView.h"
#import "TenView.h"

@interface ThreeViewController ()
@property (nonatomic, strong) ThreeViewModel *viewModel;
//相机
@property (nonatomic, strong) ALImagePickerController *imagePickerController;
@end

@implementation ThreeViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.viewModel.requestRemoteDataCommand execute:nil];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self);
    [self.viewModel.itemDidSelectCommand.executionSignals.switchToLatest subscribeNext:^(NSNumber *value) {
        @strongify(self);
        
        switch (value.integerValue) {
            case ALCommonTypeTakePhotos: {
                [[[[ALAlertController SignalShowAlertActionSheetWith:self title:nil message:nil destructiveButtonTitle:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"本地图库",@"拍照"]] flattenMap:^RACStream *(NSNumber *index) {
                    return [self.imagePickerController SignalWithViewController:self SourceType:index.integerValue - 1 Edit:NO];
                }] flattenMap:^RACStream *(NSDictionary *info) {
                    return [[self.viewModel.services.networkService requestDataWithImageArray:@[info[UIImagePickerControllerOriginalImage]]] takeUntil:self.rac_willDeallocSignal];
                }] subscribeNext:^(id respose) {
                    if([respose isKindOfClass:[NSDictionary class]]) {
                        [self.view showHudSuccess:[respose jk_stringForKey:@"message"]];
                        ((ThreeModel *)self.viewModel.dataModel).oneValue = [respose jk_stringForKey:@"object"];
                        [self reloadData];
                    }
                }];
            }
                break;
            case ALCommonTypeDisplayDate: {
                HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[NSDate date]];
                dateTimePickerView.topViewColor = [UIColor lightGrayColor];
                dateTimePickerView.buttonTitleColor = [UIColor whiteColor];
                dateTimePickerView.minYear = 1900;
                dateTimePickerView.maxYear = [NSDate date].jk_year;
                [ALKeyWindow addSubview:dateTimePickerView];
                [dateTimePickerView showHcdDateTimePicker];
                
                dateTimePickerView.clickedOkBtn = ^(NSString *dateTimeStr) {
                    ((ThreeModel *)self.viewModel.dataModel).eightValue = dateTimeStr;
                    [self reloadData];
                };
            }
                break;
            case ALCommonTypeUserLogout: {
                [[ALAlertController SignalShowAlertViewWith:self title:@"提示" message:@"是否退出登录？" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"确定"]] subscribeNext:^(id x) {
                    [self.viewModel.services resetRootViewModel:[[ALLoginViewModel alloc] initWithServices:self.viewModel.services params:nil]];
                }];
            }
                break;
            default:
                break;
        }
    }];
}

- (NSUInteger)itemNumber {
    return 10;
}

//- (UIView *)headViewForItemAtIndex:(NSUInteger)index {
//    UILabel *headLabel = [UILabel new];
//    headLabel.text = [NSString stringWithFormat:@"head title %ld",index];
//    headLabel.textAlignment = NSTextAlignmentCenter;
//    headLabel.backgroundColor = [UIColor lightGrayColor];
//    return headLabel;
//}

- (UIView *)itemAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [OneView new];
            break;
        case 1:
            return [TwoView new];
            break;
        case 2:
            return [ThreeView new];
            break;
        case 3:
            return [FourView new];
            break;
        case 4:
            return [fiveView new];
            break;
        case 5:
            return [SixView new];
            break;
        case 6:
            return [SevenView new];
            break;
        case 7:
            return [EightView new];
            break;
        case 8:
            return [NineView new];
            break;
        case 9:
            return [TenView new];
            break;
        default:
            break;
    }
    return nil;
}

//- (UIView *)footViewForItemAtIndex:(NSUInteger)index {
//    UILabel *footLabel = [UILabel new];
//    footLabel.text = [NSString stringWithFormat:@"foot title %ld",index];
//    footLabel.textAlignment = NSTextAlignmentCenter;
//    footLabel.backgroundColor = [UIColor grayColor];
//    return footLabel;
//}

//- (NSDictionary *)headOptionAtIndex:(NSUInteger)index {
//    return ALOptionHead(CGSizeMake(self.view.bounds.size.width, 30), CGPointZero, @0, [UIColor redColor]);
//}

- (NSDictionary *)itemOptionAtIndex:(NSUInteger)index {
    
    CGSize itemSize = CGSizeMake(self.view.bounds.size.width, 44);
    CGPoint offsetPoint = CGPointZero;
    NSNumber *spacing = @0;
    UIColor *bgColor = [UIColor whiteColor];
    NSNumber *didSelected = @0;
    
    if(index == 0 || index == 7 || index == 9) {
        if(index == 0)
            itemSize = CGSizeMake(itemSize.width, 100);
        didSelected = @1;
    }
    return ALOptionItem(itemSize, offsetPoint, spacing, bgColor, didSelected);
}

//- (NSDictionary *)footOptionAtIndex:(NSUInteger)index {
//    return ALOptionFoot(CGSizeMake(self.view.bounds.size.width, 30), CGPointZero, @0, [UIColor whiteColor]);
//}

#pragma mark lazy load
- (ALImagePickerController *)imagePickerController {
    if(!_imagePickerController) {
        _imagePickerController = [[ALImagePickerController alloc] init];
    }
    return _imagePickerController;
}
@end
