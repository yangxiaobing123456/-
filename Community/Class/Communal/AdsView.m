//
//  AdsView.m
//  Community
//
//  Created by SYZ on 14-3-6.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "AdsView.h"
#import "ImageUtil.h"
#import "FirstPageController.h"
#import "CommunityHomeController.h"

@implementation AdControl

- (id)initWithFrame:(CGRect)frame WithController:(id)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = [ImageUtil imageCenterWithImage:[UIImage imageNamed:@"default_loading"]
                                               targetSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)
                                          backgroundColor:[UIColor colorWithHexValue:0xFFDBDCDC]];
        [self addSubview:imageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, self.bounds.size.height - 25.0f, 200.0f, 20.0f)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
    }
    return self;
}
-(void)ViewClick{
    [self.delegate pushAdView];
    NSLog(@"%@",_info.content);
    return;
}
- (void)setInfo:(AdInfo *)info withView:(AdControl *)view
{
    _info = info;
    
    titleLabel.text = info.title;
    [view addTarget:self action:@selector(ViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([info.picture isEqualToString:kCommunityImageServer]) {
        return;
    }
    NSString *imgPath = [PathUtil pathOfImage:[NSString stringWithFormat:@"%d", [_info.picture hash]]];
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imgPath]) { // 图片文件不存在
        ImageDownloadingTask *task = [ImageDownloadingTask new];
        [task setImageUrl:_info.picture];
        [task setUserData:_info];
        [task setTargetFilePath:imgPath];
        [task setCompletionHandler:^(BOOL succeeded, ImageDownloadingTask *idt) {
            if(succeeded && idt != nil && [idt.userData isEqual:_info]){
                UIImage *tempImg = [UIImage imageWithData:[idt resultImageData]];
                [imageView setImage:tempImg];
            }
        }];
        [[ImageDownloader sharedInstance] download:task];
    } else { //图片存在
        NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
        [imageView setImage:[UIImage imageWithData:imgData]];
    }
}

@end

@implementation AdsView

- (id)initWithFrame:(CGRect)frame withController:(id)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.scrollEnabled = YES;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(260.0f, 130.0f, 30.0f, 20.0f)];
        pageControl.currentPage = 0;
        [self addSubview:pageControl];
    }
    return self;
}
-(void)pushAdView{
    
}

- (void)loadAdArray:(NSArray *)array
{
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    int i = 0;
    for (AdInfo *ad in array) {
        AdControl *view = [[AdControl alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * i, 0.0f, scrollView.frame.size.width, scrollView.frame.size.height)WithController:self];
        view.delegate=self;
        [scrollView addSubview:view];
        [view setInfo:ad withView:view];
        i++;
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * array.count, scrollView.frame.size.height);
    pageControl.numberOfPages = array.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)sView
{
    int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
    pageControl.currentPage = currentPage;
}

@end
