//
//  PKSecurityCodeButton.m
//  PrivateKitchen
//
//  Created by hw on 14-9-26.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import "PKSecurityCodeButton.h"
#import "PKProgressHUD.h"
#import "PKNetworkingTool.h"
#import "PKCheckManager.h"
#import "PKDataCenter.h"

@interface PKSecurityCodeButton () {
    NSTimer     *_countdownTimer;   //倒计时Timer
    
    int     _timeCounter;
}

@end

@implementation PKSecurityCodeButton

- (void)dealloc
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _timeCounter = kCheckCodeInterval;
    }
    return self;
}

- (void)startDisabledTheButton
{
    if (_countdownTimer) {
        [_countdownTimer invalidate];
        _countdownTimer = nil;
    }
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeAuthTitle) userInfo:nil repeats:YES];
    
    [self setTitle:[NSString stringWithFormat:@"剩余%d秒",_timeCounter] forState:UIControlStateNormal];
    self.selected = YES;
    _timeCounter--;
    self.userInteractionEnabled = NO;
}

/**
 *  每秒更新倒计时UI
 */
- (void)changeAuthTitle
{
    if (_timeCounter != 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"剩余%d秒", _timeCounter];
        _timeCounter--;
        return;
    }
    
    self.selected = NO;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
    [_countdownTimer invalidate];
    _countdownTimer = nil;
    _timeCounter = kCheckCodeInterval;
}

@end
