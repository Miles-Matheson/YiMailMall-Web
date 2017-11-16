//
//  WebViewController.m
//  ylb
//
//  Created by gravel on 16/3/15.
//  Copyright © 2016年 gravel. All rights reserved.
//




#import "WebViewController.h"
#import "IHScanController.h"
#import "Header.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "JumpWebController.h"

@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate,WKScriptMessageHandler>

@property (nonatomic,copy)NSString *requestUrlString;

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) CGFloat delayTime;

@end

@implementation WebViewController

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    
    if (self = [super init]){
        
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"onclick='shopke://scancode'"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (@available (ios 11.0,*)) {
        if (!_requestUrlString) {
            UIView *view = self.navigationController.navigationBar.subviews.firstObject;
            view.subviews.lastObject.alpha = 0;
        }else{
            UIView *view = self.navigationController.navigationBar.subviews.firstObject;
            view.subviews.lastObject.alpha = 1;
            self.navigationController.navigationBarHidden = NO;
            _webView.frame = CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height);
        }
        
    }else{
        if (!_requestUrlString) {
            self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
        }else{
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
            _webView.frame = CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height);
        }
    }
    
    [self.navigationController  setNavigationBarHidden:YES animated:NO];
}

+(WebViewController *)loadURLWithString:(NSString *)urlString
{
    WebViewController *VC = [[WebViewController alloc]init];
    VC.requestUrlString = urlString;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    
    [VC.webView loadRequest:request];
    return VC;
}

-(void)setRequestUrlString:(NSString *)requestUrlString
{
    _requestUrlString = requestUrlString;
    
    [self reloadData ];
}

-(void)reloadData
{
    __weak typeof(self) weakSelf = self;
    
    //监听网络状态 避免iOS10 app首次进入网络没有授权主页面发请求失败
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if (status == AFNetworkReachabilityStatusNotReachable){
            
            [SVProgressHUD showErrorWithStatus:@"网络未连接"];
            return;
        }else if (status == AFNetworkReachabilityStatusUnknown){
            [SVProgressHUD showErrorWithStatus:@"未知网络"];
        }else if ((status == AFNetworkReachabilityStatusReachableViaWWAN)||(status == AFNetworkReachabilityStatusReachableViaWiFi)){
            
            NSURL *url = [NSURL URLWithString:weakSelf.requestUrlString];
            
            [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }];
}

-(WKWebView *)webView
{
    if (!_webView) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
        // 支持内嵌视频播放，不然网页中的视频无法播放
        config.allowsInlineMediaPlayback = YES;
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        [self.view addSubview:_webView];
        
        _webView.scrollView.delegate = self;
        
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        // 开始右滑返回手势
        _webView.allowsBackForwardNavigationGestures = YES;
        
        NSKeyValueObservingOptions observingOptions = NSKeyValueObservingOptionNew;
        // KVO 监听属性，除了下面列举的两个，还有其他的一些属性，具体参考 WKWebView 的头文件
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:observingOptions context:nil];
        [_webView addObserver:self forKeyPath:@"title" options:observingOptions context:nil];
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:observingOptions context:nil];
    }
    
    return _webView;
}

-(UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 2)];
        [self.view addSubview:_progressView];
        _progressView.progressTintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress < 1.0) {
            self.delayTime = 1 - self.webView.estimatedProgress;
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.progress = 0;
        });
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        
    }
}

#pragma mark - WKNavigationDelegate
// 开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {

}

// 页面加载完调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {

    [self.webView evaluateJavaScript:@"document.getElementsByClassName('btn')[1].href='shopke://scancode';document.getElementsByClassName('btn')[1].onclick='';" completionHandler:^(id _Nullable a, NSError * _Nullable error) {
    }];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {

}

// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {

}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    
    if([scheme isEqualToString:@"shopke"]){
        [self handleCustomAction:URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - private method
- (void)handleCustomAction:(NSURL *)URL{
    NSString *url = [URL absoluteString];
    if ([url isEqualToString:@"shopke://scancode"]) {
        NSLog(@"扫一扫");
        __weak typeof(self) selfWeak = self;
        IHScanController *scanVC = [[IHScanController  alloc] init];
        scanVC.onScanCompletion = ^(BOOL isSuccess, NSString *scanStr) {
            if (isSuccess) {
                //扫描成功
                if ([scanStr hasPrefix:@"http"]||[scanStr hasPrefix:@"https"]||[scanStr hasPrefix:@"www"]) {
                    //网页
                    [selfWeak.navigationController setNavigationBarHidden:NO animated:NO];
                    JumpWebController *webVc = [[JumpWebController alloc]init];
                    webVc.URLString = scanStr;
                    [selfWeak.navigationController pushViewController:webVc animated:YES];
                }
            }
            [selfWeak dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:scanVC animated:YES completion:nil];
    }
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {

    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 加载 HTTPS 的链接，需要权限认证时调用  \  如果 HTTPS 是用的证书在信任列表中这不要此代理方法
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

#pragma mark - WKUIDelegate

// 提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
        textField.placeholder = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"startScan"];
}

@end

