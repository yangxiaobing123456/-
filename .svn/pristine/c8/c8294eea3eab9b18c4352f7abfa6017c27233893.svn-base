//
//  KilllistViewController.m
//  Community
//
//  Created by HuaMen on 15-1-5.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "KilllistViewController.h"
#import "personWalletCell.h"

@interface KilllistViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArr;
    CommunityTableView *tableView;
    UIImageView *headerbg;
    UILabel *headerLabel;
    
}

@end

@implementation KilllistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr=[[NSMutableArray alloc]init];
    NSLog(@"_tel==%@",_telArr);
    float headerViewH = 140.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, headerViewH + TopMargin)];
    headerView.backgroundColor = [UIColor clearColor];
    if ([_isSuccess isEqualToString:@"fail"]) {
        headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(120, TopMargin, kContentWidth - 2 * 100, 100)];
        headerbg.image = [UIImage imageNamed:@"秒杀失败"];
        [headerView addSubview:headerbg];
        headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TopMargin+100, kContentWidth, 40)];
        headerLabel.text =@"今天您的运气差了一点,请继续关注益社区，我们会有更多惊喜活动等您来拿";
        headerLabel.textAlignment=NSTextAlignmentCenter;
        headerLabel.numberOfLines=0;
        headerLabel.lineBreakMode=NSLineBreakByCharWrapping;
        headerLabel.font=[UIFont fontWithName:@"Arial" size:12];
        [headerView addSubview:headerLabel];
    }if ([_isSuccess isEqualToString:@"ok"]) {
        headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(120, TopMargin, kContentWidth - 2 * 100, 100)];
        headerbg.image = [UIImage imageNamed:@"秒杀成功"];
        [headerView addSubview:headerbg];
        headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TopMargin+100, kContentWidth, 40)];
        headerLabel.text =@"喜大普奔，人品爆发，恭喜益主人，奖品归您啦。小益会在三天与您联系，请耐心等待。若有疑问，可致电4008110416咨询";
        headerLabel.textAlignment=NSTextAlignmentCenter;
        headerLabel.numberOfLines=0;
        headerLabel.lineBreakMode=NSLineBreakByCharWrapping;
        headerLabel.font=[UIFont fontWithName:@"Arial" size:12];
        [headerView addSubview:headerLabel];
    }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    if (![_isSuccess isEqualToString:@"had"]) {
        [tableView setTableHeaderView:headerView];
    }
    
    //    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
//     [self showList];
    [self showGoodsList];
    
    [self customBackButton:self];

}
-(void)showGoodsList{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"secKillId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:getSecKillFiveGoods];
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
-(void)showList{
    [[CommunityIndicator sharedInstance] startLoading];
    sleep(5);
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"secKillId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:getKillResult];
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
    [[CommunityIndicator sharedInstance]hideIndicator:YES];
    [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"服务器挂了sorry!"];

    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSDictionary *killResult=[dic objectForKey:@"killResult"];
            if ([[killResult objectForKey:@"flag"]isEqualToString:@"1"]) {
                [[CommunityIndicator sharedInstance]hideIndicator:YES];
                [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"恭喜您秒杀成功"];
                [headerbg setImage:[UIImage imageNamed:@"秒杀成功"]];
                [headerLabel setText:[NSString stringWithFormat:@"喜大普奔，人品爆发，恭喜益主人，奖品归您啦。小益会在三天与您联系，请耐心等待。若有疑问，可致电4008110416咨询"]];
                dataArr=[[dic objectForKey:@"killResult"]objectForKey:@"awardList"];
                [tableView reloadData];
                
            }
            if ([[killResult objectForKey:@"flag"]isEqualToString:@"2"]) {
                [[CommunityIndicator sharedInstance]hideIndicator:YES];
                [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"对不起秒杀失败了"];
                dataArr=[[dic objectForKey:@"killResult"]objectForKey:@"awardList"];
                [tableView reloadData];
            }
            if ([[killResult objectForKey:@"flag"]isEqualToString:@"3"]) {
                [[CommunityIndicator sharedInstance]hideIndicator:YES];
                [self showList];
            }
        }
       else{
//             [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"对不起秒杀失败"];
           
        }
    }else{
//        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"对不起秒杀失败了"];
        
    }
    if (request.tag==200) {
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            dataArr=[dic objectForKey:@"goodsNameList"];
            [tableView reloadData];
        }
        else{
//            [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"对不起秒杀失败"];
            
        }
    }else{
//        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"对不起秒杀失败了"];
        
    }

    
}
#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_telArr count];
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
    if ([dataArr count]>0) {
        cell.reson.text=[dataArr objectAtIndex:indexPath.row];
    }
    cell.time.text=[_telArr objectAtIndex:indexPath.row];

    
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
