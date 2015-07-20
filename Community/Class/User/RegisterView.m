//
//  RegisterView.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "RegisterView.h"

@implementation GetVerifyCodeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float welcomeImageViewW = 202.0f, welcomeImageViewH = 66.0f;
        UIImageView *welcomeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - welcomeImageViewW) / 2, 50.0f, welcomeImageViewW, welcomeImageViewH)];
//        welcomeImageView.image = [UIImage imageNamed:@"register_welcome"];
        welcomeImageView.backgroundColor=[UIColor orangeColor];
        welcomeImageView.alpha=0.5f;
//        [self addSubview:welcomeImageView];
        
        float welcomeLabelW = 202.0f, welcomeLabelY = 66.0f;
        UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kContentWidth - welcomeImageViewW) / 2, welcomeLabelY+5, welcomeLabelW, 20.0f)];
        welcomeLabel.textColor = [UIColor whiteColor];
        welcomeLabel.backgroundColor = [UIColor clearColor];
        welcomeLabel.font = [UIFont systemFontOfSize:16.0f];
        welcomeLabel.text = @"欢迎注册成为益社区用户";
        welcomeLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:welcomeLabel];
        
        float enterLabelX = 38.0f;
        UILabel *enterPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 137.0f-70, 200.0f, 23.0f)];
        enterPhoneLabel.textColor = [UIColor blackColor];
        enterPhoneLabel.backgroundColor = [UIColor clearColor];
        enterPhoneLabel.font = [UIFont systemFontOfSize:16.0f];
        enterPhoneLabel.text = @"输入手机号";
        [self addSubview:enterPhoneLabel];
        
        float phoneFieldBgY = 165.0f, fieldBgW = 257.0f, fieldBgH = 44.0f;
        UIImageView *phoneFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, phoneFieldBgY-70, fieldBgW, fieldBgH)];
        phoneFieldBg.image = [UIImage imageNamed:@"enter_box"];
        [self addSubview:phoneFieldBg];
        
        float phoneFieldY = 171.0f, fieldW = 240.0f, fieldH = 30.0f;
        phoneField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, phoneFieldY-70, fieldW, fieldH)];
        phoneField.backgroundColor = [UIColor clearColor];
        phoneField.font = [UIFont systemFontOfSize:20.0f];
        phoneField.delegate = self;
        phoneField.textColor = [UIColor blackColor];
        phoneField.keyboardType = UIKeyboardTypeNumberPad;
        phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneField.returnKeyType = UIReturnKeyNext;
        phoneField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
//        [self addSubview:phoneField];
        
        float getVerifyCodeButtonW = 100.0f, buttonH = 32.0f;
        getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getVerifyCodeButton.frame = CGRectMake((kContentWidth - getVerifyCodeButtonW) / 2, 239.0f-70, getVerifyCodeButtonW, buttonH);
        [getVerifyCodeButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [getVerifyCodeButton setTitle:@"发送验证码"
                             forState:UIControlStateNormal];
        [getVerifyCodeButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                                  forState:UIControlStateNormal];
        [getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"button_normal_148W"]
                                       forState:UIControlStateNormal];
        [getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                                       forState:UIControlStateHighlighted];
        [getVerifyCodeButton addTarget:self
                                action:@selector(getVerifyCode)
                      forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:getVerifyCodeButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resultGetVerifyCode:)
                                                     name:kResultGetVerifyCode
                                                   object:nil];
    }
    return self;
}

