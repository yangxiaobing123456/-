//
//  ActivityDetailNewViewController.m
//  Community
//
//  Created by HuaMen on 15-2-1.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "ActivityDetailNewViewController.h"
//#import "TabarView.h"
#import "ShareActivityViewController.h"
#import "JoinActViewController.h"

#define contentLabelheight     305
#define Originheight     190

@interface ActivityDetailNewViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *telephoneLabel;



@end

@implementation ActivityDetailNewViewController


//xib构建的scrollView无法滚动  添加辅助方法！！！！！！！！！！！！！
-(void) viewDidAppear:(BOOL)animated{
    
    self.myNewScrollview.frame= self.view.frame;
    
    [self.myNewScrollview setContentSize:CGSizeMake(320, viewFrameOrigin+60)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"活动详情";
    
    
    [self addBarButtonItem];
    
    [self homedown];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark request methods
-(void)homedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:Getxiangqing];
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
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSDictionary *detailDic = [dic objectForKey:@"appNewActivityVo"];
            self.titleLabel.text=[detailDic objectForKey:@"title"];
            self.addressLabel.text=[detailDic objectForKey:@"address"];
            self.timeLabel.text=[detailDic objectForKey:@"time"];
            self.telephoneLabel.text=[detailDic objectForKey:@"telephone"];
            idString = [detailDic objectForKey:@"id"];
            flagString = [detailDic objectForKey:@"flag"];
            shareFlagString = [detailDic objectForKey:@"shareflag"];

            NSLog(@"content---%@",[[dic objectForKey:@"appNewActivityVo"]objectForKey:@"content"]);
            labelHeight = [self heightForString:[[dic objectForKey:@"appNewActivityVo"]objectForKey:@"content"] font:[UIFont systemFontOfSize:17.0f] andWidth:contentLabelheight];
            contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, Originheight, contentLabelheight, labelHeight)];
            contentLabel.numberOfLines = 0;
            contentLabel.text = [[dic objectForKey:@"appNewActivityVo"]objectForKey:@"content"];
            [self.myNewScrollview addSubview:contentLabel];
            [self addBottomFenxiangView];

            NSString *actyStatus=[detailDic objectForKey:@"actyStatus"];
            if ([actyStatus isEqualToString:@"3"])
            {
//                self.IsStartImage.image = [UIImage imageNamed:@"已结束.png"];
                
                if ([shareFlagString isEqualToString:@"0"]) {
                    //未参加
                    bottomView.fenxiangBtn.hidden=NO;
                    bottomView.fenxiangImage.hidden=NO;
                    [bottomView.fenxiangBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }else if ([shareFlagString isEqualToString:@"1"])
                {
                    bottomView.canjiaBtn.hidden=NO;
                    bottomView.canjiaImage.hidden=NO;
                    bottomView.taolunBtn.hidden=NO;
                    bottomView.taolunImage.hidden=NO;
                    
                    bottomView.canjiaImage.image = [UIImage imageNamed:@"分享.png"];
                    [bottomView.canjiaBtn setTitle:@"分享" forState:UIControlStateNormal];
                    bottomView.taolunImage.image = [UIImage imageNamed:@"讨论.png"];
                    [bottomView.taolunBtn setTitle:@"参与讨论" forState:UIControlStateNormal];
                    urlString = CancelJoinActivity;
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(fenxiangBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    [bottomView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                }
            }
            else if ([actyStatus isEqualToString:@"2"])
            {
//                self.IsStartImage.image = [UIImage imageNamed:@"进行中.png"];
                
                if ([shareFlagString isEqualToString:@"0"]) {
                    //未参加
                    bottomView.fenxiangBtn.hidden=NO;
                    bottomView.fenxiangImage.hidden=NO;
                    [bottomView.fenxiangBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }else if ([shareFlagString isEqualToString:@"1"])
                {
                    bottomView.canjiaImage.hidden=NO;
                    bottomView.canjiaBtn.hidden=NO;
                    bottomView.taolunImage.hidden=NO;
                    bottomView.taolunBtn.hidden=NO;
                    
                    bottomView.canjiaImage.image = [UIImage imageNamed:@"分享.png"];
                    [bottomView.canjiaBtn setTitle:@"分享" forState:UIControlStateNormal];
                    bottomView.taolunImage.image = [UIImage imageNamed:@"讨论.png"];
                    [bottomView.taolunBtn setTitle:@"参与讨论" forState:UIControlStateNormal];
                    urlString = CancelJoinActivity;
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(fenxiangBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    [bottomView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                }
                
            }
            else{
                //self.IsStartImage.image = [UIImage imageNamed:@"未开始.png"];
                bottomView.canjiaBtn.hidden=NO;
                bottomView.canjiaImage.hidden=NO;
                bottomView.taolunBtn.hidden=NO;
                bottomView.taolunImage.hidden=NO;
                
                [bottomView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                if ([flagString isEqualToString:@"1"]) {
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(canjiaBtnClick) forControlEvents:UIControlEventTouchUpInside];
                }else if ([flagString isEqualToString:@"2"])
                {
                    bottomView.canjiaImage.image = [UIImage imageNamed:@"取消参加.png"];
                    [bottomView.canjiaBtn setTitle:@"取消参加" forState:UIControlStateNormal]; //buCanjiaBtnClick
                    urlString = CancelJoinActivity;
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(buCanjiaBtnClick) forControlEvents:UIControlEventTouchUpInside];
                }else if ([flagString isEqualToString:@"3"])
                {
                    bottomView.hidden = YES;
                    [self addaTabarView];
                    [tabarView.fenxiangBtn addTarget:self action:@selector(bianjiBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                    urlString = cancelPublish;
                    [tabarView.canjiaBtn addTarget:self action:@selector(buCanjiaBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                    [tabarView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
            }


        }
    }else if (request.tag==200)
    {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"恭喜你，成功了！"];

    }
    else if (request.tag==700)
    {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        
        if ([result isEqualToString:@"1"])
        {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"恭喜您成功了"];
            
            NSDictionary *aVoDic = [dic objectForKey:@"appNewActivityVo"];
            
            FaBuActivityViewController *JoinVC = [[FaBuActivityViewController alloc] init];
            JoinVC.fabuDic = aVoDic;
            
            [self.navigationController pushViewController:JoinVC animated:YES];
        }
    }

    
}

- (void)addaTabarView
{
    //1.新建MyView 2.新建Empty的Xib 3，拖入一个View --选中View修改Class为MyView --设置frame为freedom改变大小  --设置status为none去掉电池  --在使用处导入。h头文件  --- (void)viewDidLoad填写下面代码
    
    //此处 MyView 要改名字
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"TabartwoView" owner:self options:nil];
    tabarView = [array objectAtIndex:0];
    tabarView.backgroundColor = [UIColor whiteColor];
    //xib坐标一定要和此处一致，不然控件不响应
    
    CGFloat screenHeight =  [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"screenHeight===%f",screenHeight);
    NSLog(@"kScreenWidth===%f",kScreenWidth);
    
    if (screenHeight>481)
    {
        //需要继续优化
        tabarView.frame = CGRectMake(0, screenHeight-45, 320, 45);
    }else
    {
        
        tabarView.frame = CGRectMake(0, screenHeight-45, 320, 45);
        
    }
    [self.view addSubview:tabarView];
}
//编辑发布
- (void)bianjiBtnClick
{
    [self bianjiHomedown];
    
}
-(void)bianjiHomedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:getDetail2];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=700;
        request.delegate=self;
        [request startAsynchronous];
    }
}

#pragma mark-  ButtonClick
- (void)fenxiangBtnClick
{
    NSLog(@"点击1");
    ShareActivityViewController *shareVC = [[ShareActivityViewController alloc] init];
    shareVC.idStr = self.idStr;
    [self.navigationController pushViewController:shareVC animated:YES];
}
- (void)canjiaBtnClick
{
    NSLog(@"点击2");
    JoinActViewController *JoinVC = [[JoinActViewController alloc] init];
    JoinVC.idStr = self.idStr;
    JoinVC.titleStr = @"我要参加";
    JoinVC.contentStr = @"一句话介绍自己情况";
    JoinVC.btnStr = @"我要参加";
    JoinVC.tag = 1;
    [self.navigationController pushViewController:JoinVC animated:YES];
    
}//
- (void)buCanjiaBtnClick
{
    [self cancleHomedown];
}
- (void)taolunBtnClick
{
    NSLog(@"点击3");
    JoinActViewController *JoinVC = [[JoinActViewController alloc] init];
    JoinVC.idStr = self.idStr;
    JoinVC.titleStr = @"参与讨论";
    JoinVC.contentStr = @"说出你要讨论的内容";
    JoinVC.btnStr = @"提交讨论";
    JoinVC.tag = 2;
    
    
    [self.navigationController pushViewController:JoinVC animated:YES];
    
}
-(void)cancleHomedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //取消发布
        NSURL *url = [NSURL URLWithString:urlString];
        NSLog(@"urlString====%@",urlString);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=200;
        request.delegate=self;
        [request startAsynchronous];
    }
    
    
}

