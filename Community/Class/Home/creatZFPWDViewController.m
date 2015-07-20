//
//  creatZFPWDViewController.m
//  Community
//
//  Created by HuaMen on 14-10-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "creatZFPWDViewController.h"
#import "creatZFPWDSUBViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40
#define ViewWidth            304

@interface creatZFPWDViewController ()

@end

@implementation creatZFPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    float welcomeImageViewW = 202.0f, welcomeImageViewH = 66.0f;
    UIImageView *welcomeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - welcomeImageViewW) / 2, 50.0f, welcomeImageViewW, welcomeImageViewH)];
    welcomeImageView.image = [UIImage imageNamed:@"register_welcome"];
    [scrollView addSubview:welcomeImageView];
    
    float welcomeLabelW = 202.0f, welcomeLabelY = 66.0f;
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kContentWidth - welcomeImageViewW) / 2, welcomeLabelY, welcomeLabelW, 20.0f)];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.font = [UIFont systemFontOfSize:16.0f];
    welcomeLabel.text = @"欢迎创建支付密码";
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:welcomeLabel];
    
    float enterLabelX = 38.0f;
    UILabel *enterPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(enterLabelX, 137.0f, 200.0f, 23.0f)];
    enterPhoneLabel.textColor = [UIColor whiteColor];
    enterPhoneLabel.backgroundColor = [UIColor clearColor];
    enterPhoneLabel.font = [UIFont systemFontOfSize:16.0f];
    enterPhoneLabel.text = @"输入手机号";
    [scrollView addSubview:enterPhoneLabel];
    
    float phoneFieldBgY = 165.0f, fieldBgW = 257.0f, fieldBgH = 44.0f;
    UIImageView *phoneFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - fieldBgW) / 2, phoneFieldBgY, fieldBgW, fieldBgH)];
    phoneFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [scrollView addSubview:phoneFieldBg];
    
    float phoneFieldY = 171.0f, fieldW = 240.0f, fieldH = 30.0f;
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake((kContentWidth - fieldW) / 2, phoneFieldY, fieldW, fieldH)];
    phoneField.backgroundColor = [UIColor clearColor];
    phoneField.font = [UIFont systemFontOfSize:20.0f];
    phoneField.delegate = self;
    phoneField.textColor = [UIColor whiteColor];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneField.returnKeyType = UIReturnKeyNext;
    phoneField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [scrollView addSubview:phoneField];
    
    float getVerifyCodeButtonW = 100.0f, buttonH = 32.0f;
    getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getVerifyCodeButton.frame = CGRectMake((kContentWidth - getVerifyCodeButtonW) / 2, 239.0f, getVerifyCodeButtonW, buttonH);
    [getVerifyCodeButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [getVerifyCodeButton setTitle:@"发送验证码"
                         forState:UIControlStateNormal];
    [getVerifyCodeButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                              forState:UIControlStateNormal];
    [getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"button_normal_200W"]
                                   forState:UIControlStateNormal];
    [getVerifyCodeButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                                   forState:UIControlStateHighlighted];
    [getVerifyCodeButton addTarget:self
                            action:@selector(getVerifyCode)
                  forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:getVerifyCodeButton];
    
    scrollView.contentSize = CGSizeMake(ViewWidth, 480);
    

    

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [phoneField resignFirstResponder];
    return YES;
    
}
- (void)hiddenKeyboard
{
    [phoneField resignFirstResponder];
}
- (void)getVerifyCode
{
    NSString *phone = phoneField.text;
    if (phone == nil || [phone isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入手机号"];
        return;
    } else if (![phone isChinaPhoneNumber]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入正确的手机号"];
        return;
    }
    [self hiddenKeyboard];
//    creatZFPWDSUBViewController *Sv=[[creatZFPWDSUBViewController alloc]init];
//    [self.navigationController pushViewController:Sv animated:YES];
    [self downLoad];
    
}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:phoneField.text,@"phone",[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:sendCode];
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
        creatZFPWDSUBViewController *Sv=[[creatZFPWDSUBViewController alloc]init];
        [self.navigationController pushViewController:Sv animated:YES];
        
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
