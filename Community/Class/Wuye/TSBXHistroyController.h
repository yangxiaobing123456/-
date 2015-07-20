//
//  TSBXHistroyController.h
//  Community
//
//  Created by SYZ on 14-5-6.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "TaskInfo.h"
#import "TaskFlowController.h"


@interface ComplainOrRepairView : UIView
{
    NSString *text;
    UIColor *backgroundColor;
}

- (void)setData:(BOOL)complain;

@end

@interface TSBXHistroyCell : UITableViewCell
{
    UILabel *contentLabel;
    UILabel *dayCountLabel;
    ComplainOrRepairView *complainOrRepairView;
}

- (void)loadTask:(TaskInfo *)task;

@end

@interface TSBXHistroyController : CommunityViewController <UITableViewDelegate, UITableViewDataSource>
{
    CommunityTableView *tableView;
    NSMutableArray *taskArray;
}

@end