- (void)hiddenKeyboard
{
    [phoneField resignFirstResponder];
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
    
    [self hiddenKeyboard];
    
    [_delegate didGetVerifyCodeWithPhoneNumber:phone];
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
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneField){
        if (range.location >= 11) {
            return NO;
        }
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

@implementation ConfirmPasswordView
{
    NSTimer *timer;
    int time;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        float lastSetpImageViewW = 202.0f, lastSetpImageViewH = 66.0f;
        
//        UIImageView *lastSetpImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - lastSetpImageViewW) / 2, 50.0f, lastSetpImageViewW, lastSetpImageViewH)];
//        lastSetpImageView.image = [UIImage imageNamed:@"register_welcome"];
//        [self addSubview:lastSetpImageView];
        
//        float welcomeLabelW = 202.0f, welcomeLabelY = 66.0f;
//        UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kContentWidth - lastSetpImageViewW) / 2, welcomeLabelY, welcomeLabelW, 20.0f)];
//        welcomeLabel.textColor = [UIColor whiteColor];
//        welcomeLabel.backgroundColor = [UIColor clearColor];
//        welcomeLabel.font = [UIFont systemFontOfSize:16.0f];
//        welcomeLabel.text = @"最后一步，完成注册!";
//        welcomeLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:welcomeLabel];
        
//        float enterLabelX = 38.0f;
//        UILabel *enterVerifyCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 139.0f, 200.0f, 20.0f)];
//        enterVerifyCodeLabel.textColor = [UIColor whiteColor];
//        enterVerifyCodeLabel.backgroundColor = [UIColor clearColor];
//        enterVerifyCodeLabel.font = [UIFont systemFontOfSize:16.0f];
//        enterVerifyCodeLabel.text = @"输入验证码";
//        [self addSubview:enterVerifyCodeLabel];
//        
//        float verifyCodeFieldBgY = 165.0f, fieldBgW = 257.0f, fieldBgH = 44.0f;
//        UIImageView *verifyCodeFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, verifyCodeFieldBgY, fieldBgW, fieldBgH)];
//        verifyCodeFieldBg.image = [UIImage imageNamed:@"enter_box"];
//        [self addSubview:verifyCodeFieldBg];
        float w=100.0f , verifyCodeFieldY = 0.0f, fieldW = 320.0f, fieldH = 30.0f;
        phoneField = [[UITextField alloc] initWithFrame:CGRectMake(w, verifyCodeFieldY, fieldW, fieldH)];
        phoneField.backgroundColor = [UIColor whiteColor];
        phoneField.font = [UIFont systemFontOfSize:20.0f];
        phoneField.delegate = self;
        phoneField.textColor = [UIColor grayColor];
        phoneField.placeholder=@"输入手机号";
        phoneField.keyboardType = UIKeyboardTypeNumberPad;
        phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        phoneField.returnKeyType = UIReturnKeyGo;
        phoneField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:phoneField];
        
        getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getVerifyCodeButton.frame = CGRectMake(230, 5, 80, 20);
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


        
//        float verifyCodeFieldY = 0.0f, fieldW = 320.0f, fieldH = 30.0f;
        verifyCodeField = [[UITextField alloc] initWithFrame:CGRectMake(w, 60-30, fieldW, fieldH)];
        verifyCodeField.backgroundColor = [UIColor whiteColor];
        verifyCodeField.font = [UIFont systemFontOfSize:20.0f];
        verifyCodeField.delegate = self;
        verifyCodeField.textColor = [UIColor grayColor];
        verifyCodeField.placeholder=@"输入验证码";
        verifyCodeField.keyboardType = UIKeyboardTypeNumberPad;
        verifyCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        verifyCodeField.returnKeyType = UIReturnKeyGo;
        verifyCodeField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:verifyCodeField];
        
//        UILabel *enterPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 229.0f, 200.0f, 20.0f)];
//        enterPwdLabel.textColor = [UIColor whiteColor];
//        enterPwdLabel.backgroundColor = [UIColor clearColor];
//        enterPwdLabel.font = [UIFont systemFontOfSize:16.0f];
//        enterPwdLabel.text = @"输入密码";
//        [self addSubview:enterPwdLabel];
//        
//        float passwordFieldBgY = 254.0f;
//        UIImageView *passwordFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, passwordFieldBgY, fieldBgW, fieldBgH)];
//        passwordFieldBg.image = [UIImage imageNamed:@"enter_box"];
//        [self addSubview:passwordFieldBg];
        
        float passwordFieldY = 30.0f;
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(w, 90-30, fieldW, fieldH)];
        passwordField.backgroundColor = [UIColor whiteColor];
        passwordField.font = [UIFont systemFontOfSize:20.0f];
        passwordField.delegate = self;
        passwordField.placeholder=@"输入密码";
        passwordField.secureTextEntry = YES;
        passwordField.textColor = [UIColor grayColor];
        passwordField.keyboardType = UIKeyboardTypeDefault;
        passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwordField.returnKeyType = UIReturnKeyNext;
        passwordField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:passwordField];
        
