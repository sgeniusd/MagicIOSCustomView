//
//  PKScrollImageView.h
//  PrivateKitchen
//
//  Created by hw on 14-10-13.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PKScrollImageDelegate <NSObject>



@end

@interface PKScrollImageView : UIView

@property (nonatomic, strong) UIImage *placeholder; //占位图
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) BOOL  bRoundCorner;   //图片是否为圆角

@end
