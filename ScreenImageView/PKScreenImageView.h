//
//  PKScreenImageView.h
//  PrivateKitchen
//
//  Created by hw on 14-10-27.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKScreenImageView : NSObject

+ (void)showImage:(UIImageView *)avatarImageView;

+ (void)hideImage:(UITapGestureRecognizer*)tap;

@end