//-(void)requestFailed:(ASIHTTPRequest *)request{
//    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络不给力啊"];
//    
//}
//-(void)requestFinished:(ASIHTTPRequest *)request{
//    if (request.tag==100) {
//        NSLog(@"OK!!");
//        NSLog(@"str==%@",request.responseString);
//        NSDictionary *dic=[request.responseData objectFromJSONData];
//        NSLog(@"%@",dic);
//        NSString *result=[dic objectForKey:@"result"];
//        if ([result isEqualToString:@"1"]) {
//        }
//    }
//}

#pragma mark- 添加自定义 Tabar
- (void)addBottomFenxiangView
{

    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"BottomBtnView" owner:self options:nil];
    bottomView = [array objectAtIndex:0];
    bottomView.backgroundColor = [UIColor whiteColor];
    //xib坐标一定要和此处一致，不然控件不响应
    
    CGFloat screenHeight =  [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"screenHeight===%f",screenHeight);
    NSLog(@"kScreenWidth===%f",kScreenWidth);
    
    if (screenHeight>481)
    {
        //需要继续优化
        bottomView.frame = CGRectMake(0, screenHeight-45, 320, 45);
    }else
    {
        
        bottomView.frame = CGRectMake(0, screenHeight-45, 320, 45);
        
    }
    [self.view addSubview:bottomView];


}
#pragma mark- 计算字符串高度
-(float) heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
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
    [self.navigationController popViewControllerAnimated:YES];
}
//#pragma mark-  ButtonClick
//- (void)fenxiangClick
//{
//    NSLog(@"点击分享1");
//    ShareActivityViewController *shareVC = [[ShareActivityViewController alloc] init];
//    shareVC.idStr = self.idStr;
//    [self.navigationController pushViewController:shareVC animated:YES];
//}
//- (void)canjiaClick
//{
//    NSLog(@"点击分享2");
//    JoinActViewController *JoinVC = [[JoinActViewController alloc] init];
//    JoinVC.idStr = self.idStr;
//    JoinVC.titleStr = @"我要参加";
//    JoinVC.contentStr = @"一句话介绍自己的情况";
//    JoinVC.btnStr = @"我要参加";
//    JoinVC.tag = 1;
//
//    [self.navigationController pushViewController:JoinVC animated:YES];
//
//}
//- (void)taolunClick
//{
//    NSLog(@"点击分享3");
//    JoinActViewController *JoinVC = [[JoinActViewController alloc] init];
//    JoinVC.idStr = self.idStr;
//    JoinVC.titleStr = @"参与讨论";
//    JoinVC.contentStr = @"说出你要讨论的内容";
//    JoinVC.btnStr = @"提交讨论";
//    JoinVC.tag = 2;
//
//    [self.navigationController pushViewController:JoinVC animated:YES];
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
