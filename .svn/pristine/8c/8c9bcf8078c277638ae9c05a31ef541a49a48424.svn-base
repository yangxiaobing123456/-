//
//  PersonalInfoController.h
//  Community
//
//  Created by SYZ on 13-11-26.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "UserInfo.h"
#import "CommunityInfo.h"
#import "ParkingInfo.h"
#import "EllipseImage.h"
#import "LoginController.h"
#import "UpdateProfileController.h"
#import "UserCommunityController.h"
#import "UserParkingController.h"
#import "ChangePasswordController.h"
#import "CommunityNavigationController.h"
#import "UpdateUserInfoController.h"

@interface UserInfoControl : UIControl
{
    UIImageView *avatarView;
    UILabel *nameLabel;
    UILabel *genderLabel;
    UILabel *birthdayLabel;
}

- (void)loadUserInfo:(UserInfo *)info;
- (void)refreshAvatar;

@end

@interface CommunityControl : UIControl
{
    UILabel *communityLabel;
    UILabel *roomLabel;
    UILabel *companyLabel;
}

- (void)loadUserCommunity:(UserInfo *)info;

@end

@interface ParkingControl : UIControl
{
    UILabel *communityLabel;
    UILabel *parkingLabel;
    
}

- (void)loadParking:(NSArray *)array;
- (void)loadDefaultParkingTip:(NSString *)tip;

@end

@interface PersonalInfoController : CommunityViewController <UITabBarControllerDelegate,UpdateUserInfoControllerDelegate>
{
    UIImageView *userBackgroundView;
    UserInfoControl *userInfoControl;
    CommunityControl *communityControl;
    ParkingControl *parkingControl;
    BOOL showMainPage;
    NSMutableArray *parkingsArray;
    UILabel *integralLabel;
    UILabel *walletLabel;
    
}

@end
