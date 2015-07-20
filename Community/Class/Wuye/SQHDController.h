//
//  SQHDController.h
//  Community
//
//  Created by SYZ on 14-1-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "ImageDownloader.h"
#import "PathUtil.h"
#import "LoadMoreCell.h"
#import "SQHD_DetailController.h"

@interface SQHDCell : UITableViewCell
{
    UIImageView *imageView;
    UILabel *activityTitleLabel;
}

- (void)loadActivity:(ActivityInfo *)activity;

@end

@interface SQHDController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    BOOL loadMore;
    NSMutableArray *activityArray;
}

@end
