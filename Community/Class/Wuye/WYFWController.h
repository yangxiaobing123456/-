//
//  WYFWController.h
//  Community
//
//  Created by SYZ on 13-11-26.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

//  物业服务

#import "CommunityViewController.h"
#import "UpdateUserInfoController.h"
#import "WYFWview.h"

@interface WYFWCell : UITableViewCell
{
    UIImageView *bgView;
    UIImageView *iconView;
    UILabel *itemLabel;
    UIImageView *arrowView;
}

- (void)loadFunction:(NSDictionary *)dict;

@end

@interface WYFWController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSArray *functionArray;
//    WYFWview *fwView;
}

@end
