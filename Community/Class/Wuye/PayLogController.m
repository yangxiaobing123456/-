//
//  PayLogController.m
//  Community
//
//  Created by SYZ on 14-1-23.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "PayLogController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           40
#define CellLeftMargin       0
#define LoadMoreCellHeight   40

static UIImage *bgImage1 = nil;
static UIImage *bgImage2 = nil;
static UIImage *bgImage3 = nil;
static UIImage *iconImage1 = nil;
static UIImage *iconImage2 = nil;

@implementation PayLogCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage1) {
            bgImage1 = [UIImage imageNamed:@"cell_bg_green_80H"];
        }
        if (!bgImage2) {
            bgImage2 = [UIImage imageNamed:@"cell_bg_yellow_80H"];
        }
        if (!bgImage3) {
            bgImage3 = [UIImage imageNamed:@"cell_bg_red_80H"];
        }
        if (!iconImage1) {
            iconImage1 = [UIImage imageNamed:@"wy_pay_log"];
        }
        if (!iconImage2) {
            iconImage2 = [UIImage imageNamed:@"park_pay_log"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, 0.0f, TableViewWidth - 2 * CellLeftMargin, CellHeight)];
        [self.contentView addSubview:bgView];
        
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, (CellHeight - 21.0f) / 2, 22.0f, 21.0f)];
        [self.contentView addSubview:iconView];
        
        methodLabel = [[UILabel alloc] initWithFrame:CGRectMake(28.0f, 5.0f, 50.0f, 20.0f)];
        methodLabel.textColor = [UIColor whiteColor];
        methodLabel.backgroundColor = [UIColor clearColor];
        methodLabel.font = [UIFont systemFontOfSize:16.0f];
        methodLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:methodLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(28.0f, 25.0f, 50.0f, 15.0f)];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont systemFontOfSize:9.0f];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dateLabel];
        
        summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 0.0f, 145.0f, CellHeight)];
        summaryLabel.textColor = [UIColor grayColor];
        summaryLabel.backgroundColor = [UIColor clearColor];
        summaryLabel.font = [UIFont systemFontOfSize:16.0f];
        summaryLabel.textAlignment = NSTextAlignmentLeft;
        summaryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        summaryLabel.numberOfLines = 0;
        [self.contentView addSubview:summaryLabel];
        
        resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [resultButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        resultButton.frame = CGRectMake(240.0f, 6.0f, 57.0f, 28.0f);
        [self.contentView addSubview:resultButton];
    }
    return self;
}

