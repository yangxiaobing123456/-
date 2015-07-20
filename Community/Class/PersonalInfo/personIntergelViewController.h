//
//  personIntergelViewController.h
//  Community
//
//  Created by HuaMen on 14-12-1.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface personIntergelViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSMutableArray *_dataArr;
}


@end
