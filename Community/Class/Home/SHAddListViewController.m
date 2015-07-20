//
//  SHAddListViewController.m
//  Community
//
//  Created by HuaMen on 14-10-13.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "SHAddListViewController.h"
#import "SHADDTableViewCell.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

@interface SHAddListViewController ()
{
    int typeNum;
}

@end

@implementation SHAddListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    noticeArray=[[NSMutableArray alloc]init];
    [self downLoad];
    
    CGRect rect = CGRectMake(LeftMargin, 0.0f, TableViewWidth, kContentHeight);
    _tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];

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
        NSURL *url = [NSURL URLWithString:getuserAllAddress];
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
        noticeArray=[dic objectForKey:@"addressList"];
        [_tableView reloadData];
        
        
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
    SHADDTableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SHADDTableViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.nameLabel.text=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    cell.TelLabel.text=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"phone"];
    cell.addLabel.text=[[noticeArray objectAtIndex:indexPath.row]objectForKey:@"address"];
    
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == [noticeArray count]) {
    //        return LoadMoreCellHeight;
    //    }
    //    return CellHeight;
    return 98;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"name"],@"name",[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"phone"],@"phone",[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"address"],@"address",[[noticeArray objectAtIndex:indexPath.row] objectForKey:@"addressId"],@"addressId", nil];
    NSNotification *notice=[NSNotification notificationWithName:@"selectSHAddress" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [noticeArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
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
