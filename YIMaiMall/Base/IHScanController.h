//
//  LLScanController.h
//  XiaoKe
//
//  Created by kevin on 2017/5/18.
//  Copyright © 2017年 com.znycat.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface IHScanController : UIViewController

/**
 单例
 
 @return 单例对象
 */
+ (id)shared;

/**
 要扫描的条码类型
 默认值为 @[AVMetadataObjectTypeQRCode],即默认扫描二维码
 */
@property (nonatomic, strong) NSArray *metadataObjectTypes;


/**
 底部提示字符串
 */
@property (nonatomic, copy) NSString *promptStr;


/**
 获取到快递单的图片
 expressReceiptImgData : 快递单的图片
 */
@property (nonatomic, copy) void(^onGetExpressReceiptImage)(NSData *expressReceiptImgData);

/**
 扫描完成回调
 isSuccess : 是否扫描成功
 scanStr : 扫描结果字符串
 */
@property (nonatomic, copy) void(^onScanCompletion)(BOOL isSuccess,NSString *scanStr);

@end
