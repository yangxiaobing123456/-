//
//  UpdateUserInfoController.h
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "HttpClientManager.h"
#import "EditProfileView.h"
#import "EditCommunityView.h"
#import "EllipseImageControl.h"
#import "CommunityPickerView.h"
#import "SelectOptionController.h"
#import "ImageUtil.h"
#import "CommunityNavigationController.h"
#import "LoginController.h"

@protocol UpdateUserInfoControllerDelegate;

@interface UpdateUserInfoController : CommunityViewController <EditProfileViewDelegate, EditCommunityViewDelegate, CommunityPickerViewDelegate, SelectOptionControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImageView *userBackgroundView;
    UIScrollView *scrollView;
    EllipseImageControl *avatarControl;
    EditProfileView *editProfileView;
    EditCommunityView *editCommunityView;
    CommunityPickerView *pickerView;
    UIDatePicker *datePicker;
    
    EditProfileModel *editProfile;
    EditCommunityModel *editCommunity;
    
    UIImage *avatar;
    HotCity *city;
    Community *community;
    Building *building;
    Unit *unit;
    Room *room;
    int editButtonTag;
    float offset;
    UILabel *CLabel;
    
}
@property (nonatomic) BOOL hideBackButton;
@property (nonatomic, weak) id<UpdateUserInfoControllerDelegate> delegate;

@end

@protocol UpdateUserInfoControllerDelegate <NSObject>

@optional
- (void)popViewController:(UpdateUserInfoController *)controller;

@end
