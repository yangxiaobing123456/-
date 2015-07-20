//
//  GoodAddViewController.m
//  Community
//
//  Created by HuaMen on 14-10-13.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "GoodAddViewController.h"
#import "SHAddListViewController.h"
#import "GoodsSureViewController.h"
#import "SubTuanGouViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40
#define CellHorizontalSpace  8
#define CellVerticalSpace    8
#define ViewWidth            304

@interface GoodAddViewController ()

@end

@implementation GoodAddViewController
- (id)init
{
    self = [super init];
    if (self) {
        addId=[[NSString alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName:) name:@"selectSHAddress" object:nil];
        
    }
    return self;
}
-(void)changeName:(NSNotification *)notice{
    NSLog(@"OK");
    NSDictionary *dic=[notice userInfo];
    NSString *str=[dic objectForKey:@"name"];
    NSString *str1=[dic objectForKey:@"address"];
    NSString *str2=[dic objectForKey:@"phone"];
    addId=[dic objectForKey:@"addressId"];
    [addlabel setText:[NSString stringWithFormat:@"姓名:%@,地址:%@,电话:%@",str,str1,str2]];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downLoad];
    [self downLoad1];
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
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, 100)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    [headView setAlpha:0.4];
    headView.layer.shadowColor = [UIColor blackColor].CGColor;
    headView.layer.shadowOffset = CGSizeMake(4, 4);
    headView.layer.shadowOpacity = 0.5;
    headView.layer.shadowRadius = 2.0;
    [scrollView addSubview:headView];
    UIControl *control=[[UIControl alloc]initWithFrame:headView.frame];
    [control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin+5, 0.0+5, 90, 90)];
    [image setBackgroundColor:[UIColor whiteColor]];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,_headImageStr];
    [image setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"4确认订单_03.png"]];
    [scrollView addSubview:image];
    
    UILabel *tl=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5+90+5, 10, 160, 20)];
    [tl setText:_nameStr];
    [scrollView addSubview:tl];
    
    UILabel *tl1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5+90+5, 35, 160, 20)];
    [tl1 setText:_priceStr];
    [scrollView addSubview:tl1];
    
    UILabel *tl2=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5+90+5, 60, 160, 20)];
    [tl2 setText:_nameStr];
    [scrollView addSubview:tl2];
    
    
    
    
    
    
    UIView *headView1=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 110.0f, TableViewWidth, 200)];
    [headView1 setBackgroundColor:[UIColor whiteColor]];
    [headView1 setAlpha:0.4];
    headView1.layer.shadowColor = [UIColor blackColor].CGColor;
    headView1.layer.shadowOffset = CGSizeMake(4, 4);
    headView1.layer.shadowOpacity = 0.5;
    headView1.layer.shadowRadius = 2.0;
    [scrollView addSubview:headView1];
    
    jifenlabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5, 115.0f, 200, 20)];
    [jifenlabel setText:@""];
    [scrollView addSubview:jifenlabel];
    
    jifenSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(LeftMargin+215, 115.0f, 50, 20)];
    [scrollView addSubview:jifenSwitch];
    
    
    qianbaoLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5, 155.0f, 200, 20)];
    [qianbaoLabel setText:@""];
    [scrollView addSubview:qianbaoLabel];
    
    qianbaoSubLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5, 155.0f, 200, 20)];
    [qianbaoSubLabel setText:@""];
    
    jifenSubLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5, 155.0f, 200, 20)];
    [jifenSubLabel setText:@""];
    
    qianbaoField = [[UITextField alloc] init];
    qianbaoField.frame=CGRectMake(LeftMargin+205, 155.0f, 80, 20);
    qianbaoField.backgroundColor = [UIColor clearColor];
    qianbaoField.borderStyle = UITextBorderStyleBezel;
    qianbaoField.placeholder=@"0元";
    qianbaoField.font = [UIFont systemFontOfSize:12.0f];
    qianbaoField.delegate = self;
    qianbaoField.textColor = [UIColor whiteColor];
