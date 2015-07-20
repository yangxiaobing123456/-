//
//  XQTZController.m
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "XQTZController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

static UIImage *bgImage = nil;

@implementation XQTZCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"cell_bg_green_114H"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, 0.0f, TableViewWidth - 2 * CellLeftMargin, CellHeight)];
        bgView.image = bgImage;
        [self.contentView addSubview:bgView];
        
        noticeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 10.0f, 80.0f, 20.0f)];
        noticeTypeLabel.textColor = [UIColor whiteColor];
        noticeTypeLabel.backgroundColor = [UIColor clearColor];
        noticeTypeLabel.font = [UIFont systemFontOfSize:18.0f];
        noticeTypeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:noticeTypeLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 42.0f, 90.0f, 20.0f)];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:10.0f];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:timeLabel];
        
        noticeSummaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0f, 11.0f, 185.0f, 40.0f)];
        noticeSummaryLabel.textColor = [UIColor grayColor];
        noticeSummaryLabel.backgroundColor = [UIColor clearColor];
        noticeSummaryLabel.font = [UIFont systemFontOfSize:16.0f];
        noticeSummaryLabel.textAlignment = NSTextAlignmentLeft;
        noticeSummaryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        noticeSummaryLabel.numberOfLines = 0;
        [self.contentView addSubview:noticeSummaryLabel];
    }
    return self;
}

- (void)loadNotice:(NoticeInfo *)notice
{
    switch (notice.noticeType) {
        case JJTZ:
            noticeTypeLabel.text = @"紧急通知";
            break;
            
        case TZ:
            noticeTypeLabel.text = @"通  知";
            break;
            
        case WXTS:
            noticeTypeLabel.text = @"温馨提示";
            break;
            
        case GG:
            noticeTypeLabel.text = @"公  告";
            break;
            
        case ZX:
            noticeTypeLabel.text = @"资  讯";
            break;
            
        default:
            break;
    }
    noticeSummaryLabel.text = notice.summary;
    timeLabel.text = [NSString formatDateWithMillisecond:notice.updateTime];
}

@end

@implementation XQTZController

- (id)init
{
    self = [super init];
    if (self) {
        noticeArray = [NSMutableArray new];
        loadMore = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"--执行到--11");
    [super viewDidLoad];
	
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
    [headerView addSubview:titleBgView];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
    iconView.image = [UIImage imageNamed:@"xqtz"];
    [headerView addSubview:iconView];
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    CGRect rect = CGRectMake(LeftMargin, 0.0f, TableViewWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [tableView setTableHeaderView:headerView];
    [self.view addSubview:tableView];
    
    [self customBackButton:self];

    //先读取数据库缓存数据
    [self loadDBData];
    //读取旧数据后刷新数据

    [self refreshNotices];
 
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//读取数据库旧数据
- (void)loadDBData
{
    [noticeArray removeAllObjects];
    NSLog(@"--执行到--%lld",[AppSetting communityId]);

    NSArray *array = [[CommunityDbManager sharedInstance] queryNotices:[AppSetting communityId]];
    [noticeArray addObjectsFromArray:array];
    [tableView reloadData];
}

//刷新小区通知
- (void)refreshNotices
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (noticeArray.count != 0) {
        NoticeInfo *info = noticeArray[0];
        time = info.updateTime;
    }
    NSLog(@"communityId----%lld",[AppSetting communityId]);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getNoticesWithDict:dict
                                                  complete:^(BOOL success, GetNoticesResponse *resp) {
                                                      
                                                      if (success && resp.result == RESPONSE_SUCCESS) {
                                                          for (NoticeInfo *info in resp.list) {
                                                              info.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.picture];
                                                              [[CommunityDbManager sharedInstance] insertOrUpdateNotice:info];
                                                          }
                                                          if (resp.all == 1) {
                                                              loadMore = NO;
                                                          }
                                                          [self loadDBData];
                                                      }
                                                      [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                  }];
}


//-(void)refreshNotices{
//    [[CommunityIndicator sharedInstance] startLoading];
////    sleep(5);
//    long long time = 0;
//    if (noticeArray.count != 0)
//    {
//        NoticeInfo *info = noticeArray[0];
//        time = info.updateTime;
//    }
//
//        NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:
//                              [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
//                              [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
//                              [NSString stringWithFormat:@"%d", 0], @"before",
//                              [NSString stringWithFormat:@"%d", 20], @"count", nil];
//        NSLog(@"--执行111dict11到--%@",user);
//  
//    if ([NSJSONSerialization isValidJSONObject:user])
//    {
//        NSError *error;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
//        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
//        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
////        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetNoticesURL]];
//
//        NSURL *url = [NSURL URLWithString:kGetNoticesURL];
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
//        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
//        [request addRequestHeader:@"Accept" value:@"application/json"];
//        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
//        [request addRequestHeader:@"Authorization" value:str];
//        [request setRequestMethod:@"POST"];
//        [request setPostBody:tempJsonData];
//        request.tag=100;
//        request.delegate=self;
//        [request startAsynchronous];
//    }
//}
//-(void)requestFailed:(ASIHTTPRequest *)request{
//    [[CommunityIndicator sharedInstance]hideIndicator:YES];
//    [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"服务器挂了sorry!"];
//
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    [[CommunityIndicator sharedInstance] hideIndicator:YES];
//
//    if (request.tag==100)
//    {
//        NSLog(@"str==%@",request.responseString);
//        NSDictionary *dic=[request.responseData objectFromJSONData];
//        NSLog(@"dic--%@",dic);
//        NSArray *listArray = [dic objectForKey:@"list"];
//        
//        NSString *createTime = [[listArray objectAtIndex:7] objectForKey:@"createTime"];
//        NSLog(@"%@",createTime);
//    }
//
//
//}
//

//加载更多小区通知
- (void)loadMoreNotices
{
    NoticeInfo *info = (NoticeInfo *)[noticeArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          @"0", @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getNoticesWithDict:dict
                                                  complete:^(BOOL success, GetNoticesResponse *resp) {
                                        
                                                      if (success && resp.result == RESPONSE_SUCCESS) {
                                                          for (NoticeInfo *info in resp.list) {
                                                              if (info.type == 1) {
                                                                  [noticeArray addObject:info];
                                                                  info.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.picture];
                                                              }
                                                          }
                                                          if (resp.all == 1) {
                                                              loadMore = NO;
                                                          }
                                                          [tableView reloadData];
                                                      }
                                                  }];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (loadMore) {
        return [noticeArray count] + 1;
    }
    return [noticeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [noticeArray count]) {
        static NSString *CellIdentifier = @"load_more_cell";
        LoadMoreCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[LoadMoreCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        [cell startActivityView];
        return cell;
    } else {
        static NSString *CellIdentifier = @"notice_cell";
        XQTZCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[XQTZCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        [cell loadNotice:[noticeArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [noticeArray count]) {
        return LoadMoreCellHeight;
    }
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [noticeArray count]) {
        return;
    }
    NoticeInfo *notice = [noticeArray objectAtIndex:indexPath.row];
    XQTZ_DetailController *controller = [XQTZ_DetailController new];
    controller.notice = notice;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动到底部，自动加载更多数据
    float scrollContentHeight = scrollView.contentSize.height;
    float scrollHeight = scrollView.bounds.size.height;
    if (scrollView.contentOffset.y >= scrollContentHeight - scrollHeight - LoadMoreCellHeight &&
        loadMore) {
        [self loadMoreNotices];
    }
}

@end
