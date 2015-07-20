//
//  TaskFlowController.h
//  Community
//
//  Created by SYZ on 14-4-19.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "TaskImageControl.h"
#import "CheckImageView.h"
#import "TaskFlowInfo.h"
#import "TaskEvaluateController.h"
#import "SevenSwitch.h"


@interface TaskFlowCell : UITableViewCell
{
    UIImageView *bgView;
    UIView *lineView;
    UILabel *statusLabel;
    UILabel *timeLabel;
    UILabel *contentLabel;
    TaskImageControl *imageControl;

    
    NSString *url;
}

- (void)loadFlow:(TaskFlowInfo *)flow;

@end

@interface TaskFlowController : CommunityViewController <UITableViewDelegate, UITableViewDataSource, TaskEvaluateControllerDelegate>
{
    UITableView *tableView;
    NSMutableArray *flowArray;
}

@property (nonatomic, strong) NSString *taskId;
@property (nonatomic,assign)int isComPair;

@end
