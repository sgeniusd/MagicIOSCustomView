//
//  BTWebToolBar.h
//  AABabyTing3
//
//  Created by Magic Song on 13-10-14.
//
//

#import <UIKit/UIKit.h>

@protocol BTWebToolbarDelegate <NSObject>

- (void)webToolbarGoBack;       //返回
- (void)webToolbarGoForward;    //前进
- (void)webToolbarRefresh;      //刷新
- (void)webToolbarMore;         //更多

@end

@interface BTWebToolBar : UIView

@property (nonatomic,assign) id<BTWebToolbarDelegate> eventDelegate;

- (void)setGoBackEnable:(BOOL)enable;
- (void)setGoForwardEnable:(BOOL)enable;

@end
