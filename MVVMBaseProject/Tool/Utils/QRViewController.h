//
//  QRViewController.h
//  Lonsdale
//
//  Created by 3ti on 15/7/3.
//  Copyright (c) 2015年 threeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^DoctorTidBlock)(NSString *);

@interface QRViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic)AVCaptureDevice *device;

@property (strong,nonatomic)AVCaptureMetadataOutput *output;

@property (strong,nonatomic)AVCaptureDeviceInput *input;

@property (strong, nonatomic)AVCaptureSession *session;

@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;


@property (copy, nonatomic)DoctorTidBlock block;
@end
