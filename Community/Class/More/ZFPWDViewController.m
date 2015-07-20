//
//  ZFPWDViewController.m
//  Community
//
//  Created by HuaMen on 14-10-10.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "ZFPWDViewController.h"
#import "ASIHTTPRequest.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40
#define CellHorizontalSpace  8
#define CellVerticalSpace    8
#define ViewWidth            304

@interface ZFPWDViewController ()

@end

@implementation ZFPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(LeftMargin,0, ViewWidth, kContentHeight - kTabBarHeight);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    float enterLabelX = 38.0f;
    UILabel *enterOldPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 25.0f, 200.0f, 20.0f)];
    enterOldPwdLabel.textColor = [UIColor grayColor];
    enterOldPwdLabel.backgroundColor = [UIColor clearColor];
    enterOldPwdLabel.font = [UIFont systemFontOfSize:16.0f];
    enterOldPwdLabel.text = @"原密码";
    [scrollView addSubview:enterOldPwdLabel];
    
    float oldPwdFieldBgY = 50.0f, fieldBgW = 257.0f, fieldBgH = 44.0f;
    UIImageView *phoneFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, oldPwdFieldBgY, fieldBgW, fieldBgH)];
    phoneFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [scrollView addSubview:phoneFieldBg];
    
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
    [scrollView addSubview:oldPasswordField];
    
    UILabel *enterNewPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 109.0f, 200.0f, 20.0f)];
    enterNewPwdLabel.textColor = [UIColor grayColor];
    enterNewPwdLabel.backgroundColor = [UIColor clearColor];
    enterNewPwdLabel.font = [UIFont systemFontOfSize:16.0f];
    enterNewPwdLabel.text = @"新密码";
    [scrollView addSubview:enterNewPwdLabel];
    
    float passwordFieldBgY = 134.0f;
    UIImageView *passwordFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, passwordFieldBgY, fieldBgW, fieldBgH)];
    passwordFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [scrollView addSubview:passwordFieldBg];
    
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
    [scrollView addSubview:newPasswordField];
    
    UILabel *enterRePwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 193.0f, 200.0f, 20.0f)];
    enterRePwdLabel.textColor = [UIColor grayColor];
    enterRePwdLabel.backgroundColor = [UIColor clearColor];
    enterRePwdLabel.font = [UIFont systemFontOfSize:16.0f];
    enterRePwdLabel.text = @"确认密码";
    [scrollView addSubview:enterRePwdLabel];
    
    float repeatPwdBgY = 218.0f;
    UIImageView *repeatPwdFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, repeatPwdBgY, fieldBgW, fieldBgH)];
    repeatPwdFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [scrollView addSubview:repeatPwdFieldBg];
    
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
    [scrollView addSubview:repeatPwdField];
    
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
    [scrollView addSubview:confirmButton];
    
    scrollView.contentSize = CGSizeMake(ViewWidth, 480);


    
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
    }
//    else if (![[AppSetting userPassword] isEqualToString:[oldPwd stringFromSHA256]]) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"旧密码输入错误"];
//        return;
//    }
    
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
    [self downLoad];
    

}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[oldPasswordField.text stringFromSHA256],@"oldPassword",[newPasswordField.text stringFromSHA256],@"newPassword",[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
//        @"http://192.168.1.133:8080/duoyi/userCenter/changePayWord"
        NSURL *url = [NSURL URLWithString:changePayWord];
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
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }if (![result isEqualToString:@"1"]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"修改失败"];
        [oldPasswordField setText:@""];
        [newPasswordField setText:@""];
        [repeatPwdField setText:@""];
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

//-(void)getVerifyCode{
////    if (time > 0) {//120秒内不能再次点击按钮
////        return;
////    }
//    NSString *phone = phoneField.text;
//    if (phone == nil || [phone isEmptyOrBlank]) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入手机号"];
//        return;
//    } else if (![phone isChinaPhoneNumber]) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入正确的手机号"];
//        return;
//    }
//    
//    [phoneField resignFirstResponder];
//    [[HttpClientManager sharedInstance] getZFVerifyCodeWithPhoneNumber:phone
//                                                            complete:^(BOOL success, int result) {
//                                                                [HttpResponseNotification getVerifyCodeHttpResponse:result];
//                                                                
//                                                                
//                                                                if (success && result == RESPONSE_SUCCESS) {
//                                                                    
//                                                                } else {
//                                                                    
//                                                                }
//                                                            }];
//
//
//    
//}
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
