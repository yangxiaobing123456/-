//
//  SQHD_DetailController.h
//  Community
//
//  Created by SYZ on 14-1-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "EllipseImage.h"
#import "ActivityInfo.h"
#import "PathUtil.h"
#import "ImageDownloader.h"

@interface SQHD_DetailView : UIView
{
    UIScrollView *scrollView;
    UIView *contentView;
    UILabel *activityTitleLabel;
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *contentLabel;
    UIImageView *imageView;
}

- (void)setData:(ActivityInfo *)activity;

@end

@interface SQHD_DetailController : CommunityViewController
{
    SQHD_DetailView *detailView;
}

@property (nonatomic, strong) ActivityInfo *activity;

@end