//        UILabel *enterRePwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 319.0f, 200.0f, 20.0f)];
//        enterRePwdLabel.textColor = [UIColor whiteColor];
//        enterRePwdLabel.backgroundColor = [UIColor clearColor];
//        enterRePwdLabel.font = [UIFont systemFontOfSize:16.0f];
//        enterRePwdLabel.text = @"确认密码";
//        [self addSubview:enterRePwdLabel];
        
//        float repeatPwdBgY = 345.0f;
//        UIImageView *repeatPwdFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, repeatPwdBgY, fieldBgW, fieldBgH)];
//        repeatPwdFieldBg.image = [UIImage imageNamed:@"enter_box"];
//        [self addSubview:repeatPwdFieldBg];
        
        repeatPwdField = [[UITextField alloc] initWithFrame:CGRectMake(w, 120-30, fieldW, fieldH)];
        repeatPwdField.backgroundColor = [UIColor whiteColor];
        repeatPwdField.font = [UIFont systemFontOfSize:20.0f];
        repeatPwdField.delegate = self;
        repeatPwdField.secureTextEntry = YES;
        repeatPwdField.textColor = [UIColor grayColor];
        repeatPwdField.placeholder=@"确认密码";
        repeatPwdField.keyboardType = UIKeyboardTypeDefault;
        repeatPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        repeatPwdField.returnKeyType = UIReturnKeyGo;
        repeatPwdField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:repeatPwdField];
        
        yaoqingrenField = [[UITextField alloc] initWithFrame:CGRectMake(w, 150-30, fieldW, fieldH)];
        yaoqingrenField.backgroundColor = [UIColor whiteColor];
        yaoqingrenField.font = [UIFont systemFontOfSize:20.0f];
        yaoqingrenField.delegate = self;
        yaoqingrenField.textColor = [UIColor grayColor];
        yaoqingrenField.placeholder=@"邀请人姓名(选填)";
        yaoqingrenField.secureTextEntry = YES;
        yaoqingrenField.secureTextEntry = NO;

        yaoqingrenField.keyboardType = UIKeyboardTypeDefault;
        yaoqingrenField.clearButtonMode = UITextFieldViewModeWhileEditing;
        yaoqingrenField.returnKeyType = UIReturnKeyGo;
        yaoqingrenField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:yaoqingrenField];
        

        yaoqingrenPhoneField = [[UITextField alloc] initWithFrame:CGRectMake(w, 180-30, fieldW, fieldH)];
        yaoqingrenPhoneField.backgroundColor = [UIColor whiteColor];
        yaoqingrenPhoneField.font = [UIFont systemFontOfSize:20.0f];
        yaoqingrenPhoneField.delegate = self;
        yaoqingrenPhoneField.textColor = [UIColor grayColor];
        yaoqingrenPhoneField.placeholder=@"邀请人手机号(选填)";
        yaoqingrenPhoneField.secureTextEntry = YES;
        yaoqingrenPhoneField.secureTextEntry = NO;

        yaoqingrenPhoneField.keyboardType = UIKeyboardTypeDefault;
        yaoqingrenPhoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        yaoqingrenPhoneField.returnKeyType = UIReturnKeyGo;
        yaoqingrenPhoneField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:yaoqingrenPhoneField];
        
        NSArray *titleArr=[[NSArray alloc]initWithObjects:@"手机号:",@"验证码:",@"密   码:",@"密   码:",@"邀请人姓名:",@"邀请人手机:", nil];
        for (int i=0; i<6; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 5+30*i, 100, 20)];
            [label setText:[titleArr objectAtIndex:i]];
            [self addSubview:label];
            
        }


        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 30, 320, 0.5)];
        line.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:line];
        
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 0.5)];
        line1.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:line1];
        
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 90, 320, 0.5)];
        line2.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:line2];
        UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, 120, 320, 0.5)];
        line3.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:line3];
        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(0, 150, 320, 0.5)];
        line4.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:line4];
        
        float buttonW = 74.0f, buttonH = 32.0f;
        confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.frame = CGRectMake((kContentWidth - buttonW) / 2, 200.0f, buttonW, buttonH);
        [confirmButton setTitle:@"下一步"
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
    }
    return self;
}
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
    
    [self hiddenKeyboard];
    
    
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] getVerifyCodeWithPhoneNumber:phone
                                                            complete:^(BOOL success, int result) {
                                                                [HttpResponseNotification getVerifyCodeHttpResponse:result];
                                                                
                                                                if (success && result == RESPONSE_SUCCESS) {
                                                                    [[NSNotificationCenter defaultCenter] postNotificationName:kResultGetVerifyCode object:@"SUCCESS"];
                                                                    [self startTimer];
                                                                 
                                                                } else {
                                                                    [[NSNotificationCenter defaultCenter] postNotificationName:kResultGetVerifyCode object:@"FAIL"];
                                                                }
                                                            }];

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
    [getVerifyCodeButton setEnabled:YES];
}

