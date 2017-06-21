//
//  ALImagePickerController.m
//  HealthJiaYuan
//
//  Created by along on 2017/2/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ALImagePickerController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,copy) void (^choseImage)(UIImage *image, NSDictionary *info);
@property (nonatomic,copy) void (^cannel)();
@end

@implementation ALImagePickerController

- (instancetype)initWithSourceType:(UIImagePickerControllerSourceType)soureType Edit:(BOOL)edit choseImageBlcok:(void (^)(UIImage *image,NSDictionary *info))choseImageBlock cannelBlock:(void (^)())cannelBlock {
    if(self = [super init]) {
        self.choseImage = choseImageBlock;
        self.cannel = cannelBlock;
        self.allowsEditing = edit;
        self.delegate = self;
        // 判断数据来源是否可用
        if([UIImagePickerController isSourceTypeAvailable:soureType]) {
            // 设置数据来源
            self.sourceType = soureType;
        }
    }
    return self;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if(_cannel) {
        _cannel();
    }
    // 退出当前界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    __weak typeof(self) weakself = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if(weakself.choseImage) {
            weakself.choseImage(image,info);
        }
    }];
}

- (RACSignal *)SignalWithViewController:(UIViewController *)viewController SourceType:(UIImagePickerControllerSourceType)soureType Edit:(BOOL)edit {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
        pickerController.allowsEditing = edit;
        pickerController.delegate = self;
        // 判断数据来源是否可用
        if([UIImagePickerController isSourceTypeAvailable:soureType]) {
            // 设置数据来源
            pickerController.sourceType = soureType;
        }
        [viewController presentViewController:pickerController animated:YES completion:nil];
        
        [[self rac_signalForSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:) fromProtocol:@protocol(UIImagePickerControllerDelegate)] subscribeNext:^(RACTuple *tuple) {
            [subscriber sendNext:tuple.second];
            [subscriber sendCompleted];
        }];
        
        [[self rac_signalForSelector:@selector(imagePickerControllerDidCancel:) fromProtocol:@protocol(UIImagePickerControllerDelegate)] subscribeNext:^(id x) {
            [subscriber sendNext:@999];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [pickerController dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
}
@end
