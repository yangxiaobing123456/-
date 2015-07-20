//
//  detailTuanViewController.m
//  Community
//
//  Created by HuaMen on 14-10-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "detailTuanViewController.h"
#import "MyTuanGouTableViewCell.h"
#import "SubTuanGouViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40
@implementation MyTuanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bgView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 50)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:bgView];
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 25, 200, 15)];
        [titleLabel setText:@"南京捷豹XF"];
        [self.contentView addSubview:titleLabel];
        

        
        
        
        
        
    }
    return self;
}
@end

@interface detailTuanViewController ()

@end

@implementation detailTuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBackButton:self];
    // Do any additional setup after loading the view.
   
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    [self downLoad];
    
    noticeArray=[[NSMutableArray alloc]init];
    
    headImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 10.0f, TableViewWidth, 80)];
    [headImage setImage:[UIImage imageNamed:@"2益社区团购_03(1).png"]];
    [self.view addSubview:headImage];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 85.0f, TableViewWidth, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
    [headerView addSubview:titleBgView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    [label setText:@"    今日团购"];
    [label setTextColor:[UIColor orangeColor]];
    [headerView addSubview:label];
    [self.view addSubview:headerView];
    
    CGRect rect = CGRectMake(LeftMargin, 135.0f, TableViewWidth, kContentHeight-135-40);
    tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [tableView setTableHeaderView:headerView];
    [self.view addSubview:tableView];

}
#pragma mark httpRequest methods
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]init];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
//        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:KgetAllPerChace];
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
    NSLog(@"faild===%@",request.error);
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"OK!!");
    NSDictionary *dic=[request.responseData objectFromJSONData];
    NSLog(@"%@",dic);
    NSString *result=[dic objectForKey:@"result"];
    if ([result isEqualToString:@"1"]) {
        NSString *adImage=[dic objectForKey:@"pic"];
        [headImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,adImage]] placeholderImage:[UIImage imageNamed:@"2益社区团购_03(1).png"]];
        noticeArray=[dic objectForKey:@"purchaseList"];
        NSLog(@"arrr============%@",noticeArray);
        [tableView reloadData];
        
    }else{
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        
    }
    
    
}
#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [noticeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"notice_cell";
    MyTuanGouTableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTuanGouTableViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.titlelabel.text=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"goodsName"];
    cell.ContentLabel.text=[NSString stringWithFormat:@"%@元",[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"goodsPrice"]];
    cell.dingjinLabel.text=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"deposit"];
    NSString *str21=[NSString stringWithFormat:@"已参加:%@人",[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"participants"]];
    cell.priceLabel.text=str21;
    NSString *str=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"picture"];
    NSString *str1=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,str];
    [cell.titleImage setImageWithURL:[NSURL URLWithString:str1] placeholderImage:[UIImage imageNamed:@"2益社区团购_11.png"]];
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == [noticeArray count]) {
//        return LoadMoreCellHeight;
//    }
//    return CellHeight;
    return 80;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"groupBuyGoodsId"] forKey:@"goodsId"];
    SubTuanGouViewController *sv=[[SubTuanGouViewController alloc]init];
    sv.GoodID=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"groupBuyGoodsId"];
    sv.nameStr=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"goodsName"];
    sv.priceStr=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"goodsPrice"];
    sv.timeStr=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"activityTime"];
    sv.DJStr=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"deposit"];
    sv.imageUrlStr=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"picture"]];
    [self.navigationController pushViewController:sv animated:YES];
    
    
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
