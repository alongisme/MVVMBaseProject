//
//  ALImagePickerController.h
//  HealthJiaYuan
//
//  Created by along on 2017/2/7.
//  Copyright © 2017年 along. All rights reserved.
//

@interface ALImagePickerController : NSObject
- (instancetype)initWithController:(UIViewController *)controller SourceType:(UIImagePickerControllerSourceType)soureType choseImageBlcok:(void (^)(UIImage *image,NSDictionary *info))choseImageBlock cannelBlock:(void (^)())cannelBlock;
@end
