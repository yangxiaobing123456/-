//
//  DDWKViewController.m
//  Community
//
//  Created by HuaMen on 14-10-21.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "DDWKViewController.h"
#import "creatZFPWDViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40
#define CellHorizontalSpace  8
#define CellVerticalSpace    8
#define ViewWidth            304
#define LabelWidth           100

@interface DDWKViewController ()

@end

@implementation DDWKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPerson];
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
//    [self downLoad];
    
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
    
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin+5, 0.0+5, 90, 90)];
    [image setBackgroundColor:[UIColor whiteColor]];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,_pictureStr];
    [image setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"4确认订单_03.png"]];
    [scrollView addSubview:image];
    
    UILabel *tl=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5+90+5, 10, 160, 20)];
    [tl setText:_goodsName];
    [scrollView addSubview:tl];
    

    
    UILabel *tl1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5+90+5, 35, 160, 20)];
    [tl1 setText:_groupPrice];
    [scrollView addSubview:tl1];
    
    UILabel *tl2=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+5+90+5, 60, 160, 20)];
    [tl2 setText:_goodsName];
    [scrollView addSubview:tl2];
    
    UIView *dingdanView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 105.0f, TableViewWidth, 30)];
    [dingdanView setBackgroundColor:[UIColor whiteColor]];
    [dingdanView setAlpha:0.4];
    dingdanView.layer.shadowColor = [UIColor blackColor].CGColor;
    dingdanView.layer.shadowOffset = CGSizeMake(4, 4);
    dingdanView.layer.shadowOpacity = 0.5;
    dingdanView.layer.shadowRadius = 2.0;
    [scrollView addSubview:dingdanView];
    
    UILabel  *dingdanlabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 110, TableViewWidth, 20)];
    dingdanlabel.text=@"   您的订单";
    [dingdanlabel setTextColor:[UIColor orangeColor]];
    [scrollView addSubview:dingdanlabel];
    
    UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 140.0f, TableViewWidth, 300)];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    [contentView setAlpha:0.4];
    contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(4, 4);
    contentView.layer.shadowOpacity = 0.5;
    contentView.layer.shadowRadius = 2.0;
    [scrollView addSubview:contentView];
    
    UIView *SubcontentView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin+10, 140.0f+5, TableViewWidth-20, 20)];
    [SubcontentView setBackgroundColor:[UIColor whiteColor]];
    SubcontentView.layer.shadowColor = [UIColor blackColor].CGColor;
    SubcontentView.layer.shadowOffset = CGSizeMake(4, 4);
    SubcontentView.layer.shadowOpacity = 0.5;
    SubcontentView.layer.shadowRadius = 2.0;
    [scrollView addSubview:SubcontentView];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 140.0f+5, TableViewWidth-20, 20)];
    [l setText:@"项目               数量               金额"];
    [scrollView addSubview:l];
    
    UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 140.0f+35, LabelWidth, 20)];
    [l1 setText:_goodsName];
    [scrollView addSubview:l1];
    
    label1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+220, 140.0f+35, 160, 20)];
    [label1 setText:_groupPrice];
    [scrollView addSubview:label1];
    
    UILabel *l2=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 140.0f+65,LabelWidth, 20)];
    int i=[_groupPrice intValue]-[_depositStr intValue];
    if (i<=0) {
        i=0;
    }
    [l2 setText:@"应付金额"];
    [scrollView addSubview:l2];
    label2=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+220, 140.0f+65, 160, 20)];
    [label2 setText:[NSString stringWithFormat:@"%d",i]];
    [scrollView addSubview:label2];
    
    UILabel *l3=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 140.0f+95, LabelWidth, 20)];
    [l3 setText:@"益积分"];
    
    label3=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+220, 140.0f+95, 160, 20)];

    [scrollView addSubview:label3];

    [scrollView addSubview:l3];
    if ([_wallet isEqualToString:@""]||_wallet==nil) {
        _wallet=@"0";
    }
    UILabel *l4=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 140.0f+125, LabelWidth, 20)];
    [l4 setText:@"益钱包"];

    [scrollView addSubview:l4];
    label4=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+220, 140.0f+125, 160, 20)];
    [scrollView addSubview:label4];
    
    UILabel *l5=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 140.0f+155, LabelWidth, 20)];
    [l5 setText:@"实付金额"];
    [scrollView addSubview:l5];
    label5=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+220, 140.0f+155, 160, 20)];
    [label5 setText:label2.text];
    [scrollView addSubview:label5];
    
    allDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:_integel,@"integral",_wallet,@"wallet",[NSString stringWithFormat:@"%d",i],@"realMoney",@"1",@"goodsNum",_addressID,@"receiptId", nil];
    NSLog(@"AA===%@",allDic);
    
    
    UIView *SubcontentView1=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin+10, 325, TableViewWidth-20, 20)];
    [SubcontentView1 setBackgroundColor:[UIColor whiteColor]];
    SubcontentView1.layer.shadowColor = [UIColor blackColor].CGColor;
    SubcontentView1.layer.shadowOffset = CGSizeMake(4, 4);
    SubcontentView1.layer.shadowOpacity = 0.5;
    SubcontentView1.layer.shadowRadius = 2.0;
    [scrollView addSubview:SubcontentView1];
    
    UILabel *l6=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 325, TableViewWidth-20, 20)];
    [l6 setText:@"购买方式"];
    [scrollView addSubview:l6];
    
    UIImageView *yinLianImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin+10, 355, 70, 40)];
    [yinLianImage setImage:[UIImage imageNamed:@"uppay_220W"]];
    [scrollView addSubview:yinLianImage];
    
    UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor redColor]];
    [sureBtn setTintColor:[UIColor whiteColor]];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setFrame:CGRectMake(LeftMargin+10+90, 405, 100, 15)];
    [scrollView addSubview:sureBtn];
    
    scrollView.contentSize = CGSizeMake(ViewWidth, 550);
    
    SubcontentView2=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin+10+50, 445, TableViewWidth-20-100, 60)];
    [SubcontentView2 setBackgroundColor:[UIColor whiteColor]];
    [SubcontentView2 setAlpha:0.4];
    SubcontentView2.layer.shadowColor = [UIColor blackColor].CGColor;
    SubcontentView2.layer.shadowOffset = CGSizeMake(4, 4);
    SubcontentView2.layer.shadowOpacity = 0.5;
    SubcontentView2.layer.shadowRadius = 2.0;
    [scrollView addSubview:SubcontentView2];
    [SubcontentView2 setHidden:YES];
    
    typelabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10+50+10, 445, TableViewWidth-20-100-20, 20)];
    [typelabel setText:@"请输入支付密码"];
    [typelabel setTextAlignment:NSTextAlignmentCenter];
    [typelabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:typelabel];
    [typelabel setHidden:YES];
    
    typeField=[[UITextField alloc]initWithFrame:CGRectMake(LeftMargin+10+50+10, 470, TableViewWidth-20-100-20, 20)];
    [typeField setPlaceholder:@"请输入支付密码"];
    [typeField setBorderStyle:UITextBorderStyleRoundedRect];
    [typeField setSecureTextEntry:YES];
    typeField.delegate=self;
    [scrollView addSubview:typeField];
    [typeField setHidden:YES];
    
    
    creatBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [creatBtn setFrame:typeField.frame];
    [creatBtn setTitle:@"创建密码" forState:UIControlStateNormal];
    [creatBtn addTarget:self action:@selector(createPWD) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:creatBtn];
    [creatBtn setHidden:YES];
    
}
-(void)getPerson{
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
        request.tag=300;
        request.delegate=self;
        [request startAsynchronous];
    }


    
    
}
-(void)sureClick{
    [self downLoad];
    if ([typeField.text isEqualToString:@""]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请填写支付密码"];
    }else{
        [self pay];
    }
}

