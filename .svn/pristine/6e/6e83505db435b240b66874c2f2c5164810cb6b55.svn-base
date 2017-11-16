//
//  Header.h
//  StairOrder
//
//  Created by Miles on 2017/8/14.
//  Copyright © 2017年 Miles. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define kTimeStamp [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]]

#define kAppVersion @"1.0.0"

#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

#define kAppThemeColor [UIColor colorWithRed:231/255.0 green:86/255.0 blue:31/255.0 alpha:1]

#define kAppBackgroundColor RGB(239, 239, 239)

#define kAppOrangeColor RGB(249, 187, 4)

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define FONTFIT(F) [MyAdapter laDapter:F]

#define SIZEFIT(S)  [MyAdapter laDapter:S]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define MySecurity [Security shareSecurity]

#define ToolManager [LoginManager shareLoginManager]

#define RC001 if ( [data[@"result"] integerValue] != 1) {[[LLUtils getCurrentVC].view showCenterToast:data[@"message"]];return ;}
#define RC002 if ( [data[@"result"] integerValue] == 1) {[[LLUtils getCurrentVC].view showCenterToast:data[@"message"]];}
#define RC003 if ( [data[@"result"] integerValue] != 1) {return ;}
#define RC004 if ( [data[@"result"] integerValue] != 1) {[[LLUtils getCurrentVC].view showCenterToast:data[@"message"]];}

#define iphone6P (SCREEN_WIDTH == 414)
#define iphone6 (SCREEN_WIDTH == 375)
#define iphone5 (SCREEN_WIDTH == 320)

#define LOGINSUCCESS @"loginSuccessNotification"//登录成功通知

#define ADDGOODSCOUNT @"addGoodsCountNotification"//添加商品数量通知

#define LOGOUTSUCCESS @"logoutSuccessNotification"//退出登录成功通知

#define CLICKITEM @"clickItemNotification"//点击首页分类通知

#define ADDGOODS @"addGoodsNotification"//添加商品通知

#define ORDERCHANGE @"orderChangeNotification"//订单状态改变通知

#define DETAILSUBMITFINISH @"detailSubmitFinishNotification"//详情中提交完成通知

#define ORDERSUBMITFINISH @"orderSubmitFinishNotification"//订单提交完成通知

#define USERINFOCHANGE @"userInfoChangeNotification"//我的界面同步通知

/**
 *    支付相关
 */

#define AliPayUrl @"Pay/Alipay"//商品买单
#define WXPayUrl @"Pay/WXPay"

#define aliPaypartner @"2088121228566601"     //pid
#define aliPaySeller @"267406444@qq.com"      //收款账号

#define aliPayPrivateKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJukMLCltdkmnSKOu7XwYyUhb/KFx2PVnFdubeVVDkmeaB0ZHhLs5SJFDWsCitXhe4VfYXT2GiyxrXqdcF/cM2u6+gp9iSHLxPPv6M0TWbHBuiha9S7x7Nmc9OaVQ7jKt1AD3Xb3geAMuIpF9IZB5W7tosIWgM8bwpeC4HjRVM7VAgMBAAECgYA5FQrWfrAnKEZROlAV9kgmghDwvafXMazZVCLyDTPkRDijE2c4QbH306OML66DquMGk2jG4MvQwImDguKIBdbFhZreYlT9fHGAFkWVTvzzdqZqCgn6TyDu8b2qaJZVksmLMwVVw3l2ZkIUKB/iOvS677z+GC8pDfF/pwUNuxxDgQJBAM46R73TtG16pBMiRQrfPJX1QKLtw4RidURQtlN+LJpgyLjlVEdUAGI2HIzfPuWrkdM4OrFdKzGg6zo9ks1Ncs0CQQDBNHMnc/3Gw1c8MBsBrjGmXCM654yPoYDRq1gb7riyXvw7PkBUwwxxzNR1FrPBCQVQsVuWPzDq/76DH1VK2xwpAkAW8i0hVfjxZX/0ERAVkZkwJkW22zWx+TKLE1/2EkfsNXCgAgRKm3Ife13Z3s0kyN5E3jDJo1A3CWyi4k7/QOrRAkEAvFHrjKE60+rDtR8Os+ye6JEWpevczoOVlMl28IMX9IUxRm2/Nt+H2cTVseuW+qlYTPcTVrfxbp4pjJWWBYjdQQJBALZCk/Z+0hqo9UD4r6qjuzAp+bcmAQJwhWaFhygUmaG/dOJ+cJEmepcdHfwvQeRoHbHnbrvFS2KgSGAhm1peCLg="