- (void)loadPayLog:(PayLogInfo *)payLog
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:payLog.updateTime / 1000.f];
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"MM月dd日";
    dateLabel.text = [df stringFromDate:date];
    
    if (payLog.payMethod == 2) {
        methodLabel.text = @"支付宝";
    } else if (payLog.payMethod == 3) {
        methodLabel.text = @"银联";
    }
    if (payLog.productType == 1) {
        iconView.image = iconImage1;
        if (payLog.tradeStatus == 3) {
            resultButton.hidden = YES;
            bgView.image = bgImage1;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 200.0f, CellHeight);
            summaryLabel.textColor = [UIColor colorWithHexValue:0xFF86C433];
            summaryLabel.text = [NSString stringWithFormat:@"成功缴纳物业费%0.2f元", (double)payLog.pay / 100];
        } else if (payLog.tradeStatus == 2) {
            resultButton.hidden = NO;
            bgView.image = bgImage2;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 145.0f, CellHeight);
            summaryLabel.textColor = [UIColor orangeColor];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateNormal];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateHighlighted];
            [resultButton setTitle:@"正在处理" forState:UIControlStateNormal];
            summaryLabel.text = [NSString stringWithFormat:@"缴纳物业费%0.2f元",  (double)payLog.pay / 100];
            if ([summaryLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16.0f]].width > 145.0f) {
                summaryLabel.font = [UIFont systemFontOfSize:14.0f];
            }
        } else if (payLog.tradeStatus == 1) {
            resultButton.hidden = NO;
            bgView.image = bgImage3;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 145.0f, CellHeight);
            summaryLabel.textColor = [UIColor redColor];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_fail"] forState:UIControlStateNormal];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_fail"] forState:UIControlStateHighlighted];
            [resultButton setTitle:@"缴费失败" forState:UIControlStateNormal];
            summaryLabel.text = [NSString stringWithFormat:@"缴纳物业费%0.2f元失败",  (double)payLog.pay / 100];
            if ([summaryLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16.0f]].width > 145.0f) {
                summaryLabel.font = [UIFont systemFontOfSize:14.0f];
            }
        } else if (payLog.tradeStatus == 0) {
            resultButton.hidden = NO;
            bgView.image = bgImage2;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 145.0f, CellHeight);
            summaryLabel.textColor = [UIColor orangeColor];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateNormal];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateHighlighted];
            [resultButton setTitle:@"等待付款" forState:UIControlStateNormal];
            summaryLabel.text = [NSString stringWithFormat:@"缴纳物业费%0.2f元", (double)payLog.pay / 100];
            if ([summaryLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16.0f]].width > 145.0f) {
                summaryLabel.font = [UIFont systemFontOfSize:14.0f];
            }
        }
    } else if (payLog.productType == 2) {
        iconView.image = iconImage2;
        if (payLog.tradeStatus == 3) {
            resultButton.hidden = YES;
            bgView.image = bgImage1;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 200.0f, CellHeight);
            summaryLabel.textColor = [UIColor colorWithHexValue:0xFF86C433];
            summaryLabel.text = [NSString stringWithFormat:@"成功缴纳停车费%0.2f元", (double)payLog.pay / 100];
        } else if (payLog.tradeStatus == 2) {
            resultButton.hidden = NO;
            bgView.image = bgImage2;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 145.0f, CellHeight);
            summaryLabel.textColor = [UIColor orangeColor];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateNormal];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateHighlighted];
            [resultButton setTitle:@"正在处理" forState:UIControlStateNormal];
            summaryLabel.text = [NSString stringWithFormat:@"缴纳停车费%0.2f元", (double)payLog.pay / 100];
            if ([summaryLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16.0f]].width > 145.0f) {
                summaryLabel.font = [UIFont systemFontOfSize:14.0f];
            }
        } else if (payLog.tradeStatus == 1) {
            resultButton.hidden = NO;
            bgView.image = bgImage2;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 145.0f, CellHeight);
            summaryLabel.textColor = [UIColor redColor];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_fail"] forState:UIControlStateNormal];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_fail"] forState:UIControlStateHighlighted];
            [resultButton setTitle:@"缴费失败" forState:UIControlStateNormal];
            summaryLabel.text = [NSString stringWithFormat:@"缴纳停车费%0.2f元失败", (double)payLog.pay / 100];
            if ([summaryLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16.0f]].width > 145.0f) {
                summaryLabel.font = [UIFont systemFontOfSize:14.0f];
            }
        } else if (payLog.tradeStatus == 0) {
            resultButton.hidden = NO;
            bgView.image = bgImage3;
            summaryLabel.frame = CGRectMake(90.0f, 0.0f, 145.0f, CellHeight);
            summaryLabel.textColor = [UIColor orangeColor];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateNormal];
            [resultButton setBackgroundImage:[UIImage imageNamed:@"pay_verify"] forState:UIControlStateHighlighted];
            [resultButton setTitle:@"等待付款" forState:UIControlStateNormal];
            summaryLabel.text = [NSString stringWithFormat:@"缴纳停车费%0.2lld元", payLog.pay / 100];
            if ([summaryLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16.0f]].width > 145.0f) {
                summaryLabel.font = [UIFont systemFontOfSize:14.0f];
            }
        }
    }
}

@end

@implementation PayLogController

- (id)init
{
    self = [super init];
    if (self) {
        payLogArray = [NSMutableArray new];
        loadMore = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"我的缴费";
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
    [headerView addSubview:titleBgView];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
    iconView.image = [UIImage imageNamed:@"wyjf"];
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
    [self refreshPayLogs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//读取数据库旧数据
- (void)loadDBData
{
    [payLogArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryPayLogs];
    [payLogArray addObjectsFromArray:array];
    [tableView reloadData];
}

//刷新缴费记录
- (void)refreshPayLogs
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (payLogArray.count != 0) {
        PayLogInfo *info = payLogArray[0];
        time = info.updateTime;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getPayLogsWithDict:dict
                                                  complete:^(BOOL success, GetPayLogsResponse *resp) {
                                                      if (success && resp.result == RESPONSE_SUCCESS) {
                                                          for (PayLogInfo *info in resp.list) {
                                                              [[CommunityDbManager sharedInstance] insertOrUpdatePayLog:info];
                                                          }
                                                          [self loadDBData];
                                                      }
                                                      [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                  }];
}

//加载更多缴费记录
- (void)loadMorePayLogs
{
    PayLogInfo *info = (PayLogInfo *)[payLogArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          @"0", @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getPayLogsWithDict:dict
                                                  complete:^(BOOL success, GetPayLogsResponse *resp) {
                                                      if (success && resp.result == RESPONSE_SUCCESS) {
                                                          for (PayLogInfo *info in resp.list) {
                                                              [[CommunityDbManager sharedInstance] insertOrUpdatePayLog:info];
                                                              [payLogArray addObject:info];
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
        return [payLogArray count] + 1;
    }
    return [payLogArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [payLogArray count]) {
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
        static NSString *CellIdentifier = @"pay_log_cell";
        PayLogCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[PayLogCell alloc] initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        [cell loadPayLog:[payLogArray objectAtIndex:indexPath.row]];
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [payLogArray count]) {
        return LoadMoreCellHeight;
    }
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动到底部，自动加载更多数据
    float scrollContentHeight = scrollView.contentSize.height;
    float scrollHeight = scrollView.bounds.size.height;
    if (scrollView.contentOffset.y >= scrollContentHeight - scrollHeight - LoadMoreCellHeight &&
        loadMore) {
        [self loadMorePayLogs];
    }
}

@end
