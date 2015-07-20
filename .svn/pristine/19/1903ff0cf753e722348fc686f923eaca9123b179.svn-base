//
//  GetPasswordView.m
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "GetPasswordView.h"
#import "GetBackPasswordController.h"

@implementation GetPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float enterLabelX = 38.0f;
        UILabel *enterPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 25.0f, 200.0f, 20.0f)];
        enterPhoneLabel.textColor = [UIColor grayColor];
        enterPhoneLabel.backgroundColor = [UIColor clearColor];
        enterPhoneLabel.font = [UIFont systemFontOfSize:16.0f];
        enterPhoneLabel.text = @"输入注册的手机号";
        [self addSubview:enterPhoneLabel];
        
        float phoneFieldBgY = 50.0f, fieldBgW = 257.0f, fieldBgH = 44.0f;
        UIImageView *phoneFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, phoneFieldBgY, fieldBgW, fieldBgH)];
        phoneFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:phoneFieldBg];
        
        float phoneFieldY = 56.0f, fieldW = 240.0f, fieldH = 30.0f;
        phoneField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, phoneFieldY, fieldW, fieldH)];
        phoneField.backgroundColor = [UIColor clearColor];
        phoneField.font = [UIFont systemFontOfSize:20.0f];
        phoneField.delegate = self;
        phoneField.textColor = [UIColor grayColor];
        phoneField.keyboardType = UIKeyboardTypeNumberPad;
        phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneField.returnKeyType = UIReturnKeyNext;
        phoneField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:phoneField];
        
        float getVerifyCodeButtonW = 100.0f, buttonH = 32.0f;
        getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getVerifyCodeButton.frame = CGRectMake((kContentWidth - getVerifyCodeButtonW) / 2, 109.0f, getVerifyCodeButtonW, buttonH);
        [getVerifyCodeButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [getVerifyCodeButton setTitle:@"发送验证码"
                             forState:UIControlStateNormal];
        [getVerifyCodeButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                                  forState:UIControlStateNormal];
        [getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                                       forState:UIControlStateNormal];
        [getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                                       forState:UIControlStateHighlighted];
        [getVerifyCodeButton addTarget:self
                                action:@selector(getVerifyCode)
                      forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:getVerifyCodeButton];
        
        UILabel *enterVerifyCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 156.0f, 200.0f, 20.0f)];
        enterVerifyCodeLabel.textColor = [UIColor grayColor];
        enterVerifyCodeLabel.backgroundColor = [UIColor clearColor];
        enterVerifyCodeLabel.font = [UIFont systemFontOfSize:16.0f];
        enterVerifyCodeLabel.text = @"输入验证码";
        [self addSubview:enterVerifyCodeLabel];
        
        float verifyCodeFieldBgY = 181.0f;
        UIImageView *verifyCodeFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, verifyCodeFieldBgY, fieldBgW, fieldBgH)];
        verifyCodeFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:verifyCodeFieldBg];
        
        float verifyCodeFieldY = 187.0f;
        verifyCodeField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, verifyCodeFieldY, fieldW, fieldH)];
        verifyCodeField.backgroundColor = [UIColor clearColor];
        verifyCodeField.font = [UIFont systemFontOfSize:20.0f];
        verifyCodeField.delegate = self;
        verifyCodeField.textColor = [UIColor grayColor];
        verifyCodeField.keyboardType = UIKeyboardTypeNumberPad;
        verifyCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        verifyCodeField.returnKeyType = UIReturnKeyGo;
        verifyCodeField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:verifyCodeField];
        
        UILabel *enterPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 240.0f, 200.0f, 20.0f)];
        enterPwdLabel.textColor = [UIColor grayColor];
        enterPwdLabel.backgroundColor = [UIColor clearColor];
        enterPwdLabel.font = [UIFont systemFontOfSize:16.0f];
        enterPwdLabel.text = @"输入密码";
        [self addSubview:enterPwdLabel];
        
        float passwordFieldBgY = 265.0f;
        UIImageView *passwordFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, passwordFieldBgY, fieldBgW, fieldBgH)];
        passwordFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:passwordFieldBg];
        
        float passwordFieldY = 271.0f;
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, passwordFieldY, fieldW, fieldH)];
        passwordField.backgroundColor = [UIColor clearColor];
        passwordField.font = [UIFont systemFontOfSize:20.0f];
        passwordField.delegate = self;
        passwordField.secureTextEntry = YES;
        passwordField.placeholder=@"密码长度6-16字符";
        passwordField.textColor = [UIColor grayColor];
        passwordField.keyboardType = UIKeyboardTypeDefault;
        passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwordField.returnKeyType = UIReturnKeyNext;
        passwordField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:passwordField];
        
        UILabel *enterRePwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 324.0f, 200.0f, 20.0f)];
        enterRePwdLabel.textColor = [UIColor grayColor];
        enterRePwdLabel.backgroundColor = [UIColor clearColor];
        enterRePwdLabel.font = [UIFont systemFontOfSize:16.0f];
        enterRePwdLabel.text = @"确认密码";
        [self addSubview:enterRePwdLabel];
        
        float repeatPwdBgY = 349.0f;
        UIImageView *repeatPwdFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, repeatPwdBgY, fieldBgW, fieldBgH)];
        repeatPwdFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:repeatPwdFieldBg];
        
        repeatPwdField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, 355.0f, fieldW, fieldH)];
        repeatPwdField.backgroundColor = [UIColor clearColor];
        repeatPwdField.font = [UIFont systemFontOfSize:20.0f];
        repeatPwdField.delegate = self;
        repeatPwdField.secureTextEntry = YES;
        repeatPwdField.placeholder=@"再次输入密码";
        repeatPwdField.textColor = [UIColor grayColor];
        repeatPwdField.keyboardType = UIKeyboardTypeDefault;
        repeatPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        repeatPwdField.returnKeyType = UIReturnKeyGo;
        repeatPwdField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:repeatPwdField];
        
        float buttonW = 74.0f;
        confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.frame = CGRectMake((kContentWidth - buttonW) / 2, 408.0f, buttonW, buttonH);
        [confirmButton setTitle:@"开始使用"
                       forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                            forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                                 forState:UIControlStateNormal];
        [confirmButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_148W"]
                                 forState:UIControlStateHighlighted];
        [confirmButton addTarget:self
                          action:@selector(confirm)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resultGetVerifyCode:)
                                                     name:kResultGetVerifyCode
                                                   object:nil];
    }
    return self;
}

