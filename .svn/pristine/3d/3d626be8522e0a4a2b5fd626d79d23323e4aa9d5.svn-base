//
//  creatZFPWDSUBViewController.m
//  Community
//
//  Created by HuaMen on 14-10-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "creatZFPWDSUBViewController.h"
#import "GoodAddViewController.h"
#import "SubTuanGouViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40
#define ViewWidth            304


@interface creatZFPWDSUBViewController ()

@end

@implementation creatZFPWDSUBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"OK!!!!");
    float lastSetpImageViewW = 202.0f, lastSetpImageViewH = 66.0f;
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    
    CGRect rect = CGRectMake(LeftMargin,0, ViewWidth, kContentHeight - kTabBarHeight);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    UIImageView *lastSetpImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - lastSetpImageViewW) / 2, 50.0f, lastSetpImageViewW, lastSetpImageViewH)];
    lastSetpImageView.image = [UIImage imageNamed:@"register_welcome"];
    [scrollView addSubview:lastSetpImageView];
    
    float welcomeLabelW = 202.0f, welcomeLabelY = 66.0f;
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kContentWidth - lastSetpImageViewW) / 2, welcomeLabelY, welcomeLabelW, 20.0f)];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont systemFontOfSize:16.0f];
    welcomeLabel.text = @"最后一步，完成注册!";
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:welcomeLabel];
    
    float enterLabelX = 38.0f;
    UILabel *enterVerifyCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 139.0f, 200.0f, 20.0f)];
    enterVerifyCodeLabel.textColor = [UIColor whiteColor];
    enterVerifyCodeLabel.backgroundColor = [UIColor clearColor];
    enterVerifyCodeLabel.font = [UIFont systemFontOfSize:16.0f];
    enterVerifyCodeLabel.text = @"输入验证码";
    [scrollView addSubview:enterVerifyCodeLabel];
    
    float verifyCodeFieldBgY = 165.0f, fieldBgW = 257.0f, fieldBgH = 44.0f;
    UIImageView *verifyCodeFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, verifyCodeFieldBgY, fieldBgW, fieldBgH)];
    verifyCodeFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [scrollView addSubview:verifyCodeFieldBg];
    
    float verifyCodeFieldY = 171.0f, fieldW = 240.0f, fieldH = 30.0f;
    verifyCodeField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, verifyCodeFieldY, fieldW, fieldH)];
    verifyCodeField.backgroundColor = [UIColor clearColor];
    verifyCodeField.font = [UIFont systemFontOfSize:20.0f];
    verifyCodeField.delegate = self;
    verifyCodeField.placeholder= @"输入验证码";
    verifyCodeField.textColor = [UIColor whiteColor];
    verifyCodeField.keyboardType = UIKeyboardTypeNumberPad;
    verifyCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifyCodeField.returnKeyType = UIReturnKeyGo;
    verifyCodeField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [scrollView addSubview:verifyCodeField];
    
    UILabel *enterPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 229.0f, 200.0f, 20.0f)];
    enterPwdLabel.textColor = [UIColor whiteColor];
    enterPwdLabel.backgroundColor = [UIColor clearColor];
    enterPwdLabel.font = [UIFont systemFontOfSize:16.0f];
    enterPwdLabel.text = @"输入密码";
    [scrollView addSubview:enterPwdLabel];
    
    float passwordFieldBgY = 254.0f;
    UIImageView *passwordFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, passwordFieldBgY, fieldBgW, fieldBgH)];
    passwordFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [scrollView addSubview:passwordFieldBg];
    
    float passwordFieldY = 260.0f;
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, passwordFieldY, fieldW, fieldH)];
    passwordField.backgroundColor = [UIColor clearColor];
    passwordField.font = [UIFont systemFontOfSize:20.0f];
    passwordField.delegate = self;
    passwordField.secureTextEntry = YES;
    passwordField.placeholder= @"输入密码";
    passwordField.textColor = [UIColor whiteColor];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.returnKeyType = UIReturnKeyNext;
    passwordField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [scrollView addSubview:passwordField];
    
    UILabel *enterRePwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 319.0f, 200.0f, 20.0f)];
    enterRePwdLabel.textColor = [UIColor whiteColor];
    enterRePwdLabel.backgroundColor = [UIColor clearColor];
    enterRePwdLabel.font = [UIFont systemFontOfSize:16.0f];
    enterRePwdLabel.text = @"确认密码";
    [scrollView addSubview:enterRePwdLabel];
    
    float repeatPwdBgY = 345.0f;
    UIImageView *repeatPwdFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, repeatPwdBgY, fieldBgW, fieldBgH)];
    repeatPwdFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [scrollView addSubview:repeatPwdFieldBg];
    
    repeatPwdField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, 352.0f, fieldW, fieldH)];
    repeatPwdField.backgroundColor = [UIColor clearColor];
    repeatPwdField.font = [UIFont systemFontOfSize:20.0f];
    repeatPwdField.delegate = self;
    repeatPwdField.placeholder=@"确认密码";
    repeatPwdField.secureTextEntry = YES;
    repeatPwdField.textColor = [UIColor whiteColor];
    repeatPwdField.keyboardType = UIKeyboardTypeDefault;
    repeatPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    repeatPwdField.returnKeyType = UIReturnKeyGo;
    repeatPwdField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [scrollView addSubview:repeatPwdField];
    
    float buttonW = 74.0f, buttonH = 32.0f;
    confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake((kContentWidth - buttonW) / 2, 425.0f, buttonW, buttonH);
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
    [scrollView addSubview:confirmButton];
    
    
    scrollView.contentSize = CGSizeMake(ViewWidth, 660);
    

}
-(void)hiddenKeyboard{
    [verifyCodeField resignFirstResponder];
    [passwordField resignFirstResponder];
    [repeatPwdField resignFirstResponder];
    
}
-(void)confirm{
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
    [self downLoad];
    
}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[repeatPwdField.text stringFromSHA256],@"payWord",[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:createPayWord];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"faild===%@",request.error);
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"OK!!");
    NSLog(@"str==%@",request.responseString);
    NSDictionary *dic=[request.responseData objectFromJSONData];
    NSLog(@"%@",dic);
    NSString *result=[dic objectForKey:@"result"];
    if ([result isEqualToString:@"1"]) {
            for(UIViewController *controller in self.navigationController.viewControllers) {
                if([controller isKindOfClass:[SubTuanGouViewController class]]){
                    SubTuanGouViewController*owr = (SubTuanGouViewController *)controller;
                   [self.navigationController popToViewController:owr animated:YES];
              }
          }
        
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