#define WXAppId @"wx08e39bf74cbc57e4"
#define WXAppSecret @"9ECF2556015C73226F8FCCC172C3529F"
#define WXPartnerId @"1286715001"


/**
 *    @brief    系统字体.
 */


#define KeyWindow  [[UIApplication sharedApplication].delegate window]
// Color
//////////////////////////////////////////////////

// RGB颜色.
#define WSLColor(r,g,b) WSLColorRGBA(r,g,b,1.0)
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define ws(weakSelf)  WS(weakSelf);
// RGBA颜色.
#define WSLColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO

#define pushID [[UIDevice currentDevice] identifierForVendor].UUIDString

#define deviceInfo [NSString stringWithFormat:@"%@,%@",[UIDevice currentDevice].model,[UIDevice currentDevice].systemVersion]

#define kUserDefault [NSUserDefaults standardUserDefaults]

#define sessionID [NSString get32BitMD5_lowercaseString:pushID]


//通知中心
#define NSNotic_Center [NSNotificationCenter defaultCenter]
#define WeakObj(o) __weak typeof(o) o##Weak = o;

//单例声明
#define singletonInterface(className) + (instancetype)shared##className;
//单例实现
#define singletonImplementation(className)\
static className *_instance;\
+ (id)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##className\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}


//#define gTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define gTipAlert(_S_, ...)      UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] preferredStyle:UIAlertControllerStyleAlert];UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];[alterVC addAction:action];[self presentViewController:alterVC animated:YES completion:nil];

//屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//是否是iphone6以上设备
#define isUpIPhone6 ([UIScreen mainScreen].bounds.size.width > 320)

#define isIPhone6 ([UIScreen mainScreen].bounds.size.height == 667)

#define isIPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

#define isIPhpne4 ([UIScreen mainScreen].bounds.size.height == 480)

//适配高度
#define HHeader               (kScreenHeight/667.0)
#define WHeader               (kScreenWidth/375.0)


#define Font11 [UIFont systemFontOfSize:11.0]
#define Font12 [UIFont systemFontOfSize:12.0]
#define Font13 [UIFont systemFontOfSize:13.0]
#define Font14 [UIFont systemFontOfSize:14.0]
#define Font15 [UIFont systemFontOfSize:15.0]
#define Font16 [UIFont systemFontOfSize:16.0]
#define Font17 [UIFont systemFontOfSize:17.0]
#define Font18 [UIFont systemFontOfSize:18.0]
#define Font19 [UIFont systemFontOfSize:19.0]
#define Font20 [UIFont systemFontOfSize:20.0]
#define Font22 [UIFont systemFontOfSize:22.0]

//IPHONE 6
#define kWidthScale kScreenWidth/375.0f
#define kHeightScale kScreenHeight/667.0f

