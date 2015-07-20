//
//  UpdateProfileController.h
//  Community
//
//  Created by SYZ on 13-11-20.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "HttpClientManager.h"
#import "EditProfileView.h"
#import "EllipseImageControl.h"
#import "CommunityPickerView.h"
#import "ImageUtil.h"

@interface UpdateProfileController : CommunityViewController <EditProfileViewDelegate, CommunityPickerViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    UIImageView *userBackgroundView;
    UIScrollView *scrollView;
    EllipseImageControl *avatarControl;
    EditProfileView *editProfileView;
    CommunityPickerView *pickerView;
    UIDatePicker *datePicker;
    
    EditProfileModel *editProfile;
    UIImage *avatar;
    int editButtonTag;
    float offset;
}
@end