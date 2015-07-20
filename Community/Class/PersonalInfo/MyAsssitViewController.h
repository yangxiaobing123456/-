//
//  MyAsssitViewController.h
//  Community
//
//  Created by HuaMen on 14-12-1.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface MyAsssitViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSMutableArray *_dataArr;
    UISegmentedControl *segmentControl;
    NSMutableArray *taskArray;        
}


@end
