//
//  BTWebView.m
//  AABabyTing3
//
//  Created by Tiny on 12-10-15.
//
//

#import "PKWebView.h"
#import "PKNetworkingDefine.h"

#define WEB_TOOLBAR_HEIGHT  49

@implementation PKWebView

@synthesize webView = _webView;
@synthesize bIsNeedToShowWaiting = _bIsNeedToShowWaiting;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        [self addSubview:_webView];
        
        //添加进入应用失去焦点时的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive:) name:@"UIApplicationWillResignActiveNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWebToolbarStatus) name:@"UIApplicationWillEnterForegroundNotification" object:nil];
        _bIsNeedToShowWaiting = YES;
    }
    return self;
}
//加载web页Url
-(void)loadWebRequest:(NSURL *)url{
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

//显示等待
-(void)showWaiting{
}

/*
 *  显示web工具栏
 */
- (void)showWebToolbar
{
    CGFloat heightSize = 0;
    if (iOS7) {
        heightSize = 35;
    }
    if (_webToolBarView == nil) {
        _webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-WEB_TOOLBAR_HEIGHT+5-heightSize);
        
        _webToolBarView = [[BTWebToolBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_webView.frame), 320, WEB_TOOLBAR_HEIGHT)];
        _webToolBarView.backgroundColor = [UIColor clearColor];
        _webToolBarView.eventDelegate = self;
        [self addSubview:_webToolBarView];
    }
}

/*
 *  同步web工具栏状态
 */
- (void)syncWebToolbarStatus
{
    if ([_webView canGoBack]) {
        [_webToolBarView setGoBackEnable:YES];
    } else {
        [_webToolBarView setGoBackEnable:NO];
    }
    
    if ([_webView canGoForward]) {
        [_webToolBarView setGoForwardEnable:YES];
    } else {
        [_webToolBarView setGoForwardEnable:NO];
    }
}

//隐藏等待
-(void)hideWaiting{
}
- (void)loadingHidden{
}

//失去焦点时的处理
-(void)willResignActive:(id)sender{
    if (!_webView.isLoading ) {
        [self hideWaiting];
    }
}

- (void)refreshWebToolbarStatus
{
    if (_needToShowToolBar) {
        [self syncWebToolbarStatus];
    }
}

#pragma mark - 
#pragma mark BTWebToolbarDelegate

//返回
- (void)webToolbarGoBack
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

//前进
- (void)webToolbarGoForward
{
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

//刷新
- (void)webToolbarRefresh
{
    [_webView reload];
}

- (void)webToolbarMore
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"通过Safari打开",@"取消",nil];
    [actionSheet showInView:self];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:kDefaultOpenURL]];
    }
}

#pragma mark -
#pragma UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    if (_bIsNeedToShowWaiting) {
        [self showWaiting];
    }

    if (_needToShowToolBar) {
        [self showWebToolbar];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideWaiting];
    
    if (_needToShowToolBar) {
        [self syncWebToolbarStatus];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self hideWaiting];
    NSString *errorString = nil;
    switch (error.code) {
        case 101://超时
            errorString = @"打不开该网页,因为它无法连接到服务器。";
            break;
        case -1009://没有网络
        case -1004:
            errorString = @"打不开该网页,因为它尚未接入互联网。";
            break;
        default:
            break;
    }
    
    if(errorString && !bIsShowingAlert){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法打开网页"
                                                        message:errorString
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        bIsShowingAlert = YES;
    }

}
//避免多次弹出提示框
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    bIsShowingAlert = NO;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
