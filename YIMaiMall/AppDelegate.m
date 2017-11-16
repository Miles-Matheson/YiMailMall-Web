//
//  AppDelegate.m
//  YIMaiMall
//
//  Created by Miles on 2017/11/13.
//  Copyright © 2017年 Miles. All rights reserved.
//

#import "AppDelegate.h"
#import "WebViewController.h"
#import "XZMCoreNewFeatureVC.h"
#import "XHLaunchAd.h"
@interface AppDelegate ()<XHLaunchAdDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
     UINavigationController   *nav = [[UINavigationController alloc]initWithRootViewController:[WebViewController loadURLWithString:@"http://www.afanfan.com/wap/index.htm"]];

        //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
//        BOOL canShow = [XZMCoreNewFeatureVC canShowNewFeature];
//
//        if(canShow){ // 初始化新特性界面
//            self.window.rootViewController = [XZMCoreNewFeatureVC newFeatureVCWithImageNames:@[@"lauch_1",@"lauch_2",@"lauch_3",@"lauch_4"] enterBlock:^{
//
//                self.window.rootViewController = nav;
//
//            } configuration:^(UIButton *enterButton) {  //配置进入按钮 仅在最一张图片显示
//
//                [enterButton setTitleColor:kAppThemeColor forState:0];
//                [enterButton setTintColor:kAppThemeColor];
//                [enterButton  setTitle:@"立即进入" forState:0];
//                enterButton.layer.borderWidth = 1.0;
//                enterButton.layer.borderColor = kAppThemeColor.CGColor;
//                enterButton.bounds = CGRectMake(0, 0, 120, 40);
//                enterButton.center = CGPointMake(KScreenW * 0.5, KScreenH* 0.85);
//            }];
//
//        }else{
    
      self.window.rootViewController = nav;
//        }
    
//    [self showCustomVideoADIsFirstOpenAPP:canShow];
    
    [self.window makeKeyAndVisible];
    return YES;
}


//--2.2.2 自定义配置初始化
- (void)showCustomVideoADIsFirstOpenAPP:(BOOL)isFirstOpen
{
    //2.自定义配置
    
    /**********************************************************************************************************/
    /*若你的广告图片/视频URL来源于数据请求,请在请求数据前设置等待时间,在数据请求成功回调里配置广告,如下:*/
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将自动进入window的RootVC
    //3.数据获取成功,初始化广告时,自动结束等待,显示广告.
    
    //设置数据等待时间
    [XHLaunchAd setWaitDataDuration:3];//请求广告URL前,必须设置,否则会先进入window的RootVC
    
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-150);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"1136";
    //网络图片缓存机制(只对网络图片有效)
    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开链接
    imageAdconfiguration.openURLString =  [NSString stringWithFormat:@"https://www.baidu.com"];
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
    
    //[XHLaunchAd clearDiskCache];
}

//1.XHLaunchImageAdConfiguration 和XHLaunchVideoAdConfiguration 均有一个configuration.customSkipView 属性
//2.自定义一个skipView 赋值给configuration.customSkipView属性 便可替换默认跳过按钮 如下:
//configuration.customSkipView = [self customSkipView];
/**
 *  广告点击
 *
 *  @param launchAd      launchAd
 *  @param openURLString  打开页面地址
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString
{
    WebViewController *webVC = [WebViewController loadURLWithString:openURLString];
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    nav.navigationBarHidden = YES;
    [nav pushViewController:webVC animated:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
