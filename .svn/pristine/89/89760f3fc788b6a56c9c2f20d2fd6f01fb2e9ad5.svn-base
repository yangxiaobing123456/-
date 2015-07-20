//
//  LoginView.m
//  Community
//
//  Created by SYZ on 13-11-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float offset = 0.0f;
        if (!iPhone5) {
            offset = 30.0f;
        }
        
        float logoSize = 66.0f, logoY = 50.0f - offset;
//        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - logoSize) / 2, logoY, logoSize, logoSize)];
//        logoView.image = [UIImage imageNamed:@"logo_132"];
//        [self addSubview:logoView];
//        
//        UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 130.0f - offset, kContentWidth, 25.0f)];
//        welcomeLabel.textColor = [UIColor colorWithHexValue:0xFFE6E6E6];
//        welcomeLabel.backgroundColor = [UIColor clearColor];
//        welcomeLabel.font = [UIFont boldSystemFontOfSize:18.0f];
//        welcomeLabel.text = @"欢迎回到益社区";
//        welcomeLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:welcomeLabel];
        
        //磨砂view
//        UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, EnterPartViewY - offset, kContentWidth, kContentHeight - EnterPartViewY)];
//        blurView.backgroundColor = BlurColor;
//        [self addSubview:blurView];
        
        float enterLabelX = 38.0f;
//        UILabel *enterPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 192.0f - offset, kContentWidth - enterLabelX, 23.0f)];
//        enterPhoneLabel.textColor = [UIColor whiteColor];
//        enterPhoneLabel.backgroundColor = [UIColor clearColor];
//        enterPhoneLabel.font = [UIFont systemFontOfSize:16.0f];
//        enterPhoneLabel.text = @"手机号";
//        [self addSubview:enterPhoneLabel];
        float  h=200.0f;
        float phoneFieldBgY = 220.0f - offset, fieldBgW = 320.0f, fieldBgH = 44.0f;
        UIImageView *phoneFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, phoneFieldBgY-h, fieldBgW, fieldBgH)];
//        phoneFieldBg.image = [UIImage imageNamed:@"enter_box"];
        phoneFieldBg.backgroundColor=[UIColor whiteColor];
        [self addSubview:phoneFieldBg];
        
        float phoneFieldY = 226.0f - offset, fieldW = 320.0f, fieldH = 30.0f;
        phoneField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2+30, phoneFieldY-h, fieldW, fieldH)];
        phoneField.backgroundColor = [UIColor clearColor];
        phoneField.font = [UIFont systemFontOfSize:20.0f];
        phoneField.delegate = self;
        phoneField.placeholder=@"请输入账号";
        phoneField.textColor = [UIColor blackColor];
        phoneField.keyboardType = UIKeyboardTypeNumberPad;
        phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneField.returnKeyType = UIReturnKeyGo;
        phoneField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:phoneField];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, phoneFieldY-h, 30, 30)];
        image.image=[UIImage imageNamed:@"user_account_pic"];
        [self addSubview:image];
        
        
        
        
//        UILabel *enterPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 270.0f - offset, kContentWidth - enterLabelX, 23.0f)];
//        enterPwdLabel.textColor = [UIColor whiteColor];
//        enterPwdLabel.backgroundColor = [UIColor clearColor];
//        enterPwdLabel.font = [UIFont systemFontOfSize:16.0f];
//        enterPwdLabel.text = @"密码";
//        [self addSubview:enterPwdLabel];
        
        float passwordFieldBgY = 268.0f - offset;
        UIImageView *passwordFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, passwordFieldBgY-h, fieldBgW, fieldBgH)];
//        passwordFieldBg.image = [UIImage imageNamed:@"enter_box"];
        passwordFieldBg.backgroundColor=[UIColor whiteColor];
        [self addSubview:passwordFieldBg];
        
        float passwordFieldY = 298.0f-23 - offset;
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2+30, passwordFieldY-h, fieldW, fieldH)];
        passwordField.backgroundColor = [UIColor clearColor];
        passwordField.font = [UIFont systemFontOfSize:20.0f];
        passwordField.delegate = self;
        passwordField.textColor = [UIColor blackColor];
        passwordField.secureTextEntry = YES;
        passwordField.placeholder=@"请输入密码";
        passwordField.keyboardType = UIKeyboardTypeDefault;
        passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwordField.returnKeyType = UIReturnKeyGo;
        passwordField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:passwordField];
        
        UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, passwordField.frame.origin.y, 30, 30)];
        image1.image=[UIImage imageNamed:@"user_password_pic"];
        [self addSubview:image1];
        
        UIButton *getPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getPwdButton.frame = CGRectMake(205.0f, 345.0f - offset-h, 120.0f, 20.0f);
        [getPwdButton setTitle:@"快速注册"
                      forState:UIControlStateNormal];
        [getPwdButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [getPwdButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                           forState:UIControlStateNormal];
        [getPwdButton addTarget:self
                         action:@selector(didRegister)
               forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:getPwdButton];
        
        float registerButtonX = 20.0f, confrimButtonx = 160-37, buttonY = 340.0f - offset, buttonW = 74.0f, buttonH = 32.0f;
        UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        registerButton.frame = CGRectMake(registerButtonX, buttonY-h, buttonW, buttonH);
        [registerButton setTitle:@"忘记密码?"
                        forState:UIControlStateNormal];
        [registerButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [registerButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                             forState:UIControlStateNormal];
//        [registerButton setBackgroundImage:[UIImage imageNamed:@"button_normal_148W"]
//                                  forState:UIControlStateNormal];
//        [registerButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_148W"]
//                                  forState:UIControlStateHighlighted];
        [registerButton addTarget:self
                           action:@selector(didGetPassword)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:registerButton];
        
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.frame = CGRectMake(confrimButtonx, buttonY-h, buttonW, buttonH);
        [confirmButton setTitle:@"登录"
                       forState:UIControlStateNormal];
        [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [confirmButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                            forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                                 forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"butt0n_highlighted_148W"]
                                 forState:UIControlStateHighlighted];
        [confirmButton addTarget:self
                          action:@selector(didConfirm)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmButton];
        
    }
    return self;
}

- (void)hiddenKeyboard
{
    [phoneField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (void)didGetPassword
{
    [self hiddenKeyboard];
    
    [_delegate didGetBackPassword];
}

- (void)didRegister
{
    [self hiddenKeyboard];
    
    [_delegate didUserRegister];
}

- (void)didConfirm
{
    NSString *phone = phoneField.text;
    if (phone == nil || [phone isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入手机号"];
        return;
    } else if (![phone isChinaPhoneNumber]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入正确的手机号"];
        return;
    }
    
    NSString *pwd = passwordField.text;
    if (pwd == nil || [pwd isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入密码"];
        return;
    }
    
    [self hiddenKeyboard];
    
    [_delegate didLoginWithPhoneNumber:phone password:pwd];
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneField) {
        if (range.location >= 11) {
            return NO;
        }
    } else if (textField == passwordField) {
        if (range.location >= PasswordMaxDigit) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == passwordField) {
        [self didConfirm];
    }
    return YES;
}

@end
