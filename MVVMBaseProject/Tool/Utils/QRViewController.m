//
//  QRViewController.m
//  Lonsdale
//
//  Created by 3ti on 15/7/3.
//  Copyright (c) 2015年 threeti. All rights reserved.
//

#import "QRViewController.h"

@interface QRViewController ()
{
    NSTimer *_timer;
    UIImageView *_imageView;
    
    UIImageView *_lineImageView;
}
@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = YES;

    [self.view.layer addSublayer:self.preview];
    
    [self initUiConfig];
    
}

-(void)leftClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI:(CGRect)previewFrame {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (error) {
        NSLog(@"你手机不支持二维码扫描!");
        return;
    }
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;

    self.preview.frame = previewFrame;
    
    [self.view.layer addSublayer:self.preview];
    
    if ([UIScreen mainScreen].bounds.size.height == 480)
    {
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    }
    else
    {
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    [self.session startRunning];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *val = nil;
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        [self.session stopRunning];
        [self.preview removeFromSuperlayer];
        
        val = obj.stringValue;
        [self requestCouponData:val];
    }
}

//处理扫描到的数据
- (void)requestCouponData:(NSString *)couponstr {
//    NSData *data = [[NSData alloc]initWithData:[couponstr dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    [self leftClick];
    
}

- (void)Tipclicked {
    [self.session startRunning];
    [self.view.layer addSublayer:self.preview];
    [self initUiConfig];
}


- (void)initUiConfig {
    [self initUI:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twolevelRect"]];
    _imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*1/3/2, 68*[UIScreen mainScreen].bounds.size.height/568, [UIScreen mainScreen].bounds.size.width*2/3, 240*[UIScreen mainScreen].bounds.size.height/568);
    [self.view addSubview:_imageView];
    
    //设置扫描区域  y,x,h,w
    [self.output setRectOfInterest:CGRectMake(CGRectGetMinY(_imageView.frame) / [UIScreen mainScreen].bounds.size.height,
                                              (([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(_imageView.frame)))/2/[UIScreen mainScreen].bounds.size.width,
                                              CGRectGetHeight(_imageView.frame) / [UIScreen mainScreen].bounds.size.height,
                                              CGRectGetWidth(_imageView.frame) / [UIScreen mainScreen].bounds.size.width)];

    UIView *viewup = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,68*[UIScreen mainScreen].bounds.size.height/568)];
    viewup.backgroundColor = [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.5];
    [self.view addSubview:viewup];
    
    UIView *viewdown = [[UIView alloc]initWithFrame:CGRectMake(0, 308*[UIScreen mainScreen].bounds.size.height/568, [UIScreen mainScreen].bounds.size.width,260*[UIScreen mainScreen].bounds.size.height/568)];
    viewdown.backgroundColor = [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.5];
    [self.view addSubview:viewdown];
    
    UIView *viewleft = [[UIView alloc]initWithFrame:CGRectMake(0, 68*[UIScreen mainScreen].bounds.size.height/568, [UIScreen mainScreen].bounds.size.width*1/3/2, 240*[UIScreen mainScreen].bounds.size.height/568)];
    viewleft.backgroundColor = [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.5];
    [self.view addSubview:viewleft];
    
    UIView *viewright = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*5/6, 68*[UIScreen mainScreen].bounds.size.height/568, [UIScreen mainScreen].bounds.size.width*1/3/2, 240*[UIScreen mainScreen].bounds.size.height/568)];
    viewright.backgroundColor = [UIColor colorWithRed:5.0/255.0 green:5.0/255.0 blue:5.0/255.0 alpha:0.5];
    [self.view addSubview:viewright];
    
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,212*[UIScreen mainScreen].bounds.size.width/320, 2)];
    _lineImageView.image = [UIImage imageNamed:@"twolevelLine"];
    [_imageView addSubview:_lineImageView];
  
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _lineImageView.frame = CGRectMake(0, 240*[UIScreen mainScreen].bounds.size.height/568, 212*[UIScreen mainScreen].bounds.size.width/320, 2);
        
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(0, 0, 212*[UIScreen mainScreen].bounds.size.width/320, 2);
    }];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    

}

- (void)animation {
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _lineImageView.frame = CGRectMake(0, 240*[UIScreen mainScreen].bounds.size.height/568, 212*[UIScreen mainScreen].bounds.size.width/320, 2);
        
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(0, 0, 212*[UIScreen mainScreen].bounds.size.width/320, 2);
    }];
}

@end
