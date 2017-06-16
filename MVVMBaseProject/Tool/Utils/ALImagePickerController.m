//
//  ALImagePickerController.m
//  HealthJiaYuan
//
//  Created by along on 2017/2/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALImagePickerController.h"

@interface ALImagePickerController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,copy) void (^choseImage)(UIImage *image, NSDictionary *info);
@property (nonatomic,copy) void (^cannel)();
@end

@implementation ALImagePickerController

- (instancetype)initWithController:(UIViewController *)controller SourceType:(UIImagePickerControllerSourceType)soureType choseImageBlcok:(void (^)(UIImage *image,NSDictionary *info))choseImageBlock cannelBlock:(void (^)())cannelBlock {
    if(self = [super init]) {
        self.choseImage = choseImageBlock;
        self.cannel = cannelBlock;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.allowsEditing = YES;
        // 设置代理
        imagePickerController.delegate = self;
        
        // 判断数据来源是否可用
        if([UIImagePickerController isSourceTypeAvailable:soureType]) {
            // 设置数据来源
            imagePickerController.sourceType = soureType;
            // 打开相机/相册/图库
            [controller presentViewController:imagePickerController animated:YES completion:nil];
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
    if(_choseImage) {
        _choseImage(image,info);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
