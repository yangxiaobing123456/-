//
//  ShareActivityViewController.m
//  Community
//
//  Created by HuaMen on 15-2-2.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "ShareActivityViewController.h"

@interface ShareActivityViewController ()

@end

@implementation ShareActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"分享";
    
    //创建一个手势 取消第一响应
    UITapGestureRecognizer *gestureRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:gestureRecgnizer];

    [self addBarButtonItem];
    [self addAllViews];
}

#pragma mark-  BarButtonItem
- (void)addBarButtonItem
{
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    leftBarBtn.frame=CGRectMake(0, 0, 12, 20);
    leftBarBtn.tag = 101;
    [leftBarBtn addTarget:self action:@selector(BarBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)BarBtnSelect:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确认要放弃分享吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.delegate = self;
    alert.tag=10;
    [alert show];

//    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addAllViews
{
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightTextColor];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];

    //添加一个label另加一个点击函数 实现placeholder效果
//    UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 165.0f)];
//    textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
//    [scrollView addSubview:textViewBg];
    
    tsTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15.0f, 290, 155)];
    tsTextView.backgroundColor = [UIColor whiteColor];
    tsTextView.textColor = [UIColor grayColor];
    [tsTextView setText:@"说出你要分享的内容"];
    tsTextView.returnKeyType = UIReturnKeyDefault;
    tsTextView.layer.borderWidth = 0.5f;
    tsTextView.layer.borderColor = RGBA(217, 217, 217, 1).CGColor;

    tsTextView.delegate = self;
    tsTextView.font = [UIFont fontWithName:@"Arial" size:16.0];
    [scrollView addSubview:tsTextView];

    

//    imageUploadView = [[MultiImageUploadView alloc] initWithFrame:CGRectMake(10.0f, 180.0f, 74.0f, 64.0f)];
    imageUploadView = [[MultiImageUploadView alloc] initWithFrame:CGRectMake(10.0f, 180.0f, 300.0f, 128.0f)];
    imageUploadView.backgroundColor=[UIColor whiteColor];
    imageUploadView.controller = self;
    imageUploadView.type = 4;
    imageUploadView.delegate = self;
    [scrollView addSubview:imageUploadView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(10, kScreenHeight-150, 300.0f, 45.0f);
    [submitButton setTitle:@"提交分享"
                  forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 4;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
//    [submitButton setTitleColor:[UIColor whiteColor]
//                       forState:UIControlStateNormal];
//    [submitButton setBackgroundImage:[UIImage imageNamed:@"icon01"]
//                            forState:UIControlStateNormal];
//    [submitButton setBackgroundImage:[UIImage imageNamed:@"icon10"]
//                            forState:UIControlStateHighlighted];
    submitButton.backgroundColor = mmRGBA;

    [submitButton addTarget:self
                     action:@selector(submitButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitButton];

    
    scrollView.contentSize = CGSizeMake(320, 580.0f);


}

- (void)submitButtonClick
{
    [tsTextView resignFirstResponder];
    
//    int complainType = 0;
//    for (int i = 1; i <= 5; i++) {
//        SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
//        if (view.isOn) {
//            complainType = i;
//        }
//    }
//    
//    if (complainType == 0) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"选择投诉的类型"];
//        return;
//    }
    
    NSString *tsString = [tsTextView.text trim];
    if ([tsString isEmptyOrBlank] || tsString == nil) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入分享的内容"];
        return;
    }
    
    NSString *pictureURL = @"";
    if (imageUploadView.URLArray.count > 0) {
        for (int i = 0; i < imageUploadView.URLArray.count; i ++) {
            pictureURL = [pictureURL stringByAppendingString:imageUploadView.URLArray[i]];
            if (i != imageUploadView.URLArray.count - 1) {
                pictureURL = [pictureURL stringByAppendingString:@"#"];
            }
        }
    }
    NSLog(@"pictureURL----%@", pictureURL);
    
    NSDictionary *shareDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  self.idStr, @"activityId",
                                  pictureURL, @"picture",
                                  tsString, @"content", nil];
    NSLog(@"shareDict----%@", shareDict);
    [self homedown:shareDict];
    
}

-(void)homedown:(NSDictionary *)user{
//    NSDictionary *user = dic;
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:ShareActivity];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);//[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",
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
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSLog(@"result----%@",result);

            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
}


- (void)submitComplainDict:(NSDictionary *)dict
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] shareWithDict:dict
                                                complete:^(BOOL success, ComplainAndRepairResponse *resp) {
                                                    //NSLog(@"",);
                                                    if (success && resp.result == RESPONSE_SUCCESS) {
                                                        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"分享成功"];
                                                         
                                              //          [self.navigationController popViewControllerAnimated:YES];
                                                        
                                                    } else {
                                                        if (resp.result) {
                                                            [HttpResponseNotification TSBXHttpResponse:resp.result];
                                                        } else {
                                                            [HttpResponseNotification TSBXHttpResponse:RESPONSE_ERROR];
                                                        }
                                                    }
                                                }];
}

//#pragma mark -UITextField Delegate Method
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [tsTextView resignFirstResponder];
//    return YES;
//}
//#pragma mark -UITextView Delegate Method
//-(BOOL)textView:(UITextView *)textView shouldChangetTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if([text isEqualToString:@"\n"]){
//        [textView resignFirstResponder];
//        return YES;
//    }
//    return YES;
//}

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    [tsTextView resignFirstResponder];
//    [self.view resignFirstResponder];
//}

#pragma mark MultiImageUploadViewDelegate
- (void)hideKeyboard
{
    [tsTextView resignFirstResponder];
}

- (void)tapClick
{
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text=@"";
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10&&buttonIndex==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (alertView.tag==20&&buttonIndex==1) {
        [self.navigationController popViewControllerAnimated:YES];
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
