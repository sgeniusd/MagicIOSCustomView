//
//  PKCheckInManager.h
//  PrivateKitchen
//
//  Created by hw on 14-9-16.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKNetworkingTool.h"

#define kRequest_CheckIn                @"public/checkInfo"  //Check In请求

/**
 *  历史原因，厨房端和用户端的type字符串是反的
 */
#define kAppType_User                   @"kitchen"      //用户端
#define kAppType_Kitchen                @"user"         //厨房端

@interface PKCheckInManager : NSObject

@property (nonatomic, assign) BOOL  needForceUpdate;        //强制更新
@property (nonatomic, assign) BOOL  needUpdate;             //更新（可以跳过）
@property (nonatomic, copy) NSString    *jumpUrl;               //强制更新消息跳转url
@property (nonatomic, copy) NSString    *mesage;            //强制更新消息
@property (nonatomic, copy) NSString    *appType;            //强制更新端类型
+ (PKCheckInManager *)sharedInstance;

- (void)destory;

/**
 *  执行Check In请求
 */
- (void)checkIn;

/**
 *  检测强制升级
 */
- (void)checkForceUpdate;

@end