#define kFont10 [UIFont systemFontOfSize:10*kWidthScale]
#define kFont11 [UIFont systemFontOfSize:11*kWidthScale]
#define kFont12 [UIFont systemFontOfSize:12*kWidthScale]
#define kFont13 [UIFont systemFontOfSize:13*kWidthScale]
#define kFont14 [UIFont systemFontOfSize:14*kWidthScale]
#define kFont15 [UIFont systemFontOfSize:15*kWidthScale]
#define kFont16 [UIFont systemFontOfSize:16*kWidthScale]
#define kFont17 [UIFont systemFontOfSize:17*kWidthScale]
#define kFont18 [UIFont systemFontOfSize:18*kWidthScale]
#define kFont19 [UIFont systemFontOfSize:19*kWidthScale]
#define kFont20 [UIFont systemFontOfSize:20*kWidthScale]
#define kFont30 [UIFont systemFontOfSize:30*kWidthScale]


//基本类型转String/Number
#define integerToStr(para) [NSString stringWithFormat:@"%ld",para]
#define intToStr(para)     [NSString stringWithFormat:@"%d",para]
#define floatToStr(para)   [NSString stringWithFormat:@"%f",para]
#define doubleToStr(para)  [NSString stringWithFormat:@"%f",para]
#define numToStr(para)     [NSString stringWithFormat:@"%@",para]
#define strToNum(para)     [NSNumber numberWithString:para]

//空判断相关
#define isEmptyStr(str) (!str||[str isKindOfClass:[NSNull class]]||[str isEqualToString:@""]) //判断是否空字符串
#define isEmptyArr(arr) (!arr||((NSArray *)arr).count==0) //判断是否空数组

#define isNull(str)     (!str||[str isKindOfClass:[NSNull class]])

#define isEqualValue(String_Number,Integer) ([String_Number integerValue]==Integer) //判断参数1与参数2是否相等 适用于NSNumber,NSString类型与整型判断

#define kHandleEmptyStr(str) (isEmptyStr(str)?@"":str)  //解决空字符串问题
#define kEmptyStrToZero(str) (isEmptyStr(str)?@"0":str)  //解决空字符串问题

//文件管理相关
#define kFileManager [NSFileManager defaultManager]

#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory\
, NSUserDomainMask, YES)[0]

/*******************城市相关*************************/



//城市相关
#define kCityName      [kUserDefault objectForKey:@"AreaName"]      //城市名 全称
#define kCityID        [kUserDefault objectForKey:@"AreaID"]        //城市ID
#define kCityShortName [kUserDefault objectForKey:@"AreaShortName"] //城市名 简称

#define kAreaVersion   [kUserDefault objectForKey:@"AreaVersion"]   //地区版本号
#define SERVICETEL @"SERVICETEL"


/*******************请求常用宏，以及用户信息宏*************************/

//时间戳
//#define kTimeStamp  [NSString stringWithFormat:@"%lld",[[kUserDefault objectForKey:@"TimeDifference"] intValue]+(long long)[[NSDate date] timeIntervalSince1970]]
#define kTimeStamp [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]]

//UUID设备唯一标示
#define kUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
//设备信息
#define kDeviceInfo [NSString stringWithFormat:@"%@,%@",[UIDevice currentDevice].model,[[UIDevice currentDevice] systemVersion]]

//签名
#define kSignWithIdentify(identifier) [[NSString stringWithFormat:@"%@%@%@%@%@",kUUID,identifier,kUid,kToken,kTimeStamp] md5String]

#define kSignIdentifyWithStr(identifier,string) [[NSString stringWithFormat:@"%@%@%@%@%@%@",kUUID,identifier,kUid,kToken,kTimeStamp,string] md5String]

//是否登录
#define didLogin [kUserDefault objectForKey:@"token"]

#define kHasBuildFranchiseeInfo [[kUserDefault objectForKey:@"kHasBuildFranchiseeInfo"] isEqualToNumber:@(YES)]

#define KplaceholderImage @""

//用户ID
#define kUid [kUserDefault objectForKey:@"userId"]

//用户名,会员名
#define kMemeberName [kUserDefault objectForKey:@"member_name"]


#define kLineColor RGB(239, 239, 239)

#define KColorHex(hex) [LLUtils colorWithHex:(hex)]


#endif /* Header_h */

