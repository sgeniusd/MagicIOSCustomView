//
//  PKCheckInManager.m
//  PrivateKitchen
//
//  Created by hw on 14-9-16.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import "PKCheckInManager.h"
#import "PKNetworkingDefine.h"

@interface PKCheckInManager () <UIAlertViewDelegate>

- (void)showForceUpdateAlert;

@end

@implementation PKCheckInManager

static PKCheckInManager *___sharedInstance = nil;

+ (PKCheckInManager *)sharedInstance
{
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        ___sharedInstance = [[PKCheckInManager alloc]init];
    });
    return ___sharedInstance;
}

- (void)destory
{
    ___sharedInstance = nil;
}

/**
 *  执行Check In请求
 */
- (void)checkIn
{
    
    
    NSBundle *mainBundle = [NSBundle mainBundle];
	NSDictionary *infoDictionary = [mainBundle infoDictionary];
	NSString *appVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSDictionary *requestDic = @{@"type":self.appType,
                                 @"version":appVersion,
                                 @"platform":@"ios",
                                 @"update_time":[NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]],};
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager requestSerializer].timeoutInterval = kNetworkTimeoutInterval;
    [manager POST:/*[kRequest_CheckIn requestURL]*/kRequest_CheckIn parameters:requestDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        switch ([responseObject[@"code"]integerValue]) {
            case 0:     //成功
                break;
            case 1:     //参数错误
                break;
            case 2:     //有新的版本和数据
                _needUpdate = YES;
                break;
            case 3:     //新数据
                break;
            case 4:     //新版本
                _needUpdate = YES;
                break;
            case 100:   //需要强制更新
                _needForceUpdate = YES;
                break;
            default:
                break;
        }
        NSDictionary *responseData = responseObject[@"data"];
        if ([responseData isKindOfClass:[NSDictionary class]]) {
            self.mesage = responseData[@"description"];
            self.jumpUrl = responseData[@"url"];
            
            if (_needForceUpdate) {
                [self showForceUpdateAlert];
            } else if (_needUpdate) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"版本更新" message:responseData[@"description"] delegate:___sharedInstance cancelButtonTitle:@"更新" otherButtonTitles:@"稍后再说",nil];
                alertView.delegate = ___sharedInstance;
                [alertView show];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
    }];
}

/**
 *  检测强制升级
 */
- (void)checkForceUpdate
{
    if (_needForceUpdate) {
        [___sharedInstance showForceUpdateAlert];
    }
}

- (void)showForceUpdateAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"版本更新" message:self.mesage delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil];
    alertView.delegate = ___sharedInstance;
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSString *urlString = kDefaultOpenURL;
        if (self.jumpUrl) {
            urlString = self.jumpUrl;
        }
        NSURL *url = [NSURL URLWithString:urlString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

@end
