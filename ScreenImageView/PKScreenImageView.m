//
//  PKScreenImageView.m
//  PrivateKitchen
//
//  Created by hw on 14-10-27.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import "PKScreenImageView.h"
#import "PKAppDelegate.h"

CGRect oldFrame;

@implementation PKScreenImageView

+ (void)showImage:(UIImageView *)avatarImageView
{
    UIImage *image=avatarImageView.image;
    
    PKAppDelegate *appDelegate = (PKAppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = appDelegate.window;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.userInteractionEnabled = YES;
    oldFrame=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldFrame];
    imageView.image=image;
    imageView.tag=1122;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.userInteractionEnabled = YES;
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)hideImage:(UITapGestureRecognizer*)tap
{
    [tap removeTarget:self action:@selector(hideImage:)];
    
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldFrame;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
