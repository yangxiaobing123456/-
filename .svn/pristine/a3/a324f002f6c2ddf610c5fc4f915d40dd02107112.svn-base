//
//  ChangePasswordView.m
//  Community
//
//  Created by SYZ on 14-1-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "ChangePasswordView.h"
#import "ChangePasswordController.h"

@implementation ChangePasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float enterLabelX = 38.0f;
        UILabel *enterOldPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 25.0f, 200.0f, 20.0f)];
        enterOldPwdLabel.textColor = [UIColor grayColor];
        enterOldPwdLabel.backgroundColor = [UIColor clearColor];
        enterOldPwdLabel.font = [UIFont systemFontOfSize:16.0f];
        enterOldPwdLabel.text = @"原密码";
        [self addSubview:enterOldPwdLabel];
        
        float oldPwdFieldBgY = 50.0f, fieldBgW = 257.0f, fieldBgH = 44.0f;
        UIImageView *phoneFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, oldPwdFieldBgY, fieldBgW, fieldBgH)];
        phoneFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:phoneFieldBg];
        
        float oldPwdFieldY = 56.0f, fieldW = 240.0f, fieldH = 30.0f;
        oldPasswordField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, oldPwdFieldY, fieldW, fieldH)];
        oldPasswordField.backgroundColor = [UIColor clearColor];
        oldPasswordField.font = [UIFont systemFontOfSize:20.0f];
        oldPasswordField.delegate = self;
        oldPasswordField.secureTextEntry = YES;
        oldPasswordField.textColor = [UIColor grayColor];
        oldPasswordField.keyboardType = UIKeyboardTypeDefault;
        oldPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        oldPasswordField.returnKeyType = UIReturnKeyNext;
        oldPasswordField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:oldPasswordField];
        
        UILabel *enterNewPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 109.0f, 200.0f, 20.0f)];
        enterNewPwdLabel.textColor = [UIColor grayColor];
        enterNewPwdLabel.backgroundColor = [UIColor clearColor];
        enterNewPwdLabel.font = [UIFont systemFontOfSize:16.0f];
        enterNewPwdLabel.text = @"新密码";
        [self addSubview:enterNewPwdLabel];
        
        float passwordFieldBgY = 134.0f;
        UIImageView *passwordFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, passwordFieldBgY, fieldBgW, fieldBgH)];
        passwordFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:passwordFieldBg];
        
        float passwordFieldY = 140.0f;
        newPasswordField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, passwordFieldY, fieldW, fieldH)];
        newPasswordField.backgroundColor = [UIColor clearColor];
        newPasswordField.font = [UIFont systemFontOfSize:20.0f];
        newPasswordField.delegate = self;
        newPasswordField.secureTextEntry = YES;
        newPasswordField.textColor = [UIColor grayColor];
        newPasswordField.keyboardType = UIKeyboardTypeDefault;
        newPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        newPasswordField.returnKeyType = UIReturnKeyNext;
        newPasswordField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:newPasswordField];
        
        UILabel *enterRePwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 193.0f, 200.0f, 20.0f)];
        enterRePwdLabel.textColor = [UIColor grayColor];
        enterRePwdLabel.backgroundColor = [UIColor clearColor];
        enterRePwdLabel.font = [UIFont systemFontOfSize:16.0f];
        enterRePwdLabel.text = @"确认密码";
        [self addSubview:enterRePwdLabel];
        
        float repeatPwdBgY = 218.0f;
        UIImageView *repeatPwdFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, repeatPwdBgY, fieldBgW, fieldBgH)];
        repeatPwdFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:repeatPwdFieldBg];
        
        float repeatPwdY = 224.0f;
        repeatPwdField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, repeatPwdY, fieldW, fieldH)];
        repeatPwdField.backgroundColor = [UIColor clearColor];
        repeatPwdField.font = [UIFont systemFontOfSize:20.0f];
        repeatPwdField.delegate = self;
        repeatPwdField.secureTextEntry = YES;
        repeatPwdField.textColor = [UIColor grayColor];
        repeatPwdField.keyboardType = UIKeyboardTypeDefault;
        repeatPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        repeatPwdField.returnKeyType = UIReturnKeyGo;
        repeatPwdField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:repeatPwdField];
        
        float buttonW = 74.0f, buttonH = 32.0f;
        confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.frame = CGRectMake((kContentWidth - buttonW) / 2, 282.0f, buttonW, buttonH);
        [confirmButton setTitle:@"确定"
                       forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                            forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"button_normal_148W"]
                                 forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_148W"]
                                 forState:UIControlStateHighlighted];
        [confirmButton addTarget:self
                          action:@selector(confirm)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmButton];
    }
    return self;
}

+ (CGRect)changePasswordViewFrame
{
    return CGRectMake(0.0f, 0.0f, kContentWidth, 350.0f);
}

- (void)hiddenKeyboard
{
    [oldPasswordField resignFirstResponder];
    [newPasswordField resignFirstResponder];
    [repeatPwdField resignFirstResponder];
}

- (void)confirm
{
    [self hiddenKeyboard];
    
    NSString *oldPwd = oldPasswordField.text;
    if (oldPwd == nil || [oldPwd isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入旧密码"];
        return;
    } else if (![[AppSetting userPassword] isEqualToString:[oldPwd stringFromSHA256]]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"旧密码输入错误"];
        return;
    }
    
    NSString *pwd = newPasswordField.text;
    if (pwd == nil || [pwd isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入新密码"];
        return;
    } else if (pwd.length < PasswordMinDigit) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"密码不能小于6位"];
        return;
    }
    
    NSString *rePwd = repeatPwdField.text;
    if (rePwd == nil || [rePwd isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入确认密码"];
        return;
    }
    
    if (![pwd isEqualToString:rePwd]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"两次密码不一致"];
        return;
    }

    id object = [self nextResponder];
    while (![object isKindOfClass:[ChangePasswordController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    if ([object isKindOfClass:[ChangePasswordController class]]) {
        [((ChangePasswordController*)object) changePasswordWithNewpwd:[pwd stringFromSHA256]];
    }
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == oldPasswordField) {
        
    } else if (textField == newPasswordField) {
        
    } else if (textField == repeatPwdField) {
        
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= PasswordMaxDigit) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == oldPasswordField) {
        [newPasswordField becomeFirstResponder];
    } else if (textField == newPasswordField) {
        [repeatPwdField becomeFirstResponder];
    } else if (textField == repeatPwdField) {
        [self confirm];
    }
    return YES;
}

@end
