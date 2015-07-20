//
//  UserParkingController.m
//  Community
//
//  Created by SYZ on 14-2-15.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "UserParkingController.h"

#define LeftMargin           8
#define TableViewWidth       304
#define HeaderViewHeight     136
#define CellHeight           66

@implementation UserParkingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(9.0f, 0.0f, 286.0f, 78.0f)];
        bgView.image = [UIImage imageNamed:@"clear_bg_156H"];
        [self.contentView addSubview:bgView];
        
        parkNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 13.0f, 200.0f, 40.0f)];
        parkNameLabel.textColor = [UIColor grayColor];
        parkNameLabel.backgroundColor = [UIColor clearColor];
        parkNameLabel.font = [UIFont systemFontOfSize:16.0f];
        parkNameLabel.textAlignment = NSTextAlignmentLeft;
        parkNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        parkNameLabel.numberOfLines = 0;
        [self.contentView addSubview:parkNameLabel];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 69, 320, 1)];
        [line setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:line];
        
//        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        deleteButton.frame = CGRectMake(25.0f, 46.0f, 26.0f, 26.0f);
//        [deleteButton setImage:[UIImage imageNamed:@"delete_button"] forState:UIControlStateNormal];
//        [deleteButton addTarget:self action:@selector(deleteParking) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:deleteButton];
        
        feeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [feeButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        feeButton.frame = CGRectMake(230.0f, 22.0f, 57.0f, 30.0f);
        [feeButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateNormal];
        [feeButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateHighlighted];
        [feeButton setTitle:@"去缴费" forState:UIControlStateNormal];
        feeButton.userInteractionEnabled = NO;
        [self.contentView addSubview:feeButton];
    }
    return self;
}

- (void)setParkingInfo:(ParkingInfo *)info
{
    _parkingInfo = info;
    
    parkNameLabel.text = info.name;
}

//- (void)deleteParking
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否删除该车位？"
//                                                        message:@""
//                                                       delegate:self
//                                              cancelButtonTitle:@"取消"
//                                              otherButtonTitles:@"确定",nil];
//    [alertView show];
//}

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 1) {
//        id object = [self nextResponder];
//        while (![object isKindOfClass:[UserParkingController class]] &&
//               object != nil) {
//            object = [object nextResponder];
//        }
//        if ([object isKindOfClass:[UserParkingController class]]) {
//            [((UserParkingController*)object) deleteParking:_parkingInfo];
//        }
//    }
}

@end

@implementation UserParkingController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"我的停车位";
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    float userBackgroundViewH = 66.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, HeaderViewHeight + TopMargin)];
    userBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, TopMargin, TableViewWidth, userBackgroundViewH)];
    userBackgroundView.image = [UIImage imageNamed:@"bg2"];
    [headerView addSubview:userBackgroundView];
    
    float avatarPartH = 70.0f;
    float avatarW = 54.0f, avatarH = 54.0f;
    avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, (avatarPartH - avatarH) / 2 + userBackgroundViewH + TopMargin, avatarW, avatarH)];
    avatarView.image = [EllipseImage ellipseImage:[AppSetting avatarImage]
                                        withInset:0.0f
                                  withBorderWidth:5.0f
                                  withBorderColor:[UIColor whiteColor]];
    [headerView addSubview:avatarView];
    
//    float buttonW = 127.0f, buttonH = 32.0f;
//    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    addButton.frame = CGRectMake(TableViewWidth - buttonW - 10.0f, (avatarPartH - buttonH) / 2 + userBackgroundViewH + TopMargin, buttonW, buttonH);
//    [addButton setTitle:@"增加停车位"
//               forState:UIControlStateNormal];
//    [addButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -15.0f, 0.0f, 0.0f)];
//    [addButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
//    [addButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
//                    forState:UIControlStateNormal];
//    [addButton setBackgroundImage:[UIImage imageNamed:@"add_button_254W"]
//                         forState:UIControlStateNormal];
//    [addButton setBackgroundImage:[UIImage imageNamed:@"add_button_254W"]
//                         forState:UIControlStateHighlighted];
//    [addButton addTarget:self
//                  action:@selector(addUserParking)
//        forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:addButton];
    
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
    
    if (_parkingsArray == nil) {
        [self getBindParkings];
    }
//    //先加载本地数据再刷新
//    [self getUserParking];
//    [self refreshUserParking];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUserParking
{
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.tag = 1000;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _parkingsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bind_cell";
    UserParkingCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UserParkingCell alloc] initWithStyle:UITableViewCellStyleValue1
                                        reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    ParkingInfo *parking = [_parkingsArray objectAtIndex:indexPath.row];
    [cell setParkingInfo:parking];
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    
    ParkingInfo *parking = [_parkingsArray objectAtIndex:indexPath.row];
    WYJF_ParkController *controller = [WYJF_ParkController new];
    controller.parking = parking;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)deleteParking:(ParkingInfo *)parking
{
//    [[CommunityIndicator sharedInstance] startLoading];
//
//    [[HttpClientManager sharedInstance] deleteUserParkingsWithDict:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%lld", parking.parkingId] forKey:@"id"]
//                                                  complete:^(BOOL success, int result) {
//                                                      if (success && result == RESPONSE_SUCCESS) {
//                                                          [[CommunityIndicator sharedInstance] hideIndicator:YES];
//                                                          //函数名是addedParking,但实际是做取得停车位的事
//                                                          [self addedParking];
//                                                      } else {
//                                                          [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"删除车位失败,请重试"];
//                                                      }
//                                                  }];
}
//
//- (void)getUserParking
//{
//    _parkingsArray = nil;
//    _parkingsArray = [[CommunityDbManager sharedInstance] queryParkings:[AppSetting communityId]];
//    [tableView reloadData];
//}
//
//- (void)userHaveNoParking
//{
//    if (!_parkingsArray || _parkingsArray.count == 0) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
//                                                            message:@"您在本小区没有停车位，是否添加？"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"取消"
//                                                  otherButtonTitles:@"添加", nil];
//        [alertView show];
//    }
//}
//
- (void)getBindParkings
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    UserInfo *info = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", info.roomId], @"id",
                          [NSString stringWithFormat:@"%lld", info.communityId], @"comm",
                          [NSString stringWithFormat:@"%d", 0], @"before",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%d", 100], @"count", nil];
    
    [[HttpClientManager sharedInstance] getBindParkingsWithDict:dict
                                                       complete:^(BOOL success, int result, NSArray *array) {
                                                           if (success == YES && result == RESPONSE_SUCCESS) {
                                                               _parkingsArray = array;
                                                               [tableView reloadData];
                                                               if (_parkingsArray.count == 0) {                                         
                                                                   [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"您还没有绑定停车位"];
                                                               } else {
                                                                   [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                               }
                                                           } else {
                                                               [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                               [self alertRefreshParking];
                                                           }
                                                       }];
}

- (void)alertRefreshParking
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"获取车位列表失败，是否重新获取？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    alertView.tag = 1;
    [alertView show];
}

//
//#pragma mark SelectOptionControllerDelegate methods
//- (void)addedParking
//{
//    [self refreshUserParking];
//}
//

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            [self getBindParkings];
        }
    }
}

@end
