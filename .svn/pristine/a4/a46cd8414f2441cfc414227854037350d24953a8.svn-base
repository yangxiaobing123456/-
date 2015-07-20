//
//  XQTZ_DetailController.h
//  Community
//
//  Created by SYZ on 13-12-21.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "ImageDownloader.h"
#import "PathUtil.h"
#import "EllipseImage.h"
#import "NoticeInfo.h"

@interface XQTZ_DetailView : UIView
{
    UIScrollView *scrollView;
    UIView *contentView;
    UILabel *noticeTitleLabel;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
}

- (void)setData:(NoticeInfo *)notice;

@end

@interface XQTZ_DetailController : CommunityViewController
{
    XQTZ_DetailView *detailView;
}

@property (nonatomic, strong) NoticeInfo *notice;

@end
