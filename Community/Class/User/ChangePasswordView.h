//
//  ChangePasswordView.h
//  Community
//
//  Created by SYZ on 14-1-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordView : UIView <UITextFieldDelegate>
{
    UITextField *oldPasswordField;
    UITextField *newPasswordField;
    UITextField *repeatPwdField;
    UIButton *confirmButton;
}

+ (CGRect)changePasswordViewFrame;

@end
