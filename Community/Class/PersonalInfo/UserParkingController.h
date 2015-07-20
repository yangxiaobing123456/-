//
//  UserParkingController.h
//  Community
//
//  Created by SYZ on 14-2-15.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "EllipseImage.h"
#import "SelectOptionController.h"
#import "WYJF_ParkController.h"

@interface UserParkingCell : UITableViewCell <UIAlertViewDelegate>
{
    UILabel *parkNameLabel;
    UIButton *feeButton;
}

@property (nonatomic, strong) ParkingInfo *parkingInfo;

@end

@interface UserParkingController : CommunityViewController <UITableViewDataSource, UITableViewDelegate, SelectOptionControllerDelegate>
{
    UIImageView *userBackgroundView;
    UIImageView *avatarView;
    UIButton *addParkingButton;
    CommunityTableView *tableView;
}

@property (nonatomic, strong) NSArray *parkingsArray;

- (void)deleteParking:(ParkingInfo *)parking;

@end