+ (CGRect)getPasswordViewFrame
{
    return CGRectMake(0.0f, 0.0f, kContentWidth, 455.0f);
}

- (void)hiddenKeyboard
{
    [phoneField resignFirstResponder];
    [verifyCodeField resignFirstResponder];
    [passwordField resignFirstResponder];
    [repeatPwdField resignFirstResponder];
}

//获取验证码
- (void)getVerifyCode
{
    if (time > 0) {//120秒内不能再次点击按钮
        return;
    }
    
    NSString *phone = phoneField.text;
    if (phone == nil || [phone isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入手机号"];
        return;
    } else if (![phone isChinaPhoneNumber]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入正确的手机号"];
        return;
    }
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[GetBackPasswordController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    if ([object isKindOfClass:[GetBackPasswordController class]]) {
        [((GetBackPasswordController*)object) forgetPasswordWithPhoneNumber:phone];
    }
}

- (void)confirm
{
    [self hiddenKeyboard];
    
    NSString *phone = phoneField.text;
    if (phone == nil || [phone isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入手机号"];
        return;
    } else if (![phone isChinaPhoneNumber]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入正确的手机号"];
        return;
    }
    
    NSString *code = verifyCodeField.text;
    if (code == nil || [code isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入验证码"];
        return;
    }
    
    NSString *pwd = passwordField.text;
    if (pwd == nil || [pwd isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入密码"];
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
    
    NSDictionary *getBackDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [pwd stringFromSHA256], @"password",
                                 phone, @"telephone",
                                 code, @"verifyCode", nil];
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[GetBackPasswordController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    if ([object isKindOfClass:[GetBackPasswordController class]]) {
        [((GetBackPasswordController*)object) changeForgetPasswordWithDict:getBackDict];
    }
}

- (void)startTimer
{
    if(timer == nil){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        time = kGetVerifyCodeTime;
    }
}

- (void)stopTimer
{
    if(timer != nil)
        [timer invalidate];
    timer = nil;
    time = 0;
    
    [getVerifyCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
}

- (void)timerFired:(NSTimer *)_timer
{
    if (time >= 0) {
        [getVerifyCodeButton setTitle:[NSString stringWithFormat:@"再次发送(%d)", time] forState:UIControlStateNormal];
        time --;
    } else {
        [self stopTimer];
    }
}

#pragma mark NSNotificationCenter methods
- (void)resultGetVerifyCode:(NSNotification*)notification
{
    NSString *result = [notification object];
    if ([result isEqualToString:@"SUCCESS"]) {
        [self startTimer];
    } else if ([result isEqualToString:@"FAIL"]) {
        [self stopTimer];
    }
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == phoneField) {
        
    } else if (textField == verifyCodeField) {
        
    } else if (textField == passwordField) {
        
    } else if (textField == repeatPwdField) {
        
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneField){
        if (range.location >= 11) {
            return NO;
        }
    } else if (textField == verifyCodeField){
        if (range.location >= VerifyCodeDigit) {
            return NO;
        }
    } else {
        if (range.location >= PasswordMaxDigit) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == passwordField) {
        [repeatPwdField becomeFirstResponder];
    } else if (textField == repeatPwdField) {
        [self confirm];
    }
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kResultGetVerifyCode
                                                  object:nil];
}

@end
