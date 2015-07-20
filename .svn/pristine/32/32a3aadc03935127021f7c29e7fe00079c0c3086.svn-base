//
//  GZBGController.h
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

//  工作报告
#import "CommunityViewController.h"
#import "WebViewController.h"
#import "NoticeInfo.h"
#import "LoadMoreCell.h"

@interface GZBGCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *yearLabel;
    UILabel *monthLabel;
    UILabel *titleLabel;
}

- (void)loadWorkReport:(WorkReportInfo *)info;

@end

@interface GZBGController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSMutableArray *reportArray;
    BOOL loadMore;
}

@end
