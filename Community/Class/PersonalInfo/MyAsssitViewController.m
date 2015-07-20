//
//  MyAsssitViewController.m
//  Community
//
//  Created by HuaMen on 14-12-1.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "MyAsssitViewController.h"
#import "myAssTableViewCell.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

@interface MyAsssitViewController ()

@end

@implementation MyAsssitViewController
- (id)init
{
    self = [super init];
    if (self) {
        taskArray = [[NSMutableArray alloc] init];
        _dataArr=[[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评价";
    [self request];
    
//    float headerViewH = 50.0f;
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, headerViewH + TopMargin)];
//    headerView.backgroundColor = [UIColor whiteColor];
    //    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, TopMargin, kContentWidth - 2 * CellLeftMargin, headerViewH)];
    //    headerbg.image = [UIImage imageNamed:@"icon14"];
    //    [headerView addSubview:headerbg];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85.0f, (headerViewH - 20.0f) / 2 + TopMargin, 200.0f, 20.0f)];
//    titleLabel.text = @"现有积分:60";
//    titleLabel.textColor = [UIColor grayColor];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.font = [UIFont systemFontOfSize:16.0f];
//    [headerView addSubview:titleLabel];
    
    //写一个空白的footerView,可以实现透过TabBar还能看到tableview的效果
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, kTabBarHeight + TopMargin)];
    CGRect rect = CGRectMake(0.0f, 30.0f, kContentWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    //    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [tableView setTableHeaderView:headerView];
    [tableView setTableFooterView:footerView];
    [self.view addSubview:tableView];
    
    segmentControl=[[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, kContentWidth - 2 * CellLeftMargin, 30)];
    [segmentControl insertSegmentWithTitle:@"已评价" atIndex:0 animated:YES];
    [segmentControl insertSegmentWithTitle:@"未评价" atIndex:1 animated:YES];
    [segmentControl setSelectedSegmentIndex:0];
    [segmentControl addTarget:self action:@selector(sw) forControlEvents:UIControlEventValueChanged];
    [segmentControl setTintColor:[UIColor orangeColor]];
    [self.view addSubview:segmentControl];
    
    [self customBackButton:self];
    
}

-(void)sw{
    [tableView reloadData];
    
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
        NSURL *url = [NSURL URLWithString:getcomplainsbyuserId];
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
    NSLog(@"%@",request.responseString);
    if (request.tag==100) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSArray *arr=[dic objectForKey:@"list"];
            for (int i=0; i<[arr count]; i++) {
                if ([[[arr objectAtIndex:i]objectForKey:@"type"]intValue]<7) {
                    [_dataArr addObject:[arr objectAtIndex:i]];
                    
                }
                if ([[[arr objectAtIndex:i]objectForKey:@"type"]intValue]>=7) {
                    [taskArray addObject:[arr objectAtIndex:i]];
                    
                }
            }
            [tableView reloadData];
            
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
            
        }
        
    }
    
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (segmentControl.selectedSegmentIndex==0) {
        return [taskArray count];
        
    }if (segmentControl.selectedSegmentIndex==1) {
        return [_dataArr count];
        
    }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cell";
    myAssTableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"myAssTableViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (segmentControl.selectedSegmentIndex==0) {
        if ([[[taskArray objectAtIndex:indexPath.row]objectForKey:@"iscomplain"]isEqualToString:@"1"]) {
            cell.baoxiuLabel.text=@"报修";
        }if ([[[taskArray objectAtIndex:indexPath.row]objectForKey:@"iscomplain"]isEqualToString:@"2"]) {
            cell.baoxiuLabel.text=@"投诉";
            cell.baoxiuLabel.textColor=[UIColor redColor];
            cell.baoxiu.image=[UIImage imageNamed:@"my_evaluate_item_complain_pic"];
        }

        cell.conentLabel.text=[[taskArray objectAtIndex:indexPath.row]objectForKey:@"count"];
        cell.TimeLabel.text=[[taskArray objectAtIndex:indexPath.row]objectForKey:@"time"];
        [cell.PingjiaLow setHidden:YES];
        [cell.PingjiaHigh setTitle:@"已评价" forState:UIControlStateNormal];
        cell.PingjiaHigh.backgroundColor=[UIColor greenColor];
        cell.PingjiaHigh.layer.masksToBounds=YES;
        cell.PingjiaHigh.layer.cornerRadius=10;
        
        
    }if (segmentControl.selectedSegmentIndex==1) {
        cell.conentLabel.text=[[_dataArr objectAtIndex:indexPath.row]objectForKey:@"count"];
        cell.TimeLabel.text=[[_dataArr objectAtIndex:indexPath.row]objectForKey:@"time"];
        [cell.PingjiaLow setHidden:NO];
        [cell.PingjiaHigh setTitle:@"未评价" forState:UIControlStateNormal];
        cell.PingjiaHigh.backgroundColor=[UIColor orangeColor];
        cell.PingjiaHigh.layer.masksToBounds=YES;
        cell.PingjiaHigh.layer.cornerRadius=10;
        
    }

    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == [noticeArray count]) {
    //        return LoadMoreCellHeight;
    //    }
    //    return CellHeight;
    return 95;
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
