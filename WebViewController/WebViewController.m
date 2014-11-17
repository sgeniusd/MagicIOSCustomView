//
//  BTWebViewController.m
//  AABabyTing3
//
//  Created by Zero on 9/4/12.
//
//

#import "WebViewController.h"
#import "PKAppDelegate.h"
#import "PKWebView.h"

const CGFloat kSpaceHeight = 44.0f;

@interface WebViewController ()

@property (nonatomic,strong) PKWebView *theWebView;

@end

@implementation WebViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - 加载WebView
- (void)loadWebView:(NSString *)aUrlStr {
    
    if (nil == _theWebView) {
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        CGFloat height = winSize.height-30;
        if (!iOS7) {
            height -=20;
        }
        _theWebView = [[PKWebView alloc] initWithFrame:CGRectMake(0, 0, winSize.width,height)];
        _theWebView.bIsNeedToShowWaiting = YES;
        _theWebView.needToShowToolBar = _showToolBar;
        [self.view addSubview:_theWebView];
    }

    for (id subview in [_theWebView.webView subviews]){
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
    }
	
    [_theWebView loadWebRequest:[NSURL URLWithString:aUrlStr]];
    
}

#pragma mark - 设置url
- (void)setUrlStr:(NSString *)aUrlStr {
	_urlStr = [aUrlStr copy];
	[self loadWebView:_urlStr];
}

#pragma mark - LifeCycle

- (id)initWithUrl:(NSString *)aUrlStr{
	if (self = [super init]) {
		self.urlStr = aUrlStr;
        self.hidesBottomBarWhenPushed = YES;
	}
	return self;
}

- (id)initWithUrlAndColor:(NSString *)aUrlStr color:(UIColor*)bgcolor{
	if (self = [super init]) {
		self.urlStr = aUrlStr;
        self.bgColor = bgcolor;
        self.hidesBottomBarWhenPushed = YES;
	}
	return self;
}

- (void)setTheTitle:(NSString *)theTitle {
    if (theTitle!=_theTitle) {
        _theTitle = [theTitle copy];
    }
}

- (void)dealloc {

}

- (void)setShowToolBar:(BOOL)showToolBar
{
    _showToolBar = showToolBar;
    
    _theWebView.needToShowToolBar = _showToolBar;
}

- (void)viewDidLoad
{
	self.topBack = YES;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.titleViewLable.text = @"回家吃饭";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
