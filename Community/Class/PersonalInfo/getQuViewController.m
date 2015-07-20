//
//  getQuViewController.m
//  Community
//
//  Created by HuaMen on 15-1-9.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "getQuViewController.h"
#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62

@interface getQuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    NSMutableArray *optionArray;
    NSMutableArray *Arr;
}

@end

@implementation getQuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    optionArray=[[NSMutableArray alloc]init];
    Arr=[[NSMutableArray alloc]init];
    CGRect rect = CGRectMake(LeftMargin, -5.0f, TableViewWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    [self homedown];

}
#pragma mark UITableViewDataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [optionArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[optionArray objectAtIndex:section]objectForKey:@"commList"]count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[optionArray objectAtIndex:section]objectForKey:@"initial"];
}
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"option_cell";
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text=[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"name"];
    

    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Community *c = [[Community alloc] init];
//    c.communityId=[[[[optionArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"id"]longLongValue];
    c.name=[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"name"];
    c.communityId=[[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"id"]longLongValue];
    c.cityId=[[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"cityId"]longLongValue];
    c.lon=[[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"lon"]doubleValue];
    c.lat=[[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"lat"]doubleValue];
    c.createTime=[[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"createTime"]longLongValue];
    c.updateTime=[[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"updateTime"]longLongValue];
    c.telephone=[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"telephone"];
    c.type=[[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"type"]intValue];
    NSLog(@"%lld",c.communityId);

    [_delegate selectCommunity:c];
    
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"name"],@"name",[[[[optionArray objectAtIndex:indexPath.section]objectForKey:@"commList"]objectAtIndex:indexPath.row]objectForKey:@"id"],@"id",c,@"c", nil];
//    NSNotification *notice=[NSNotification notificationWithName:@"refreshDanYuan" object:nil userInfo:dic];
//    [[NSNotificationCenter defaultCenter]postNotification:notice];
//    [self.navigationController popViewControllerAnimated:YES];

}
-(void)homedown{
    long long time = [[CommunityDbManager sharedInstance] queryCommunitysUpdateTimeMax:YES cityId:_parentId];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", _parentId], @"id",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          @"1000", @"count", nil];
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:kGetCommunitysURL];
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
        int result=[[dic objectForKey:@"result"]intValue];
        if (result==1) {
            optionArray=[dic objectForKey:@"list2"];
            Community *info = [[Community alloc] init];
            
            for (int i=0; i<[[dic objectForKey:@"list2"]count]; i++) {
                NSMutableArray *subArr=[[NSMutableArray alloc]init];
                for (int j=0; j<[[[dic objectForKey:@"list2"]objectAtIndex:i]count]; j++) {
                    
                    info.communityId =[[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"id"]longLongValue];
                    info.name =[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"name"];
                    info.cityId =[[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"cityId"]longLongValue];
                    info.address = [[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"address"];
                    info.lon =[[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"lon"]doubleValue];
                    info.lat = [[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"lat"]doubleValue];
                    info.createTime = [[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"createTime"]longLongValue];
                    info.updateTime = [[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"updateTime"]longLongValue];
                    info.telephone = [[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"telephone"];
                    info.type = [[[[dic objectForKey:@"list2"]objectAtIndex:i]objectForKey:@"id"]intValue];
                    [subArr addObject:info];
                
                }
                [Arr addObject:subArr];
               
            }
            
        }
    }
    NSLog(@"%@",optionArray);
    NSLog(@"%@",[[Arr objectAtIndex:0]objectAtIndex:1]);
    [tableView reloadData];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"refreshDanYuan"
                                                  object:nil];

    
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
