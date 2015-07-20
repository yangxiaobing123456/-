//
//  UserCommunityController.h
//  Community
//
//  Created by SYZ on 13-12-12.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "UpdateCommunityController.h"
#import "WYJF_WYController.h"
#import "UserInfo.h"
#import "CommunityInfo.h"
#import "EllipseImage.h"
#import "SevenSwitch.h"

#define CellVerticalSpace    8
#define LeftMargin           8
#define TableViewWidth       304
#define HeaderViewHeight     136
#define TopMargin            10
#define BindCellHeight       100
#define OtherCellHeight      125

@interface BindCommunityCell : UITableViewCell
{
    UILabel *communityLabel;
    UILabel *roomLabel;
}

- (void)loadUserRoom:(UserRoom *)room;

@end

@interface OtherCommunityCell : UITableViewCell <UIAlertViewDelegate>
{
    UILabel *communityLabel;
    UILabel *roomLabel;
    SevenSwitch *bindSwitch;
}

@property(nonatomic, strong) UserRoom *room;

- (void)loadUserRoom:(UserRoom *)room;

@end

@interface UserCommunityController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *userBackgroundView;
    UIImageView *avatarView;
    UIButton *addRoomButton;
    CommunityTableView *tableView;
    NSMutableArray *roomsArray;
    UserRoom *bindRoom;
    long long bindRoomId;
}

- (void)bindRoom:(UserRoom *)room;
- (void)deleteRoom:(UserRoom *)room;

@end
