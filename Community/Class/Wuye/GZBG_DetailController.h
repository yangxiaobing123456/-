//
//  GZBG_DetailController.h
//  Community
//
//  Created by SYZ on 13-12-21.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

//2014-08-16此类不再使用

#import "CommunityViewController.h"
#import "NoticeInfo.h"
#import "EllipseImage.h"
#import "ImageDownloader.h"
#import "PathUtil.h"

@interface GZBG_DetailView : UIView
{
    UIScrollView *scrollView;
    UIView *contentView;
    UILabel *yearLabel;
    UILabel *monthLabel;
    UILabel *reportTitleLabel;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
}

- (void)setData:(WorkReportInfo *)notice;

@end

@interface GZBG_DetailController : CommunityViewController
{
    GZBG_DetailView *detailView;
}

@property (nonatomic, strong) WorkReportInfo *report;

@end
