//
//  AdsView.h
//  Community
//
//  Created by SYZ on 14-3-6.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

//广告展示控件

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "PathUtil.h"

@protocol pushAdViewDelegate <NSObject>

-(void)pushAdView;

@end

@interface AdControl : UIControl
{
    UIImageView *imageView;
    UILabel *titleLabel;
}
- (id)initWithFrame:(CGRect)frame WithController:(id)controller;
@property (nonatomic, strong) AdInfo *info;
@property(nonatomic,assign)id<pushAdViewDelegate> delegate;
@end
@protocol AdsViewDelegate <NSObject>

-(void)pushtoController;

@end
@interface AdsView : UIView <UIScrollViewDelegate,pushAdViewDelegate>
{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSString *ClickUrlStr;
}
@property(nonatomic,assign)id<AdsViewDelegate>delegate;
- (void)loadAdArray:(NSArray *)array;
- (id)initWithFrame:(CGRect)frame withController:(id)controller;

@end
