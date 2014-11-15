//
//  PKScrollImageView.m
//  PrivateKitchen
//
//  Created by hw on 14-10-13.
//  Copyright (c) 2014年 hw. All rights reserved.
//

#import "PKScrollImageView.h"
#import "UIImageView+WebCache.h"

#define kPageControl_Width      18

@interface PKScrollImageView () <UIScrollViewDelegate>
{
    UIScrollView        *_scrollView;
    UIPageControl       *_pageControl;
}

- (void)initScrollImageData;

@end

@implementation PKScrollImageView

- (void)dealloc
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initScrollImageData];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initScrollImageData];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initScrollImageData
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self resetLayout];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    [self resetLayout];
}

- (void)setBRoundCorner:(BOOL)bRoundCorner
{
    _bRoundCorner = bRoundCorner;

    for (UIImageView *imageView  in _scrollView.subviews) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            if (_bRoundCorner) {
                imageView.layer.masksToBounds = YES;
                imageView.layer.cornerRadius = 5.0f;
            } else {
                imageView.layer.masksToBounds = NO;
                imageView.layer.cornerRadius = 0.0f;
            }
        }
    }
}

- (void)resetLayout
{
    if (_images && [_images count] > 0) {
        [self removeAllSubviews];
        
        [_images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(idx * self.width, 0, self.width, self.height);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            if (_bRoundCorner) {
                imageView.layer.masksToBounds = YES;
                imageView.layer.cornerRadius = 5.0f;
            } else {
                imageView.layer.masksToBounds = NO;
                imageView.layer.cornerRadius = 0.0f;
            }
            
            if ([_images[idx] isKindOfClass:[UIImage class]]) {
                //固有图片
                imageView.image = _images[idx];
            } else if ([_images[idx] isKindOfClass:[NSString class]]
                       && [_images[idx] hasPrefix:@"http://"]) {
                //网络url
                [imageView sd_setImageWithURL:[NSURL URLWithString:_images[idx]] placeholderImage:self.placeholder];
            } else {
                imageView.image = self.placeholder;
            }
            
            imageView.clipsToBounds = YES;
            [_scrollView addSubview:imageView];
        }];
        _scrollView.userInteractionEnabled = !([_images count] == 1);
        _scrollView.contentSize = CGSizeMake([_images count] * self.width, self.height);
        
        if (_pageControl == nil) {
            CGRect pageFrame = CGRectMake(self.width-120, self.height-40, 120, 20);
            
            UIView *pageControlBg = [[UIView alloc]initWithFrame:pageFrame];
            pageControlBg.backgroundColor = [UIColor clearColor];
            pageControlBg.alpha = 0.6f;
            [self addSubview:pageControlBg];
            
            _pageControl = [[UIPageControl alloc]init];
        }
        _pageControl.frame = CGRectMake(self.width-kPageControl_Width * [_images count]-8, self.height-28, kPageControl_Width * [_images count] + 8, 28);
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.numberOfPages = [_images count];
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:_pageControl];
//        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    } else {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, self.width, self.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.image = self.placeholder;
        _scrollView.userInteractionEnabled = NO;
        [_scrollView addSubview:imageView];
        
        _scrollView.contentSize = CGSizeMake(self.width, self.height);
    }
}

- (void)removeAllSubviews
{
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - UIScrollDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        // 得到每页宽度
        CGFloat pageWidth = scrollView.frame.size.width;
        // 根据当前的x坐标和页宽度计算出当前页数
        int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        _pageControl.currentPage = currentPage;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 得到每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = currentPage;
}

@end