-(void)pay{
    NSString *s=@"";
    if ([_wallet isEqualToString:@""]||_wallet==nil) {
        s=@"0";
    }else{
        s=_wallet;
        
    }
    [[CommunityIndicator sharedInstance] startLoading];
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",[typeField.text stringFromSHA256],@"pwd",_orderId,@"orderId",_groupBuyGoodsId,@"groupBuyGoodsId" ,@"0",@"integral",@"0",@"walletNum",label5.text,@"realMoney",@"1",@"goodsNum",nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:toEnsureWeiPay];
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
-(void)createPWD{
    creatZFPWDViewController *cv=[[creatZFPWDViewController alloc]init];
    cv.title=@"创建支付密码";
    [self.navigationController pushViewController:cv animated:YES];
    
    
    
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
        NSURL *url = [NSURL URLWithString:toCheckPassword];
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
    [[CommunityIndicator sharedInstance] hideIndicator:YES];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            [SubcontentView2 setHidden:NO];
            [typelabel setHidden:NO];
            [creatBtn setHidden:YES];
            [typeField setHidden:NO];
            [typelabel setText:@"请输入密码"];
            
            
        }if ([result isEqualToString:@"5"]) {
//            [SubcontentView2 setHidden:NO];
//            [typelabel setHidden:NO];
//            [creatBtn setHidden:NO];
//            [typeField setHidden:YES];
//            [typelabel setText:@"请先创建密码"];
            [self createPWD];
        }
        
    }if (request.tag==200) {
        [[CommunityIndicator sharedInstance] hideIndicator:YES];
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        //        int *str=[[dic objectForKey:@"payResponse"]objectForKey:@"result"];
        //        NSLog(@"%d",str);
        //        NSArray *arr=[dic objectForKey:@"payResponse"];
        //        if ([[[arr lastObject]objectForKey:@"result"]isEqualToString:@"1"]) {
        //            _tradeStr=[[arr lastObject]objectForKey:@"tradeNumber"];
        //        }
        if ([result isEqualToString:@"1"]) {
            NSDictionary *arr=[dic objectForKey:@"payResponse"];
            NSString *str=[arr objectForKey:@"tradeNumber"];
            _tradeStr=str;
            
            [self generateOrder];
            
        }
        
        
        if ([result isEqualToString:@"4"]) {
            [typeField setText:@""];
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请重新输入密码"];
            
            
            
        }
        
    }if (request.tag==300) {
        [[CommunityIndicator sharedInstance] hideIndicator:YES];
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            [label3 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"integral"]]];
            [label4 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"wallet"]]];

        }
        
        
       
    }

}     
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    //没有就实例化一个新的,改为subtitle才能用副标题
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    return cell;
    
}

-(void)generateOrder{
    [UPPayPlugin startPay:_tradeStr
                     mode:@"01"
           viewController:self
                 delegate:self];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [typeField resignFirstResponder];
    return YES;
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
