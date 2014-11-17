//
//  BTWebToolBar.m
//  AABabyTing3
//
//  Created by Magic Song on 13-10-14.
//
//

#import "PKWebToolBar.h"

@interface BTWebToolBar ()
{
    UIButton *_goBackBtn;
    UIButton *_goForwardBtn;
    UIButton *_refreshBtn;
}

- (void)initWebToolBarUI;

@end

@implementation BTWebToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initWebToolBarUI];
    }
    return self;
}

- (void)dealloc
{

}

- (void)initWebToolBarUI
{
    CGFloat heightSize =0;
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, heightSize, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.backgroundColor = UIColorRGB(0xededed);
    bgImgView.image = [[UIImage imageNamed:@"babyShow_Bottom.png"] stretchableImageWithLeftCapWidth:160 topCapHeight:3.25];
    [self addSubview:bgImgView];
    
    CGFloat btnOffsetY = -3;
    
    _goBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, btnOffsetY+heightSize, 80, CGRectGetHeight(self.frame))];
    _goBackBtn.backgroundColor = [UIColor clearColor];
    [_goBackBtn setImage:[UIImage imageNamed:@"webtoolbar_previous_normal.png"] forState:UIControlStateNormal];
    [_goBackBtn setImage:[UIImage imageNamed:@"webtoolbar_previous_disabled.png"] forState:UIControlStateDisabled];
    [_goBackBtn addTarget:self action:@selector(goBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goBackBtn];
    _goBackBtn.enabled = NO;
    
    _goForwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_goBackBtn.frame), btnOffsetY+heightSize, 80, CGRectGetHeight(self.frame))];
    _goForwardBtn.backgroundColor = [UIColor clearColor];
    [_goForwardBtn setImage:[UIImage imageNamed:@"webtoolbar_next_normal.png"] forState:UIControlStateNormal];
    [_goForwardBtn setImage:[UIImage imageNamed:@"webtoolbar_next_disabled.png"] forState:UIControlStateDisabled];
    [_goForwardBtn addTarget:self action:@selector(goForwardClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_goForwardBtn];
    _goForwardBtn.enabled = NO;
    
    _refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_goForwardBtn.frame)+80, btnOffsetY+heightSize, 80, CGRectGetHeight(self.frame))];
    _refreshBtn.backgroundColor = [UIColor clearColor];
    [_refreshBtn setImage:[UIImage imageNamed:@"webtoolbar_refresh.png"] forState:UIControlStateNormal];
    [_refreshBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_refreshBtn addTarget:self action:@selector(goRefreshClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_refreshBtn];

}

/**
 *  后退
 */
- (void)goBackClicked:(id)sender
{
    if (_eventDelegate && [_eventDelegate respondsToSelector:@selector(webToolbarGoBack)]) {
        [_eventDelegate webToolbarGoBack];
    }
}

/**
 *  前进
 */
- (void)goForwardClicked:(id)sender
{
    if (_eventDelegate && [_eventDelegate respondsToSelector:@selector(webToolbarGoForward)]) {
        [_eventDelegate webToolbarGoForward];
    }
}

/**
 *  刷新
 */
- (void)goRefreshClicked:(id)sender
{
    if (_eventDelegate && [_eventDelegate respondsToSelector:@selector(webToolbarRefresh)]) {
        [_eventDelegate webToolbarRefresh];
    }
}

/**
 *  更多
 */
- (void)goMoreClicked:(id)sender
{
    if (_eventDelegate && [_eventDelegate respondsToSelector:@selector(webToolbarMore)]) {
        [_eventDelegate webToolbarMore];
    }
}

/**
 *  设置后退是否可用
 */
- (void)setGoBackEnable:(BOOL)enable
{
    [_goBackBtn setEnabled:enable];
}

/**
 *  设置前进是否可用
 */
- (void)setGoForwardEnable:(BOOL)enable
{
    [_goForwardBtn setEnabled:enable];
}

@end
