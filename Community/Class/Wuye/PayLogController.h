//
//  PayLogController.h
//  Community
//
//  Created by SYZ on 14-1-23.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "LoadMoreCell.h"

@interface PayLogCell : UITableViewCell
{
    UIImageView *bgView;
    UIImageView *iconView;
    UILabel *methodLabel;
    UILabel *dateLabel;
    UILabel *summaryLabel;
    UIButton *resultButton;
}

- (void)loadPayLog:(PayLogInfo *)payLog;

@end

@interface PayLogController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    BOOL loadMore;
    NSMutableArray *payLogArray;
}

@end
