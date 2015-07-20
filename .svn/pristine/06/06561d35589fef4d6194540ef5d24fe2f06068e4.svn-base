//
//  personalWalletViewController.m
//  Community
//
//  Created by HuaMen on 14-12-1.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "personalWalletViewController.h"
#import "personWalletCell.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

@interface personalWalletViewController ()

@end

@implementation personalWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的益积分";
    [self request];
    
    float headerViewH = 70.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, headerViewH + TopMargin)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    headerView.layer.shadowColor = [UIColor blackColor].CGColor;
    headerView.layer.shadowOffset = CGSizeMake(4, 4);
    headerView.layer.shadowOpacity = 0.5;
    headerView.layer.shadowRadius = 2.0;
//    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, TopMargin, kContentWidth - 2 * CellLeftMargin, headerViewH)];
//    headerbg.image = [UIImage imageNamed:@"icon14"];
//    [headerView addSubview:headerbg];
    NSUserDefaults *d=[NSUserDefaults standardUserDefaults];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85.0f, (headerViewH - 20.0f) / 2 + TopMargin, 200.0f, 20.0f)];
    titleLabel.text =[NSString stringWithFormat:@"现有益积分:%@",[d objectForKey:@"personIntegral"]];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [headerView addSubview:titleLabel];
    UIImageView*titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(65.0f, (headerViewH - 20.0f) / 2 + TopMargin, 20.0f, 20.0f)];
    [titleImage setImage:[UIImage imageNamed:@"积分logo"]];
    [headerView addSubview:titleImage];
    
    //写一个空白的footerView,可以实现透过TabBar还能看到tableview的效果
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, kTabBarHeight + TopMargin)];
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:headerView];
    [tableView setTableFooterView:footerView];
    [self.view addSubview:tableView];
    
    [self customBackButton:self];

}
-(void)request{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
            //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
            NSURL *url = [NSURL URLWithString:getIntegralRecords];
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
    if (request.tag==100) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            _dataArr=[dic objectForKey:@"dataList"];
            NSLog(@"data==%@",_dataArr);
            [tableView reloadData];
           
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
            
        }
        
    }
    
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"notice__cell";
    personWalletCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"personWalletCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.reson.text=[[_dataArr objectAtIndex:indexPath.row]objectForKey:@"reason"];
    cell.time.text=[[_dataArr objectAtIndex:indexPath.row]objectForKey:@"createTime"];
    cell.money.text=[[_dataArr objectAtIndex:indexPath.row]objectForKey:@"money"];
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == [noticeArray count]) {
    //        return LoadMoreCellHeight;
    //    }
    //    return CellHeight;
    return 70;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
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
