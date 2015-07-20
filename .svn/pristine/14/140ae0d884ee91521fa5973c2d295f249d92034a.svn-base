//
//  UserCommunityController.m
//  Community
//
//  Created by SYZ on 13-12-12.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "UserCommunityController.h"

@implementation BindCommunityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0f, 0.0f, 286.0f, BindCellHeight)];
        bgView.image = [UIImage imageNamed:@"clear_bg_202H"];
        [self.contentView addSubview:bgView];
        
        float labelW = 180.0f;
        UILabel *currentCommunityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 3.0f, labelW, 20.0f)];
        currentCommunityLabel.textColor = [UIColor blackColor];
        currentCommunityLabel.backgroundColor = [UIColor clearColor];
        currentCommunityLabel.font = [UIFont systemFontOfSize:16.0f];
        currentCommunityLabel.text = @"当前居住小区";
        [self.contentView addSubview:currentCommunityLabel];
        
        UIButton *feeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [feeButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        feeButton.frame = CGRectMake(230.0f, 5.0f, 57.0f, 28.0f);
        [feeButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateNormal];
        [feeButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateHighlighted];
        feeButton.userInteractionEnabled = NO;
        [feeButton setTitle:@"去缴费" forState:UIControlStateNormal];
        [self.contentView addSubview:feeButton];
        
//        communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 30.0f, labelW, 20.0f)];
//        communityLabel.textColor = [UIColor blackColor];
//        communityLabel.backgroundColor = [UIColor clearColor];
//        communityLabel.font = [UIFont systemFontOfSize:15.0f];
//        [self.contentView addSubview:communityLabel];
        
        roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 180, 38.0f)];
//         roomLabel = [[UILabel alloc] initWithFrame:(25.0f, 30.0f, labelW, 20.0f)];
        roomLabel.textColor = [UIColor blackColor];
        roomLabel.lineBreakMode=NSLineBreakByCharWrapping;
        roomLabel.numberOfLines=0;
        roomLabel.backgroundColor = [UIColor clearColor];
        roomLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:roomLabel];
        
//        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 80.0f, labelW, 20.0f)];
//        companyLabel.textColor = [UIColor blackColor];
//        companyLabel.backgroundColor = [UIColor clearColor];
//        companyLabel.font = [UIFont systemFontOfSize:17.0f];
//        companyLabel.text = CommunityCompany;
//        [self.contentView addSubview:companyLabel];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(5, 75, 305, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)loadUserRoom:(UserRoom *)room
{
    communityLabel.text = room.communityName;
    roomLabel.text = room.roomName;
}

@end

@implementation OtherCommunityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0f, 0.0f, 286.0f, OtherCellHeight)];
//        bgView.image = [UIImage imageNamed:@"clear_bg_250H"];
//        [self.contentView addSubview:bgView];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(10.0f, OtherCellHeight - 33.0f-60-29, 26.0f, 26.0f);
        [deleteButton setImage:[UIImage imageNamed:@"delete_button"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteRoom) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleteButton];
        
        float labelW = 180.0f;
//        communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 10.0f, labelW, 40.0f)];
//        communityLabel.textColor = [UIColor blackColor];
//        communityLabel.lineBreakMode=NSLineBreakByCharWrapping;
//        communityLabel.numberOfLines=0;
//        communityLabel.backgroundColor = [UIColor clearColor];
//        communityLabel.font = [UIFont systemFontOfSize:15.0f];
//        [self.contentView addSubview:communityLabel];
        
//        roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 35.0f, labelW, 20.0f)];
         roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, OtherCellHeight - 33.0f-60-37, labelW, 40.0f)];
        roomLabel.lineBreakMode=NSLineBreakByCharWrapping;
        roomLabel.numberOfLines=0;
        roomLabel.textColor = [UIColor blackColor];
        roomLabel.backgroundColor = [UIColor clearColor];
        roomLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:roomLabel];
        
//        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 60.0f, labelW, 20.0f)];
//        companyLabel.textColor = [UIColor blackColor];
//        companyLabel.backgroundColor = [UIColor clearColor];
//        companyLabel.font = [UIFont systemFontOfSize:17.0f];
//        companyLabel.text = CommunityCompany;
//        [self.contentView addSubview:companyLabel];
        
        bindSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(240.0f, OtherCellHeight - 33.0f-60-28, 40.0f, 27.0f)];
        bindSwitch.isRounded = YES;
        bindSwitch.inactiveColor = [UIColor whiteColor];
        bindSwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
        [bindSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:bindSwitch];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(5, OtherCellHeight - 33.0f+20-60, 305, 1)];
        line.backgroundColor=[UIColor grayColor];
        [self.contentView addSubview:line];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)loadUserRoom:(UserRoom *)room
{
    _room = room;
    
    communityLabel.text = _room.communityName;
    roomLabel.text = _room.roomName;
}

- (void)switchChanged:(id)sender
{
    if (bindSwitch.isOn == NO) {
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否切换到该房间？"
                                                        message:@"切换房间会影响到您在使用本应用时得到的数据"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
    alertView.tag = 1;
    [alertView show];
}

- (void)deleteRoom
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否删除该房间？"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
    alertView.tag = 2;
    [alertView show];
}

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [bindSwitch setOn:NO animated:YES];
        } else if (buttonIndex == 1) {
            id object = [self nextResponder];
            while (![object isKindOfClass:[UserCommunityController class]] &&
                   object != nil) {
                object = [object nextResponder];
            }
            if ([object isKindOfClass:[UserCommunityController class]]) {
                [((UserCommunityController*)object) bindRoom:_room];
            }
            [bindSwitch setOn:NO animated:YES];
        }
    } else {
        if (buttonIndex == 1) {
            id object = [self nextResponder];
            while (![object isKindOfClass:[UserCommunityController class]] &&
                   object != nil) {
                object = [object nextResponder];
            }
            if ([object isKindOfClass:[UserCommunityController class]]) {
                [((UserCommunityController*)object) deleteRoom:_room];
            }
        }
    }
}