- (void)timerFired:(NSTimer *)_timer
{
    if (time >= 0) {
        [getVerifyCodeButton setTitle:[NSString stringWithFormat:@"再次发送(%d)", time] forState:UIControlStateNormal];
        [getVerifyCodeButton setEnabled:NO];
        time --;
    } else {
        [self stopTimer];
    }
}


- (void)hiddenKeyboard
{
    [verifyCodeField resignFirstResponder];
    [passwordField resignFirstResponder];
    [repeatPwdField resignFirstResponder];
    [yaoqingrenField resignFirstResponder];
    [yaoqingrenPhoneField resignFirstResponder];
}

//确认注册
- (void)confirm
{
    [self hiddenKeyboard];
    
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
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"密码不能少于6个字符"];
        return;
    }
    
    NSString *rePwd = repeatPwdField.text;
    if (rePwd == nil || [rePwd isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入确认密码"];
        return;
    } else if (rePwd.length < PasswordMinDigit) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"密码不能少于6个字符"];
        return;
    }
    
    if (![pwd isEqualToString:rePwd]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"两次密码不一致"];
        return;
    }
    if (![yaoqingrenPhoneField.text isEqualToString:@""]) {
        [self homedown];
    }else if ([yaoqingrenField.text isEqualToString:@""]&&[yaoqingrenPhoneField.text isEqualToString:@""])
    {
        [_delegate didRegisterWithPassword:rePwd verifyCode:code phone:phoneField.text invite_name:yaoqingrenField.text invite_number:yaoqingrenPhoneField.text];
    }
    
    
    
    
    
    
//    [_delegate didRegisterWithPassword:rePwd verifyCode:code phone:phoneField.text];
}

-(void)homedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:yaoqingrenPhoneField.text,@"phone", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:kUserGetyaoqingrenURL];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络不给力啊"];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *flag=[dic objectForKey:@"flag"];
        if ([flag isEqualToString:@"error"])
        {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"邀请人手机号输入有误"];
            
        }else
        {
            [_delegate didRegisterWithPassword:repeatPwdField.text verifyCode:verifyCodeField.text phone:phoneField.text invite_name:yaoqingrenField.text invite_number:yaoqingrenPhoneField.text];

        }
    }
}
//缪缪

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == passwordField) {
        
    } else if (textField == repeatPwdField) {

    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= PasswordMaxDigit) {
        return NO;
    } else if (textField == verifyCodeField){
        if (range.location >= VerifyCodeDigit) {
            return NO;
        }
    } else if (textField== phoneField) {
        if (range.location>=11) {
            return NO;
        }
    }else if (textField== yaoqingrenPhoneField) {
        if (range.location>=11) {
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

@end