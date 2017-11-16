//
//  LLScanController.m
//  XiaoKe
//
//  Created by kevin on 2017/5/18.
//  Copyright © 2017年 com.znycat.com. All rights reserved.
//

#import "IHScanController.h"
#import "PureLayout.h"

@interface IHScanController () <AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    UIImageView * imageView;
    
    BOOL hasCameraRight;
    BOOL _isCaptureMetadata; //是否捕获了元数据
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) UIImageView * line;

/**
 *  照片输出流
 */
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;

@end

@implementation IHScanController


/**
 单例

 @return 单例对象
 */
+ (id)shared{
    static IHScanController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[IHScanController alloc] init];
    });
    return shared;
}

-(void)clickLeftBtn:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.view.backgroundColor = [UIColor clearColor];

    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有相机权限" message:@"请去设置-隐私-相机中对分期帮授权" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:okAction];
        
        hasCameraRight = NO;
        return;
    }
    hasCameraRight = YES;
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0.8 * self.view.frame.size.width, 0.8 * self.view.frame.size.width)];
    imageView.image = [UIImage imageNamed:@"contact_scanframe"];
    [self.view addSubview:imageView];
    [imageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100+50];
    [imageView autoSetDimensionsToSize:CGSizeMake(0.8 * self.view.frame.size.width, 0.8 * self.view.frame.size.width)];
    
    UILabel * labIntroudction = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 30)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.text = _promptStr?:@"将取景框对准二维码/条码，即自动扫描";
    labIntroudction.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:labIntroudction];
    [labIntroudction autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:imageView];
    [labIntroudction autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:imageView];
    [labIntroudction autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageView withOffset:8];
    
    
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110+50, 220, 2)];
    _line.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:_line];
    [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:imageView withOffset:40];
    [_line autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:imageView withOffset:-40];
    [_line autoSetDimension:ALDimensionHeight toSize:2];
    [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:imageView withOffset:10];
    
    [self setupCamera];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 30, 70, 30);
    [leftBtn setTitle:@"取消" forState:0];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.userInteractionEnabled = YES;

    [self.view addSubview:leftBtn];
}

//- (void)clickLeftBtn{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(_line.frame), 110+50+2*num, CGRectGetWidth(_line.frame), CGRectGetHeight(_line.frame));
        if (2 * num >= CGRectGetHeight(imageView.frame) - 20) {
            upOrdown = YES;
        }
    } else {
        num --;
        _line.frame = CGRectMake(CGRectGetMinX(_line.frame), 110+50+2*num, CGRectGetWidth(_line.frame), CGRectGetHeight(_line.frame));
        if (num <= 0) {
            upOrdown = NO;
        }
    }
    
}

- (BOOL)navigationShouldPopOnBackButton
{
    [timer invalidate];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    if (@available (ios 11.0,*)) {

            UIView *view = self.navigationController.navigationBar.subviews.firstObject;
            view.subviews.lastObject.alpha = 1;
            self.navigationController.navigationBarHidden = NO;
    }else{
       
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    }
    
    _isCaptureMetadata = NO;
    
    if (hasCameraRight) {
        if (_session && ![_session isRunning]) {
            [_session startRunning];
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setupCamera
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        // Device
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        // Output
        _output = [[AVCaptureMetadataOutput alloc]init];
        //    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // Session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        //设置照片输出流
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
        NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
        [self.stillImageOutput setOutputSettings:outputSettings];
        
        if ([self.session canAddOutput:self.stillImageOutput]) {
            [self.session addOutput:self.stillImageOutput];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes = _metadataObjectTypes?:@[AVMetadataObjectTypeQRCode];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            // Preview
            _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            //    _preview.frame =CGRectMake(20,110,280,280);
            _preview.frame = self.view.bounds;
            [self.view.layer insertSublayer:self.preview atIndex:0];
            // Start
            [_session startRunning];
        });
    });
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (_isCaptureMetadata) {
        return;
    }
    
    NSString *stringValue = nil;
    
    if ([metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
//        [_session stopRunning];
//        [timer invalidate];
        NSLog(@"%@",stringValue);
        
        if (stringValue.length > 0) {
            //扫描到了
            _isCaptureMetadata = YES;
            [self captureStillImage];
            if (_onScanCompletion) {
                _onScanCompletion(YES,stringValue);
            }
            return;
        }
    }
    
    if (_onScanCompletion) {
        _onScanCompletion(NO,nil);
    }
}

//捕获静态图
- (void)captureStillImage{
    //get connection
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    if (videoConnection) {
        [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if (!imageDataSampleBuffer) {
                return ;
            }
            NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            [_session stopRunning];
            [timer invalidate];
            if (_onGetExpressReceiptImage) {
                _onGetExpressReceiptImage(jpegData);
            }
        }];
    }
}

- (UIImage *)previewImage:(AVCaptureConnection *)connection{
    
//    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
//    AVCaptureVideoOrientation avcaptureOrientation = [self avOrientationForDeviceOrientation:curDeviceOrientation];
//    [_stillImageConnection setVideoOrientation:avcaptureOrientation];
//    [_stillImageConnection setVideoScaleAndCropFactor:self.effectiveScale];

    
    UIImage* image = nil;
    UIView * view = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, 1);
    {
//        CGPoint savedContentOffset = scrollView.contentOffset;
//        CGRect savedFrame = scrollView.frame;
//        scrollView.contentOffset = CGPointZero;
//        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [view.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
//        scrollView.contentOffset = savedContentOffset;
//        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}

- (UIImage *)screenshot
{
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
