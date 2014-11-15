//
//  PKImagePickChange.m
//  test
//
//  Created by DylanDu on 14-10-13.
//  Copyright (c) 2014年 com.goBackForEat. All rights reserved.
//

#import "PKImagePickChange.h"
#import "PKAppDelegate.h"
#import "PKProgressHUD.h"

@interface PKImagePickChange()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(copy,nonatomic)void(^endImage)();
@end
@implementation PKImagePickChange

+ (instancetype)share
{
    static PKImagePickChange *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
    
}
- (void)showWithImage:(void (^)(UIImage * image))endImage
{
    if (endImage) {
        self.endImage = endImage;
    }
    UIActionSheet * alert = [[UIActionSheet alloc]initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"打开相机",@"打开相册", nil];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [alert showInView:window];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    
    [self openImagePickerWithIndex:buttonIndex];
}

/**
 *  打开图片选择
 */
- (void)openImagePickerWithIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
    if (!buttonIndex) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pc.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            [PKProgressHUD showLoadingWithTitle:@"当前不能打开相机" delay:1.5];
            return;
        }
    }
    pc.delegate = self;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window.rootViewController presentViewController:pc animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.endImage) {
        self.endImage(image);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
