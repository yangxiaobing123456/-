//
//  JoinActViewController.m
//  Community
//
//  Created by HuaMen on 14-12-29.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "JoinActViewController.h"
#import "NewActivityViewController.h"

@interface JoinActViewController ()
{
    UITextView *textView_m;
    
}

@end

@implementation JoinActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    [self addBarButtonItem];
    
    //创建一个手势 取消第一响应
    UITapGestureRecognizer *gestureRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:gestureRecgnizer];

//    UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 105.0f)];
//    textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
//    [self.view addSubview:textViewBg];
    
    textView_m = [[UITextView alloc] initWithFrame:CGRectMake(15, 15.0f, 290, 100)];
    textView_m.backgroundColor = [UIColor whiteColor];
    textView_m.textColor = [UIColor grayColor];
    textView_m.layer.borderWidth = 0.5f;
    textView_m.layer.borderColor = RGBA(217, 217, 217, 1).CGColor;
    
    [textView_m setText:self.contentStr];
    textView_m.delegate = self;
    textView_m.returnKeyType = UIReturnKeyDefault;
    textView_m.font = [UIFont fontWithName:@"Arial" size:16.0];
    [self.view addSubview:textView_m];
    
    canjiaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage imageNamed:@"凸起按钮"] forState:UIControlStateNormal];
    [canjiaBtn setTitle:self.btnStr forState:UIControlStateNormal];
    canjiaBtn.frame=CGRectMake(10, kScreenHeight-180, 300, 45);
    canjiaBtn.layer.cornerRadius = 4;
    canjiaBtn.layer.masksToBounds = YES;
    [canjiaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    canjiaBtn.backgroundColor = mmRGBA;

    [canjiaBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canjiaBtn];
    // Do any additional setup after loading the view from its nib.
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
    if (self.tag==1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确认要放弃参加吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.delegate = self;
        alert.tag=10;
        [alert show];
        
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确认要放弃编辑吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.delegate = self;
        alert.tag=20;
        [alert show];
    }
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnClick{
    if (self.tag==1) {
        if ([textView_m.text isEqualToString:@""]||[textView_m.text isEqualToString:@"一句话介绍自己情况"] ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"介绍自己情况不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
    }else
    {
        if ([textView_m.text isEqualToString:@""]||[textView_m.text isEqualToString:@"说出你要讨论的内容"] ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"讨论内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
    }


    canjiaBtn.userInteractionEnabled=NO;
    [self homedown];
    
}
#pragma mark request methods
-(void)homedown{
    
    //根据  不同的controller传不同的参数
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId",textView_m.text,@"content", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:JoinActivity];
        if (self.tag==1) {
            url = [NSURL URLWithString:JoinActivity];
        }else
        {
            url = [NSURL URLWithString:AddDiscuss];
        }
        NSLog(@"urlStr=========%@",url);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
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
    canjiaBtn.userInteractionEnabled=YES;

    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
             [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"提交成功,恭喜您!"];
//            for(UIViewController *controller in self.navigationController.viewControllers) {
//                if([controller isKindOfClass:[NewActivityViewController class]]){
//                    NewActivityViewController*owr = (NewActivityViewController *)controller;
//                    [self.navigationController popToViewController:owr animated:YES];
//                }
//            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkpoprefreshNotification" object:dic];

            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
             [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"哎呀，参与失败了！"];
            canjiaBtn.userInteractionEnabled=YES;

            
        }
    }
    
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
