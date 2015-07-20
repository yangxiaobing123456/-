//
//  MyActivityViewController.m
//  Community
//
//  Created by HuaMen on 15-3-2.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "MyActivityViewController.h"
#import "MJRefresh.h"
#import "ActivityCell.h"
//#import "ActivityDetailViewController.h"
#import "ActivityDetailSecondViewController.h"

#import "FaBuActivityViewController.h"
#import "ChooseController.h"

@interface MyActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    BOOL _reloading;
    NSMutableArray *dataArr;
    NSString *type;
    //我要发布
//    UIButton *FabuBtn;
    NSInteger pageSize;


}
@end

@implementation MyActivityViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeType:) name:@"selectActivityType" object:nil];
        
    }
    return self;
}
-(void)changeType:(NSNotification *)notice{
    NSLog(@"OK------");
    NSDictionary *dic=[notice userInfo];
    if (!dic||dic==nil) {
        return;
    }
    type=@"2";
    //我要发布
//    [FabuBtn setHidden:NO];
    [self homedown];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showOutput:) name:@"actyTypeNotification" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的活动";
    _imageNameArray = [NSArray arrayWithObjects:@"拼车1.png",@"拼旅游1.png",@"拼K歌1.png",@"拼商品1.png",@"拼健身1.png",@"拼广场舞1.png",@"拼宠物1.png",@"球类1.png",@"拼跑步1.png",@"拼棋牌1.png",@"拼吃货1.png",@"跳蚤市场1.png",@"其他1.png", nil];

    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    leftBarBtn.frame=CGRectMake(0, 0, 12, 20);
    leftBarBtn.tag = 101;
    [leftBarBtn addTarget:self action:@selector(rightBarBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    type=@"2";
    pageSize = 15;
    dataArr=[[NSMutableArray alloc]init];
    UISegmentedControl *seg = [[UISegmentedControl alloc] init];
    seg.frame = CGRectMake(-4, -1, 328, 49);
    [seg insertSegmentWithTitle:@"我参加的活动" atIndex:0 animated:YES];
    [seg insertSegmentWithTitle:@"我发布的活动" atIndex:1 animated:YES];
    
    [seg setSelectedSegmentIndex:1];
    [seg setTintColor:[UIColor orangeColor]];
    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    //隐藏黄线
    UILabel *lineLabely = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, 320, 1)];
    lineLabely.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineLabely];

    [self homedown];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, 320, self.view.bounds.size.height-94) style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    
    [self setRefreash];
    
}

#pragma mark--ButtonClick
- (void)rightBarBtnSelect:(UIButton *)btn
{
    if (btn.tag == 101)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 102)
    {
        NSLog(@"导航栏右侧执行方法");
        ChooseController *chooseVC = [[ChooseController alloc] init];
        [self.navigationController pushViewController:chooseVC animated:YES];
        
        
    }
}
    //我要发布

//-(void)btnClick
//{
//    FaBuActivityViewController *fv=[FaBuActivityViewController new];
//    [self.navigationController pushViewController:fv animated:YES];
//}
- (void)showOutput:(NSNotification *)notif
{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page",@"20",@"pageSize",type,@"type",[notif.object objectForKey:@"actyType"],@"actyType",[notif.object objectForKey:@"timeType"],@"timeType", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //22
        NSURL *url = [NSURL URLWithString:getCommActivity];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        //33
        //传参数 密码加密        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSString *str=[NSString stringWithFormat:@"%lld",[AppSetting userId]];
        
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
        
    }
    
    
}
#pragma mark--request
-(void)homedown{
    //@"",@"actyType",@"",@"timeType",
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page",[NSString stringWithFormat:@"%d",pageSize],@"pageSize",type,@"type",@"",@"actyType",@"",@"timeType", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //22
        NSURL *url = [NSURL URLWithString:getMyActivity];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        //  传参数 密码加密
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
//        NSString *str=[NSString stringWithFormat:@"%lld",[AppSetting userId]];
        
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
    if (request.tag==100)
    {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSString *result=[dic objectForKey:@"result"];
        
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSLog(@"dic==\n%@",dic);
        NSLog(@"result==%@",result);
        
        if ([result isEqualToString:@"1"]) {
            NSDictionary *d=[dic objectForKey:@"pageVo"];
            dataArr=[d objectForKey:@"dataList"];
            NSLog(@"dataArr=%@",dataArr);
            
            //多出需要刷表
            [tableView reloadData];
        }
    }
    
}

