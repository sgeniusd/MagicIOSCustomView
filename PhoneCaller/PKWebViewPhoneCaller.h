//
//  PKWebViewPhoneCaller.h
//  PrivateKitchen
//
//  Created by hw on 14-10-27.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKWebViewPhoneCaller : UIWebView

+ (PKWebViewPhoneCaller *)sharedInstance;

/**
 *  拨打电话
 */
- (void)callPhone:(NSString *)phoneNumber;

@end
