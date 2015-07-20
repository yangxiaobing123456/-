//
//  CWBGController.m
//  Community
//
//  Created by SYZ on 13-12-14.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CWBGController.h"
#import "CWBG_DetailController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           40
#define LoadMoreCellHeight   40

static UIImage *bgImage = nil;

@implementation CWBGCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        
        seasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(22.0f, 25.0f, 50.0f, 12.0f)];
        seasonLabel.textColor = [UIColor whiteColor];
        seasonLabel.backgroundColor = [UIColor clearColor];
        seasonLabel.font = [UIFont systemFontOfSize:12.0f];
        seasonLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:seasonLabel];
        
        noticeSummaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0f, 0.0f, 185.0f, CellHeight)];
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

- (void)loadFinanceReport:(FinanceReportInfo *)report
{
    noticeSummaryLabel.text = report.title;
    NSArray *array = [report.publishTime componentsSeparatedByString:@"-"];
    yearLabel.text = [NSString stringWithFormat:@"%@", array[0]];
    seasonLabel.text = [NSString stringWithFormat:@"第%@季度", array[1]];
}

@end

@implementation CWBGController

- (id)init
{
    self = [super init];
    if (self) {
        reportsArray = [NSMutableArray new];
        loadMore = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
    [headerView addSubview:titleBgView];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
    iconView.image = [UIImage imageNamed:@"cwbg"];
    [headerView addSubview:iconView];
    
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
    [self refreshFinanceReports];
}

- (void)loadDBData
{
    [reportsArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryFinanceReports:[AppSetting communityId]];
    [reportsArray addObjectsFromArray:array];
    [self reloadTableView];
}

- (void)reloadTableView
{
    [reportsArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FinanceReportInfo *t1 = (FinanceReportInfo *)obj1;
        FinanceReportInfo *t2 = (FinanceReportInfo *)obj2;
        if(t1.updateTime <= t2.updateTime) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    [tableView reloadData];
}

- (void)refreshFinanceReports
{
    long long time = 0;
    if (reportsArray.count != 0) {
        FinanceReportInfo *info = reportsArray[0];
        time = info.updateTime;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"id",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getFinanceReportWithDict:dict
                                                        complete:^(BOOL success, GetFinanceReportResponse *resp) {
                                                            if (success && resp.result == RESPONSE_SUCCESS) {
                                                                for (FinanceReportInfo *info in resp.list) {
                                                                    [[CommunityDbManager sharedInstance] insertOrUpdateFinanceReport:info];
                                                                }
                                                                if (resp.all == 1) {
                                                                    loadMore = NO;
                                                                }
                                                                [self loadDBData];
                                                            }
                                                            [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                        }];
}

//加载更多
- (void)loadMoreFinanceReports
{
    FinanceReportInfo *info = (FinanceReportInfo *)[reportsArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"id",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          @"0", @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getFinanceReportWithDict:dict
                                                        complete:^(BOOL success, GetFinanceReportResponse *resp) {
                                                         if (success && resp.result == RESPONSE_SUCCESS) {
                                                             for (FinanceReportInfo *info in resp.list) {
                                                                 if (info.type == 1) {
                                                                     [reportsArray addObject:info];
                                                                 }
                                                             }
                                                             if (resp.all == 1) {
                                                                 loadMore = NO;
                                                             }
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
        return [reportsArray count] + 1;
    }
    return reportsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == reportsArray.count) {
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
        CWBGCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[CWBGCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        [cell loadFinanceReport:[reportsArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == reportsArray.count) {
        return LoadMoreCellHeight;
    }
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == reportsArray.count) {
        return;
    }
    
    FinanceReportInfo *report = [reportsArray objectAtIndex:indexPath.row];
    CWBG_DetailController *controller = [CWBG_DetailController new];
    controller.report = report;
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
        [self loadMoreFinanceReports];
    }
}

@end
