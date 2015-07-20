//
//  CWBGController.h
//  Community
//
//  Created by SYZ on 13-12-14.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "HttpClientManager.h"
#import "NoticeInfo.h"
#import "LoadMoreCell.h"

@interface CWBGCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *yearLabel;
    UILabel *seasonLabel;
    UILabel *noticeSummaryLabel;
}

- (void)loadFinanceReport:(FinanceReportInfo *)report;

@end

@interface CWBGController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSMutableArray *reportsArray;
    BOOL loadMore;
}

@end
