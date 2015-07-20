//
//  peronDingDanViewController.m
//  Community
//
//  Created by HuaMen on 14-10-14.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "peronDingDanViewController.h"
#import "MyTuanGouTableViewCell.h"
#import "DDWKViewController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

@interface peronDingDanViewController ()
{
    UIImageView *noticeImage;
    UILabel *l;
}

@end

@implementation peronDingDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    self.title=@"我的订单";
    
    [self customBackButton:self];
    
    
    
    noticeArray=[[NSMutableArray alloc]init];
    
    noticeImage=[[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 120, 120)];
    noticeImage.image=[UIImage imageNamed:@"二胡卵子1"];
    [self.view addSubview:noticeImage];
    
    l=[[UILabel alloc]initWithFrame:CGRectMake(100, 275, 120, 20)];
    [l setText:@"请去别处逛逛"];
    [l setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:l];
    
    headImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 10.0f, TableViewWidth, 80)];
    [headImage setImage:[UIImage imageNamed:@"2益社区团购_03(1).png"]];
    [self.view addSubview:headImage];
    [self miaosha];
    
    
//    [self down];
    
    CGRect rect = CGRectMake(LeftMargin, 130.0f, TableViewWidth, kContentHeight);
    tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] init];
    seg.frame = CGRectMake(30, 95, 260, 30);
    [seg insertSegmentWithTitle:@"已付款" atIndex:0 animated:YES];
    [seg insertSegmentWithTitle:@"未付款" atIndex:1 animated:YES];
    [seg insertSegmentWithTitle:@"退款单" atIndex:2 animated:YES];
    [seg setSelectedSegmentIndex:0];
    [seg setTintColor:[UIColor orangeColor]];
    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];

    
}
-(void)segChange:(UISegmentedControl *)seg{
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:
//            [self down];
            break;
        case 1:
//            [self down1];
            break;
        case 2:
            //            [self down1];
            break;

            
            
        default:
            break;
    }
}
-(void)down{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:@"-1",@"isWaitForFee",[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:showDingDan];
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
-(void)miaosha{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"page",@"20",@"pageSize", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:秒杀];
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
-(void)down1{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"isWaitForFee",[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:showDingDan];
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
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"faild===%@",request.error);
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
//        [noticeArray removeAllObjects];
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            
            noticeArray=[dic objectForKey:@"orderList"];
            [tableView reloadData];

            
        }

    }if (request.tag==200) {
        NSLog(@"OK!!");
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
//        [noticeArray removeAllObjects];
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            
            noticeArray=[dic objectForKey:@"orderList"];
            [tableView reloadData];
            
        }

    }if (request.tag==300) {
        NSLog(@"OK!!");
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        //        [noticeArray removeAllObjects];
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSDictionary *pageVo=[dic objectForKey:@"pageVo"];
            noticeArray=[pageVo objectForKey:@"dataList"];
            NSLog(@"arr====%@",[pageVo objectForKey:@"dataList"]);
            if ([noticeArray count]!=0) {
                [noticeImage setHidden:YES];
                [l setHidden:YES];
                
                
            }
            [tableView reloadData];
        }
        
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

//    cell.dingjinLabel.text=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"deposit"];
    NSString *str=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"goodsPic"];
    NSString *str1=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,str];
    [cell.titleImage setImageWithURL:[NSURL URLWithString:str1] placeholderImage:[UIImage imageNamed:@"2益社区团购_11.png"]];
    
    
    return cell;
}
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
////        [noticeArray removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source.
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}
//
//#pragma mark UITableViewDelegate methods
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    if (indexPath.row == [noticeArray count]) {
//    //        return LoadMoreCellHeight;
//    //    }
//    //    return CellHeight;
//    return 80;
//}
//
//- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    if ([[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"orderStatus"]intValue]==1) {
////        DDWKViewController *dv=[[DDWKViewController alloc]init];
////        dv.depositStr=[[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"deposit"]stringValue];
////        dv.groupPrice=[[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"groupPrice"]stringValue];
////        dv.goodsName=[[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"goodsName"]stringValue];
////        dv.orderId=[[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"orderId"]stringValue];
////        dv.pictureStr=[[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"picture"]stringValue];
////        [self.navigationController pushViewController:dv animated:YES];
////    }
//    DDWKViewController *dv=[[DDWKViewController alloc]init];
//    dv.depositStr=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"deposit"];
//    dv.groupPrice=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"groupPrice"];
//    dv.goodsName=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"goodsName"];
//    dv.orderId=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"orderId"];
//    dv.pictureStr=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"picture"];
//    dv.groupBuyGoodsId=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"groupBuyGoodsId"];
//    [self.navigationController pushViewController:dv animated:YES];
//    
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
