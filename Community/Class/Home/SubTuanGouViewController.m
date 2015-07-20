//
//  SubTuanGouViewController.m
//  Community
//
//  Created by HuaMen on 14-10-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "SubTuanGouViewController.h"
#import "GoodsSureViewController.h"
#import "GoodAddViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40
#define CellHorizontalSpace  8
#define CellVerticalSpace    8
#define ViewWidth            304

@interface SubTuanGouViewController ()
{
    NSMutableArray *noticeArray;
}

@end

@implementation SubTuanGouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    noticeArray=[[NSMutableArray alloc]init];
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
    
    headImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, 80)];
    [headImage setImage:[UIImage imageNamed:@"3商品详情_02.png"]];
    [scrollView addSubview:headImage];
    
    UIImageView *priceImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 80.0f, TableViewWidth, 40)];
    [priceImage setImage:[UIImage imageNamed:@"cell_bg_green_114H.png"]];
    [scrollView addSubview:priceImage];
    
    priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    priceLabel.text=[NSString stringWithFormat:@"价格:%@",_priceStr];
    [priceLabel setTextColor:[UIColor whiteColor]];
    [priceImage addSubview:priceLabel];
    
    titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 130, TableViewWidth, 20)];
//    titlelabel.text=@"南京捷豹XF团购";
    [titlelabel setText:_nameStr];
    [titlelabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:titlelabel];
    
    UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 153, TableViewWidth, 0.5)];
    [lineview setBackgroundColor:[UIColor lightGrayColor]];
    [scrollView addSubview:lineview];
    
    distanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 158, TableViewWidth, 15+60)];
    [distanceLabel setTextColor:[UIColor whiteColor]];
//    [distanceLabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
    [distanceLabel setText:@"里程：0.6万公里"];
    [distanceLabel setNumberOfLines:0];
    [distanceLabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
    [scrollView addSubview:distanceLabel];
    
    webview=[[UIWebView alloc]initWithFrame:distanceLabel.frame];
    [scrollView addSubview:webview];
    
  

    
    
//    shangpaiLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 158+20, TableViewWidth, 15)];
//    [shangpaiLabel setTextColor:[UIColor whiteColor]];
//    [shangpaiLabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
//    [shangpaiLabel setText:@"上牌：2012年06月上牌"];
//    [scrollView addSubview:shangpaiLabel];
    
//    liangdianLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+10, 158+40, TableViewWidth, 15)];
//    [liangdianLabel setTextColor:[UIColor whiteColor]];
//    [liangdianLabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
////    [liangdianLabel setText:@"亮点：天窗|GPS导航|倒车影像|涡轮增压"];
//    [scrollView addSubview:liangdianLabel];
    
    UIImageView *wImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 225.0f, TableViewWidth, 40)];
    [wImage setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:wImage];
    
    UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 100, 14)];
    [l1 setText:@"团购须知"];
    [wImage addSubview:l1];
    
    
    needKnowLabel=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 270.0f, TableViewWidth, 60)];
    [needKnowLabel setTextColor:[UIColor whiteColor]];
    [needKnowLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [needKnowLabel setNumberOfLines:0];
    [needKnowLabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
//    [needKnowLabel setText:@"参加团购，必须注册成为易社区VIP；团购有效时间为2014念9月6日开始，9日结束。优惠不得与其他优惠重叠使用。团购时间为2014年9月6日结束参加团购，必须注册成为易社区VIP；团购有效时间为2014念9月6日开始，9日结束。优惠不得与其他优惠重叠使用。团购时间为2014年9月6日结束"];
    [scrollView addSubview:needKnowLabel];
    
    UIImageView *wImage1=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 340.0f, TableViewWidth, 40)];
    [wImage1 setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:wImage1];
    UILabel *l2=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 100, 14)];
    [l2 setText:@"联系我们"];
    [wImage1 addSubview:l2];
    
    
    
    needKnowLabel1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 380.0f, TableViewWidth, 60)];
    [needKnowLabel1 setTextColor:[UIColor whiteColor]];
    [needKnowLabel1 setLineBreakMode:NSLineBreakByCharWrapping];
    [needKnowLabel1 setNumberOfLines:0];
    [needKnowLabel1 setFont:[UIFont fontWithName:@"helvetica" size:11]];
//    [needKnowLabel1 setText:@"   咨询热线:  400-000000000\n   联系地址:  将军大道XX号\n   客服qq:  111111111;1111111\n   电子邮箱:  ysq@163.com"];
    [scrollView addSubview:needKnowLabel1];
    
    scrollView.contentSize = CGSizeMake(ViewWidth, 480);
    
    [self downLoad];
    

    UIImageView *greenImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, kNavContentHeight-50, self.view.bounds.size.width, 50)];
    [greenImage setBackgroundColor:[UIColor greenColor]];
    [greenImage setAlpha:0.5];
    [self.view addSubview:greenImage];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"马上抢" forState:UIControlStateNormal];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=5;
    [btn setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:239.0/255.0 blue:0.0/255.0 alpha:1]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, kNavContentHeight-40, 120, 20)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_GoodID,@"groupBuyGoodsId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:KgetDetailGoods];
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
        noticeArray=[dic objectForKey:@"detailsList"];
        NSLog(@"arrr============%@",noticeArray);
        [self setMessage];
        
    }
    
    
    
}
-(void)setMessage{
    
    NSString *str=[[noticeArray lastObject]objectForKey:@"infomation"];
    NSString *str1=   [[noticeArray lastObject]objectForKey:@"goodsName"];
    str1=[NSString stringWithFormat:@"%@",[[noticeArray lastObject]objectForKey:@"goodsName"]];
    NSString *telStr=[NSString stringWithFormat:@"%@",[[noticeArray lastObject]objectForKey:@"merTel"]];
    NSString *AddressStr=[NSString stringWithFormat:@"%@",[[noticeArray lastObject]objectForKey:@"merchantAddress"]];
    [needKnowLabel1 setText:[NSString stringWithFormat:@"%@",telStr]];
    [needKnowLabel setText:str];
    [headImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,[[noticeArray lastObject]objectForKey:@"merchantAddress"]]] placeholderImage:[UIImage imageNamed:@"3商品详情_02.png"]];
    [distanceLabel setText:[NSString stringWithFormat:@"%@",[[noticeArray lastObject]objectForKey:@"details"]]];
    [webview loadHTMLString:[NSString stringWithFormat:@"%@",[[noticeArray lastObject]objectForKey:@"details"]] baseURL:nil];
    
    
}

-(void)btnClick{
    GoodAddViewController *gv=[[GoodAddViewController alloc]init];
    gv.title=@"确认订单";
    gv.nameStr=_nameStr;
    gv.priceStr=_DJStr;
    gv.headImageStr=_imageUrlStr;
    gv.GoodID=_GoodID;
    gv.allStr=_priceStr;
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