@end

@implementation UserCommunityController

- (id)init
{
    self = [super init];
    if (self) {
        roomsArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的小区";
	
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    float userBackgroundViewH = 66.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, HeaderViewHeight + TopMargin)];
    userBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, TopMargin, TableViewWidth, userBackgroundViewH)];
//    userBackgroundView.image = [UIImage imageNamed:@"bg2"];
//    [headerView addSubview:userBackgroundView];
    
    float avatarPartH = 70.0f;
    float avatarW = 54.0f, avatarH = 54.0f;
    avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, (avatarPartH - avatarH) / 2 + userBackgroundViewH + TopMargin, avatarW, avatarH)];
//    avatarView.image = [EllipseImage ellipseImage:[AppSetting avatarImage]
//                                        withInset:0.0f
//                                  withBorderWidth:5.0f
//                                  withBorderColor:[UIColor whiteColor]];
    avatarView.image=[AppSetting avatarImage];
    [headerView addSubview:avatarView];
    
    float buttonW = 127.0f, buttonH = 32.0f;
    addRoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addRoomButton.frame = CGRectMake(TableViewWidth - buttonW - 10.0f, (avatarPartH - buttonH) / 2 + userBackgroundViewH + TopMargin, buttonW, buttonH);
    [addRoomButton setTitle:@"增加小区信息"
                   forState:UIControlStateNormal];
    [addRoomButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -15.0f, 0.0f, 0.0f)];
    [addRoomButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [addRoomButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                        forState:UIControlStateNormal];
    [addRoomButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                             forState:UIControlStateNormal];
    [addRoomButton setBackgroundImage:[UIImage imageNamed:@"add_button_254W"]
                             forState:UIControlStateHighlighted];
    [addRoomButton addTarget:self
                      action:@selector(addCommunity)
            forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addRoomButton];
    
    CGRect rect = CGRectMake(LeftMargin, 0.0f, TableViewWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:headerView];
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    bindRoomId = user.roomId;
    
    [self loadUserRooms];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addCommunity
{
    UpdateCommunityController *controller = [UpdateCommunityController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)loadUserRooms
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%d", 0], @"before",
                          @"5", @"count", nil];
    
    [[HttpClientManager sharedInstance] getUserRoomsWithDict:dict
                                                    complete:^(BOOL success, int result, NSArray *array) {
        [HttpResponseNotification getUserRoomsHttpResponse:result];
        if (success && result == RESPONSE_SUCCESS) {
            [roomsArray removeAllObjects];
            for (UserRoom *room in array) {
                if (room.roomId == bindRoomId) {
                    bindRoom = room;
                } else if (room.type != 0) {
                    [roomsArray addObject:room];
                }
            }
            //1个绑定和4个其他,最多5个
            if (roomsArray.count >= 4 && bindRoom) {
                addRoomButton.hidden = YES;
            }
            [tableView reloadData];
        }
    }];
}

- (void)bindRoom:(UserRoom *)room
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] bindRoomWithDict:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%lld", room.roomId] forKey:@"id"]
                                                complete:^(BOOL success, int result) {
                                                    [HttpResponseNotification updateUserInfoHttpResponse:result];
                                                    if (success && result == RESPONSE_SUCCESS) {
                                                        [[CommunityIndicator sharedInstance] startLoading];
                                                        UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
                                                        user.roomId = room.roomId;
                                                        user.roomName = room.roomName;
                                                        user.communityId = room.communityId;
                                                        user.communityName = room.communityName;
                                                        [[CommunityDbManager sharedInstance] insertOrUpdateUserInfo:user];
                                                        [AppSetting saveCommunityId:user.communityId];
                                                        bindRoomId = user.roomId;
                                                        [self changCommnunityNotificate];
                                                        [self loadUserRooms];
                                                    } else {
                                                        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"切换房间失败,请重试"];
                                                    }
                                                }];
}

- (void)deleteRoom:(UserRoom *)room
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] deleteRoomWithDict:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%lld", room.roomId] forKey:@"id"]
                                                  complete:^(BOOL success, int result) {
                                                      [HttpResponseNotification updateUserInfoHttpResponse:result];
                                                      if (success && result == RESPONSE_SUCCESS) {
                                                          [[CommunityIndicator sharedInstance] startLoading];
                                                          [self loadUserRooms];
                                                      } else {
                                                          [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"删除房间失败,请重试"];
                                                      }
                                                  }];
}

- (void)changCommnunityNotificate
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeCommunity object:nil];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (bindRoom) {
        return roomsArray.count + 1;
    }
    return roomsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"bind_cell";
        BindCommunityCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[BindCommunityCell alloc] initWithStyle:UITableViewCellStyleValue1
                                            reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell loadUserRoom:bindRoom];
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"other_cell";
        OtherCommunityCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[OtherCommunityCell alloc] initWithStyle:UITableViewCellStyleValue1
                                           reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        [cell loadUserRoom:[roomsArray objectAtIndex:indexPath.row - 1]];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return BindCellHeight + CellVerticalSpace;
    }if (indexPath.row!=0) {
        return 80;
    }
    return OtherCellHeight + CellVerticalSpace;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        WYJF_WYController *controller = [WYJF_WYController new];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
