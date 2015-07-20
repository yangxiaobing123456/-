//
//  GZBGController.m
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "GZBGController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           40
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

static UIImage *bgImage = nil;

@implementation GZBGCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"cell_bg_green_80H"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, CellHeight)];
        bgView.image = bgImage;
        [self.contentView addSubview:bgView];
        
        yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(22.0f, 5.0f, 40.0f, 20.0f)];
        yearLabel.textColor = [UIColor whiteColor];
        yearLabel.backgroundColor = [UIColor clearColor];
        yearLabel.font = [UIFont systemFontOfSize:16.0f];
        yearLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:yearLabel];
        
        monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(22.0f, 25.0f, 50.0f, 12.0f)];
        monthLabel.textColor = [UIColor whiteColor];
        monthLabel.backgroundColor = [UIColor clearColor];
        monthLabel.font = [UIFont systemFontOfSize:12.0f];
        monthLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:monthLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0f, 0.0f, 185.0f, CellHeight)];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)loadWorkReport:(WorkReportInfo *)info
{
    NSArray *array = [info.publishTime componentsSeparatedByString:@"-"];
    yearLabel.text = [NSString stringWithFormat:@"%@", array[0]];
    monthLabel.text = [NSString stringWithFormat:@"第%@月份", array[1]];
    titleLabel.text = info.title;
}

@end

@implementation GZBGController

- (id)init
{
    self = [super init];
    if (self) {
        reportArray = [NSMutableArray new];
        loadMore = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
    [headerView addSubview:titleBgView];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
    iconView.image = [UIImage imageNamed:@"gzbg"];
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
    [self refreshWorkReports];
}

- (void)loadDBData
{
    [reportArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryWorkReports:[AppSetting communityId]];
    [reportArray addObjectsFromArray:array];
    [self reloadTableView];
}

- (void)reloadTableView
{
    [reportArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        WorkReportInfo* t1 = (WorkReportInfo*)obj1;
        WorkReportInfo* t2 = (WorkReportInfo*)obj2;
        if(t1.updateTime <= t2.updateTime) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    [tableView reloadData];
}

- (void)refreshWorkReports
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (reportArray.count != 0) {
        WorkReportInfo *info = reportArray[0];
        time = info.updateTime;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"id",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getWorkReportWithDict:dict
                                                     complete:^(BOOL success, GetWorkReportResponse *resp) {
                                                    if (success && resp.result == RESPONSE_SUCCESS) {
                                                        for (WorkReportInfo *info in resp.list) {
                                                            info.html = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.html];
                                                            [[CommunityDbManager sharedInstance] insertOrUpdateWorkReport:info];
                                                        }
                                                        if (resp.all == 1) {
                                                            loadMore = NO;
                                                        }
                                                        [self loadDBData];
                                                    } else {
                                                        loadMore = NO;
                                                        [self loadDBData];
                                                    }
                                                    [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                }];
}

//加载更多
- (void)loadMoreWorkReports
{
    WorkReportInfo *info = (WorkReportInfo *)[reportArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"id",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          @"0", @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getWorkReportWithDict:dict
                                                     complete:^(BOOL success, GetWorkReportResponse *resp) {
                                                         if (success && resp.result == RESPONSE_SUCCESS) {
                                                             for (WorkReportInfo *info in resp.list) {
                                                                 if (info.type == 1) {
                                                                     [reportArray addObject:info];
                                                                 }
                                                             }
                                                             if (resp.all == 1) {
                                                                 loadMore = NO;
                                                             }
                                                             [self reloadTableView];
                                                         } else {
                                                             loadMore = NO;
                                                             [self reloadTableView];
                                                         }
                                                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (loadMore) {
        return [reportArray count] + 1;
    }
    return reportArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == reportArray.count && loadMore) {
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
        static NSString *CellIdentifier = @"report_cell";
        GZBGCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[GZBGCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell loadWorkReport:[reportArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == reportArray.count) {
        return LoadMoreCellHeight;
    }
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == reportArray.count) {
        return;
    }
    
    WorkReportInfo *report = [reportArray objectAtIndex:indexPath.row];
    WebViewController *controller = [[WebViewController alloc] initWithURL:[NSURL URLWithString:report.html] title:report.title];
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
        [self loadMoreWorkReports];
    }
}

@end