-(void)segChange:(UISegmentedControl *)seg{
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            type=@"1";
//            [FabuBtn setHidden:YES];
            
            [self homedown];
            
            break;
        case 1:
            type=@"2";
//            [FabuBtn setHidden:NO];
            [self homedown];
            break;
            
        default:
            break;
    }
}

//#warning 自动刷新(一进入程序就下拉刷新)
-(void)setRefreash{
    [tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    //#warning 自动刷新(一进入程序就下拉刷新)
    [tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    tableView.headerPullToRefreshText = @"下拉可以刷新了";
    tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    tableView.headerRefreshingText = @"正在帮你刷新中";
    
    tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tableView.footerRefreshingText = @"正在帮你加载中";
    
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [tableView headerEndRefreshing];
    
}

- (void)footerRereshing
{
    pageSize = pageSize + 30;
    [self homedown];
    [tableView headerEndRefreshing];

    
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ActivityCell";
    ActivityCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ActivityCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.row==0) {
        cell.headerbg.backgroundColor = [UIColor clearColor];
    }

    //头像解析
//    NSString *ImageStr=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"pic"];
//    NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
//    [cell.TitleImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_132"]];
    int actyTypeNum = [[[dataArr objectAtIndex:indexPath.row]objectForKey:@"actyType"] intValue];
    NSLog(@"actyTypeNum-=====%d",actyTypeNum);
    cell.TitleImage.image = [UIImage imageNamed:[_imageNameArray objectAtIndex:actyTypeNum-1]];

    cell.TitleLabel.text=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.timeLabel.text=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"time"];
    cell.addLabel.text=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"address"];
    cell.TelLabel.text = [NSString stringWithFormat:@"%@个邻居评论",[[dataArr objectAtIndex:indexPath.row]objectForKey:@"discussNum"]];
    cell.UserLabel.text = [NSString stringWithFormat:@"%@个邻居已参加（最少%@人）",[[dataArr objectAtIndex:indexPath.row]objectForKey:@"num"],[[dataArr objectAtIndex:indexPath.row]objectForKey:@"lowNum"]];
    NSString *actyStatus=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"actyStatus"];
    if ([actyStatus isEqualToString:@"3"])
    {
        cell.IsStartImage.image = [UIImage imageNamed:@"已结束.png"];
    }else if ([actyStatus isEqualToString:@"2"])
    {
        cell.IsStartImage.image = [UIImage imageNamed:@"进行中.png"];
        
    }else
    {
        cell.IsStartImage.image = [UIImage imageNamed:@"未开始.png"];
    }
    NSString *hot=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"hot"];
    NSString *free=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"free"];
    NSString *today=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"today"];
    NSString *price=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"price"];
    
    NSLog(@"hot==%@free==%@today==%@price==%@",hot,free,today,price);
    
    cell.hotBtn.hidden = YES;
    cell.freeBtn.hidden = YES;
    cell.todayBtn.hidden = YES;
    
    //%@元/人 标签自适应
    cell.hotBtn.backgroundColor = hongRGBA;
    cell.freeBtn.backgroundColor = lanRGBA;
    cell.todayBtn.backgroundColor = lvRGBA;
    
    NSString *moneyS = [NSString stringWithFormat:@"%@元/人",price];
    NSString *moneyLongS = [NSString stringWithFormat:@"%@元/人人",price];
    CGSize moneySize = [moneyLongS sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 19)];
    CGFloat moneyWide = moneySize.width;
    
    UILabel *hotLa = [[UILabel alloc] init];
    hotLa.textAlignment = NSTextAlignmentCenter;
    hotLa.text = @"热门";
    hotLa.font = [UIFont systemFontOfSize:12.0f];
    hotLa.layer.cornerRadius = 2;
    hotLa.backgroundColor = hongRGBA;
    [cell.contentView addSubview:hotLa];
    
    
    UILabel *moneyLa = [[UILabel alloc] init];
    moneyLa.textAlignment = NSTextAlignmentCenter;
    moneyLa.text = moneyS;
    moneyLa.font = [UIFont systemFontOfSize:12.0f];
    moneyLa.layer.cornerRadius = 2;
    moneyLa.layer.masksToBounds = YES;
    moneyLa.backgroundColor = qianRGBA;
    [cell.contentView addSubview:moneyLa];
    
    UILabel *todayLa = [[UILabel alloc] init];
    todayLa.textAlignment = NSTextAlignmentCenter;
    todayLa.text = @"今天";
    todayLa.font = [UIFont systemFontOfSize:12.0f];
    todayLa.layer.cornerRadius = 2;
    todayLa.backgroundColor = hongRGBA;
    [cell.contentView addSubview:todayLa];
    
    
    if ([hot isEqualToString:@"1"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        cell.hotBtn.hidden = NO;
        cell.freeBtn.hidden = NO;
        cell.todayBtn.hidden = NO;
        [cell.hotBtn setTitle:@"热门" forState:UIControlStateNormal];
        [cell.freeBtn setTitle:@"免费" forState:UIControlStateNormal];
        [cell.todayBtn setTitle:@"今天" forState:UIControlStateNormal];
        
    }else if ([hot isEqualToString:@"0"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        cell.hotBtn.hidden = NO;
        cell.freeBtn.hidden = NO;
        cell.hotBtn.backgroundColor = lanRGBA;
        cell.freeBtn.backgroundColor = lvRGBA;
        [cell.hotBtn setTitle:@"免费" forState:UIControlStateNormal];
        [cell.freeBtn setTitle:@"今天" forState:UIControlStateNormal];
        
    }else if ([hot isEqualToString:@"1"]&&![price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        
        hotLa.frame = CGRectMake(126, 143, 40, 19);
        moneyLa.frame = CGRectMake(176, 143, moneyWide, 19);
        todayLa.frame = CGRectMake(186+moneyWide, 143, 40, 19);
        
        
    }else if ([hot isEqualToString:@"1"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"0"]) {
        cell.hotBtn.hidden = NO;
        cell.freeBtn.hidden = NO;
        [cell.hotBtn setTitle:@"热门" forState:UIControlStateNormal];
        [cell.freeBtn setTitle:@"免费" forState:UIControlStateNormal];
        
    }else if ([hot isEqualToString:@"0"]&&![price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        [cell.hotBtn setTitle:[NSString stringWithFormat:@"%@元/人",price] forState:UIControlStateNormal];
        [cell.freeBtn setTitle:@"今天" forState:UIControlStateNormal];
        
        moneyLa.frame = CGRectMake(126, 144, moneyWide, 19);
        todayLa.frame = CGRectMake(136+moneyWide, 143, 40, 19);
        
        
    }else if ([hot isEqualToString:@"1"]&&![price isEqualToString:@"0"]&&[today isEqualToString:@"0"]) {
        
        hotLa.frame = CGRectMake(126, 143, 40, 19);
        moneyLa.frame = CGRectMake(176, 143, moneyWide, 19);
        
    }else if ([hot isEqualToString:@"0"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"0"]) {
        cell.hotBtn.hidden = NO;
        cell.hotBtn.backgroundColor = lanRGBA;
        [cell.hotBtn setTitle:@"免费" forState:UIControlStateNormal];
        
    }else {
        
        moneyLa.frame = CGRectMake(126, 143, moneyWide, 19);
    }
    //%@元/人 标签自适应
    
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailSecondViewController *gv=[[ActivityDetailSecondViewController alloc]init];
    gv.idStr=[[dataArr objectAtIndex:indexPath.row]objectForKey:@"id"];
    gv.displayPhone = @"显示";

    [self.navigationController pushViewController:gv animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
