//
//  SHHY_OtherController.h
//  Community
//
//  Created by SYZ on 13-11-30.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "SHHYController.h"
#import "YellowPageInfo.h"
#import "HttpClientManager.h"
#import "MapController.h"
#import "LoadMoreCell.h"

@interface SHHY_OtherCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *nameLabel;
    UILabel *locationLabel;
    UIImageView *positionView;
    UIImageView *locationView;
}

- (void)loadYellowPage:(YellowPageInfo *)info;

@end

@interface SHHY_OtherController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSMutableArray *infoArray;
    BOOL loadMore;
    
    UIImage *iconImage;
}

@property (nonatomic) SHHYItem sshyItem;

@end