//    qianbaoField.keyboardType = UIKeyboardTypeNumberPad;
    qianbaoField.clearButtonMode = UITextFieldViewModeWhileEditing;
    qianbaoField.returnKeyType = UIReturnKeyGo;
    qianbaoField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:qianbaoField];
    
    addlabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5, 200.0f, 200, 60)];
    [addlabel setTextColor:[UIColor whiteColor]];
    [addlabel setLineBreakMode:NSLineBreakByCharWrapping];
    [addlabel setNumberOfLines:0];
    [addlabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
        [addlabel setText:@"参加团购，必须注册成为易社区VIP；团购有效时间为2014念9月6日开始，9日结束"];
    [scrollView addSubview:addlabel];
    
    
    
    UIImageView *greenImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, kNavContentHeight-50, self.view.bounds.size.width, 50)];
    [greenImage setBackgroundColor:[UIColor greenColor]];
    [greenImage setAlpha:0.5];
    [self.view addSubview:greenImage];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"去支付" forState:UIControlStateNormal];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=5;
    [btn setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:239.0/255.0 blue:0.0/255.0 alpha:1]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, kNavContentHeight-40, 120, 20)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    [addbtn setFrame:CGRectMake(LeftMargin+215, 210.0f, 50, 50)];
    [addbtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addbtn];
    
    

}
-(void)controlClick{
    [qianbaoField resignFirstResponder];
}
-(void)downLoad1{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:getuserAllAddress];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=200;
        request.delegate=self;
        [request startAsynchronous];
    }
    
}

-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:maShangQiang];
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
    if (request.tag==200) {
        NSLog(@"faild=====%@",request.error);
    }
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            [jifenlabel setText:[NSString stringWithFormat:@"可使用益积分:%@",[[dic objectForKey:@"integral"]stringValue]]];
            [qianbaoLabel setText:[NSString stringWithFormat:@"可使用益钱包:%@元",[[dic objectForKey:@"wallet"] stringValue]]];
            [jifenSubLabel setText:[[dic objectForKey:@"integral"] stringValue]];
            [qianbaoSubLabel setText:[[dic objectForKey:@"wallet"] stringValue]];
            colduseStr=[[dic objectForKey:@"wallet"] stringValue];
            _interStr=[[dic objectForKey:@"integral"] stringValue];
            
    
            
        }
    }if (request.tag==200) {
        NSLog(@"str=================%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSArray *arr=[dic objectForKey:@"addressList"];
            if (arr||arr!=nil) {
                NSString *str=[[arr objectAtIndex:0]objectForKey:@"address"];
                NSString *str1=[[arr objectAtIndex:0]objectForKey:@"phone"];
                NSString *str2=[[arr objectAtIndex:0]objectForKey:@"name"];
                [addlabel setText:[NSString stringWithFormat:@"姓名:%@,地址:%@,电话:%@",str2,str,str1]];
                addId=[[arr objectAtIndex:0]objectForKey:@"addressId"];
            }
        }
    }

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [qianbaoField resignFirstResponder];
    return YES;
}

-(void)btnClick{
    if ([qianbaoField.text intValue]>[colduseStr intValue]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"钱包余额不足"];
        return;
        
    }
    if ([jifenSwitch isOn]) {
        if ([_priceStr intValue]-[_interStr intValue]>0) {
            if ([qianbaoField.text intValue]>[_priceStr intValue]-[_interStr intValue]) {
                [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"付款错误11"];
                return;
                
            }

        }
            }if (![jifenSwitch isOn]) {
        if ([qianbaoField.text intValue]>[_priceStr intValue]) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"付款22"];
            return;
            
        }
    }
        GoodsSureViewController *gv=[[GoodsSureViewController alloc]init];
    if ([qianbaoField.text floatValue]>[_priceStr floatValue]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"钱包使用失败"];
        return;

    }
    gv.title=@"我的订单";
    gv.nameStr=_nameStr;
    gv.priceStr=_priceStr;
    gv.headImageStr=_headImageStr;
    if ([jifenSwitch isOn]) {
        gv.integel=jifenSubLabel.text;
    }else{
        gv.integel=@"0";
    }
    gv.GoodID=_GoodID;
    gv.wallet=qianbaoField.text;
    gv.addressID=addId;
    gv.allStr=_allStr;
    [self.navigationController pushViewController:gv animated:YES];

    
}
-(void)addClick{
//    for(UIViewController *controller in self.navigationController.viewControllers) {
//        if([controller isKindOfClass:[SubTuanGouViewController class]]){
//            SubTuanGouViewController*owr = (SubTuanGouViewController *)controller;
//            [self.navigationController popToViewController:owr animated:YES];
//        }
//    }

    SHAddListViewController *gv=[[SHAddListViewController alloc]init];
    gv.title=@"收货地址";
    [self.navigationController pushViewController:gv animated:YES];
    
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
