//
//  PKCustomSwitch.h
//  PrivateKitchen
//
//  Created by hw on 14-10-13.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomSwitchStatus)
{
    CustomSwitchStatusOff = 0,//关闭
    CustomSwitchStatusOn = 1//开启
};

typedef NS_ENUM(NSUInteger, CustomSwitchArrange)
{
    CustomSwitchArrangeONLeftOFFRight = 0,//左边是开启,右边是关闭，默认
    CustomSwitchArrangeOFFLeftONRight = 1//左边是关闭，右边是开启
};

@protocol CustomSwitchDelegate <NSObject>

-(void)customSwitchSetStatus:(CustomSwitchStatus)status;

@end

@interface PKCustomSwitch : UIControl
{
    UIImage *_onImage;
    UIImage *_offImage;
    CustomSwitchArrange _arrange;
    
}
@property(nonatomic,retain) UIImage *onImage;
@property(nonatomic,retain) UIImage *offImage;
@property(nonatomic,assign) id<CustomSwitchDelegate> delegate;
@property(nonatomic) CustomSwitchArrange arrange;
@property(nonatomic) CustomSwitchStatus status;
@end