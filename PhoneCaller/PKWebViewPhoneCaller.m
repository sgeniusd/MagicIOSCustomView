//
//  PKWebViewPhoneCaller.m
//  PrivateKitchen
//
//  Created by hw on 14-10-27.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import "PKWebViewPhoneCaller.h"

PKWebViewPhoneCaller *__sharedInstance = nil;

@implementation PKWebViewPhoneCaller

+ (PKWebViewPhoneCaller *)sharedInstance
{
    if (__sharedInstance == nil) {
        __sharedInstance = [[PKWebViewPhoneCaller alloc]init];
    }
    return __sharedInstance;
}

/**
 *  拨打电话
 */
- (void)callPhone:(NSString *)phoneNumber
{
    NSString *phoneURL = [[NSString alloc]initWithFormat:@"tel://%@", phoneNumber];
    [__sharedInstance loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneURL]]];
}

@end
