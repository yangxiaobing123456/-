//
//  GetJoinNumViewController.h
//  Community
//
//  Created by HuaMen on 15-2-27.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface GetJoinNumViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *myScrollview;

    UITableView *peopleTable;
    NSArray *dataListArray;
    BOOL moreBool;
}

@property (nonatomic,copy)NSString *activityId;
@property (nonatomic,copy)NSString *displayPhone;

@end
