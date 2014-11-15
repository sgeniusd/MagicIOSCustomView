//
//  PKImagePickChange.h
//  test
//
//  Created by DylanDu on 14-10-13.
//  Copyright (c) 2014年 com.goBackForEat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKImagePickChange : NSObject
+ (instancetype)share;
- (void)showWithImage:(void(^)(UIImage * image))endImage;
@end
