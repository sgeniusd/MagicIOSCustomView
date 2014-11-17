//
//  BTWebViewController.h
//
//

#import <UIKit/UIKit.h>
#import "PKCustomViewController.h"

@interface WebViewController : PKCustomViewController
@property (nonatomic, copy)		NSString	*urlStr;	//请求访问的url
@property (nonatomic, assign)   BOOL        showToolBar;    //判断是否显示web页工具栏

- (id)initWithUrl:(NSString *)aUrlStr;
- (id)initWithUrlAndColor:(NSString *)aUrlStr color:(UIColor*)bgcolor;

@property (nonatomic,copy) NSString *theTitle;
@property (nonatomic,retain) UIColor  *bgColor;
@end
