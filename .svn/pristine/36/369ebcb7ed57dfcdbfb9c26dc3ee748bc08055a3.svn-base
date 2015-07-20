//
//  EditProfileView.h
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

enum {
    GenderTag = 1,
    BirthdayTag,
} EditProfileViewTag;

@protocol EditProfileViewDelegate <NSObject>

- (void)changeEditProfileViewValue:(int)tag;

@end

@interface EditProfileModel : NSObject

@property NSString *name;
@property NSString *gender;
@property NSString *birthday;

@end

@interface EditProfileView : UIView <UITextFieldDelegate>
{
    UITextField *_nameField;
    UIButton *genderButton;
    UIButton *birthdayButton;
}
@property (nonatomic,retain)UITextField *nameField;

@property (nonatomic, weak) id<EditProfileViewDelegate> delegate;
@property (nonatomic, strong) EditProfileModel *editProfile;

- (void)hideKeyboard;
- (NSString *)getProfileName;
- (void)reloadProfileData;

@end
