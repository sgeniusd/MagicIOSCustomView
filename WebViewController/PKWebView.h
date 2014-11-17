//
//  BTWebView.h
//  AABabyTing3
//
//  Created by Tiny on 12-10-15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PKWebToolBar.h"

@interface PKWebView : UIView<UIWebViewDelegate,BTWebToolbarDelegate,UIActionSheetDelegate>{
    UIWebView *_webView;
    BOOL bIsShowingAlert;
    BOOL _bIsNeedToShowWaiting;
    BTWebToolBar  *_webToolBarView;
}

@property (nonatomic,retain) UIWebView *webView;
//@property (nonatomic,retain) MBProgressHUD *waiting;
@property (nonatomic,assign) BOOL bIsNeedToShowWaiting;
@property (nonatomic,assign) BOOL needToShowToolBar;        //是否需要显示工具栏(默认为NO)

-(void)loadWebRequest:(NSURL *)url;
-(void)showWaiting;
-(void)hideWaiting;

@end
