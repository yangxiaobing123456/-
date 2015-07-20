//
//  selectSHaddViewController.m
//  Community
//
//  Created by HuaMen on 14-10-13.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "selectSHaddViewController.h"
#import "shouHuoAddViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

@interface selectSHaddViewController ()

@end

@implementation selectSHaddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    NSLog(@"%@          %@",_typeStr,_idStr);
    if ([_typeStr isEqualToString:@"sheng"]) {
        [self downLoad];
    }if ([_typeStr isEqualToString:@"shi"]) {
        [self downLoad1];
    }if ([_typeStr isEqualToString:@"qu"]) {
        [self downLoad2];
    }if ([_typeStr isEqualToString:@"jiedao"]) {
        [self downLoad3];
    }
    
    noticeArray=[[NSMutableArray alloc]init];
    
    CGRect rect = CGRectMake(LeftMargin, 0.0f, TableViewWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
        NSURL *url = [NSURL URLWithString:sheng];
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
-(void)downLoad1{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"ProvinceId" ,nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:shi];
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
-(void)downLoad2{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"cityId" ,nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:qu];
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
-(void)downLoad3{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"districtId" ,nil];
    NSLog(@"id===%@",_idStr);
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:jiedao];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=400;
        request.delegate=self;
        [request startAsynchronous];
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"faild===%@",request.error);
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            noticeArray=[dic objectForKey:@"province"];
            NSLog(@"arrr============%@",noticeArray);
            [tableView reloadData];
            
        }

    }
    if (request.tag==200) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            noticeArray=[dic objectForKey:@"city"];
            NSLog(@"arrr============%@",noticeArray);
            [tableView reloadData];
            
        }

    }
    if (request.tag==300) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            noticeArray=[dic objectForKey:@"district"];
            NSLog(@"arrr============%@",noticeArray);
            [tableView reloadData];
            
        }

    }
    if (request.tag==400) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            noticeArray=[dic objectForKey:@"steet"];
            NSLog(@"arrr============%@",noticeArray);
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
    
    static NSString *CellIdentifier = @"notice1_cell";
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == [noticeArray count]) {
    //        return LoadMoreCellHeight;
    //    }
    //    return CellHeight;
    return 50;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"name"],_typeStr,[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"id"],[NSString stringWithFormat:@"%@123",_typeStr], nil];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"id"] forKey:@"SHid"];
    NSNotification *notice=[NSNotification notificationWithName:@"selectSHDZ" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
