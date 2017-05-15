//
//  ALImagePickerController.h
//  HealthJiaYuan
//
//  Created by along on 2017/2/7.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALImagePickerController : NSObject
- (instancetype)initWithController:(UIViewController *)controller SourceType:(UIImagePickerControllerSourceType)soureType choseImageBlcok:(void (^)(UIImage *image))choseImageBlock cannelBlock:(void (^)())cannelBlock;
@end
