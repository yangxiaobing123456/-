//
//  XQTZ_DetailController.m
//  Community
//
//  Created by SYZ on 13-12-21.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "XQTZ_DetailController.h"
#import "XQTZController.h"
#import "ImageUtil.h"

#define ViewWidth            304
#define LeftMargin           8
#define TopMargin            10

@implementation XQTZ_DetailView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.pagingEnabled = NO;
        scrollView.contentInset = UIEdgeInsetsMake(44.0f + TopMargin, 0.0f, 0.0f, 0.0f);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = YES;
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, TopMargin, ViewWidth, 0.0f)];
        contentView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:contentView];
        
        float titleBgHeight = 50.0f;
        UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, titleBgHeight)];
        titleBgView.image = [UIImage imageNamed:@"bg_green_100H"];
        [scrollView addSubview:titleBgView];
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 11.0f, 28.0f, 28.0f)];
        iconView.image = [UIImage imageNamed:@"xqtz"];
        [titleBgView addSubview:iconView];
        
        noticeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 0.0f, 183.0f, titleBgHeight)];
        noticeTitleLabel.textColor = [UIColor whiteColor];
        noticeTitleLabel.backgroundColor = [UIColor clearColor];
        noticeTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        noticeTitleLabel.textAlignment = NSTextAlignmentCenter;
        noticeTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        noticeTitleLabel.numberOfLines = 0;
        [titleBgView addSubview:noticeTitleLabel];
        
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 44.0f + TopMargin + 18.0f, 54.0f, 54.0f)];
        logoView.image = [EllipseImage ellipseImage:[UIImage imageNamed:@"logo_132"]
                                          withInset:0.0f
                                    withBorderWidth:0.0f
                                    withBorderColor:[UIColor clearColor]];
        [scrollView addSubview:logoView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(84.0f, 44.0f + TopMargin + 20.0f, 204.0f, 30.0f)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:20.0f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:titleLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(84.0f, 44.0f + TopMargin + 50.0f, 204.0f, 20.0f)];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:12.0f];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [scrollView addSubview:timeLabel];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(27.0f, 44.0f + TopMargin + 90.0f, 250.0f, 100.0f)];
        imageView.image = [ImageUtil imageCenterWithImage:[UIImage imageNamed:@"default_loading"]
                                               targetSize:CGSizeMake(250.0f, 100.0f)
                                          backgroundColor:[UIColor colorWithHexValue:0xFFDBDCDC]];
        imageView.hidden = YES;
        [scrollView addSubview:imageView];
        
        contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:17.0f];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextColor:[UIColor blackColor]];
        [scrollView addSubview:contentLabel];
    }
    return self;
}

- (void)setData:(NoticeInfo *)notice
{
    CGSize contentLabelSize = [notice.content sizeWithFont:[UIFont systemFontOfSize:17.0f]
                                         constrainedToSize:CGSizeMake(280.0f, MAXFLOAT)];
    if ([notice.picture isEqualToString:kCommunityImageServer]) {
        imageView.hidden = YES;
        contentLabel.frame = CGRectMake(12.0f, 44.0f + TopMargin + 90.0f, 280.0f, contentLabelSize.height);
    } else {
        imageView.hidden = NO;
        contentLabel.frame = CGRectMake(12.0f, 44.0f + TopMargin + 200.0f, 280.0f, contentLabelSize.height);
        NSString *imgPath = [PathUtil pathOfImage:[NSString stringWithFormat:@"%lu", (unsigned long)[notice.picture hash]]];
        NSFileManager* fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:imgPath]) { // 图片文件不存在
            ImageDownloadingTask *task = [ImageDownloadingTask new];
            [task setImageUrl:notice.picture];
            [task setUserData:notice];
            [task setTargetFilePath:imgPath];
            [task setCompletionHandler:^(BOOL succeeded, ImageDownloadingTask *idt) {
                if(succeeded && idt != nil && [idt.userData isEqual:notice]){
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
    noticeTitleLabel.text = notice.title;
    titleLabel.text = @"益社区";
    contentLabel.text = notice.content;
    timeLabel.text = [NSString formatDateWithMillisecond:notice.updateTime];
    
    float height = contentLabel.frame.origin.y + contentLabelSize.height;
    if (height < kNavContentHeight - TopMargin * 2) {
        height = kNavContentHeight - TopMargin * 2;
    }
    contentView.frame = CGRectMake(0.0f, TopMargin, ViewWidth, height);
    scrollView.contentSize = CGSizeMake(ViewWidth, height + TopMargin);
}

@end

@implementation XQTZ_DetailController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTitle];
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, ViewWidth, TopMargin)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    detailView = [[XQTZ_DetailView alloc] initWithFrame:CGRectMake(LeftMargin, -kNavigationBarPortraitHeight, ViewWidth, kContentHeight)];
    [self.view addSubview:detailView];
    [detailView setData:_notice];
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTitle
{
    switch (_notice.noticeType) {
        case JJTZ:
            self.title = @"紧急通知";
            break;
            
        case TZ:
            self.title = @"通  知";
            break;
            
        case WXTS:
            self.title = @"温馨提示";
            break;
            
        case GG:
            self.title = @"公  告";
            break;
            
        case ZX:
            self.title = @"资  讯";
            break;
            
        default:
            break;
    }
}

@end