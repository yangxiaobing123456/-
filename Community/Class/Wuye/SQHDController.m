//
//  SQHDController.m
//  Community
//
//  Created by SYZ on 14-1-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "SQHDController.h"
#import "ImageUtil.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define CellLeftMargin       0
#define LoadMoreCellHeight   40


@implementation SQHDCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f, 93.0f, CellHeight)];
        imageView.image = [ImageUtil imageCenterWithImage:[UIImage imageNamed:@"default_loading"]
                                               targetSize:CGSizeMake(88.0f, CellHeight)
                                          backgroundColor:[UIColor colorWithHexValue:0xFFDBDCDC]];
        [self.contentView addSubview:imageView];
        
        activityTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0f, 1.0f, 185.0f, 60.0f)];
        activityTitleLabel.textColor = [UIColor grayColor];
        activityTitleLabel.backgroundColor = [UIColor clearColor];
        activityTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        activityTitleLabel.textAlignment = NSTextAlignmentLeft;
        activityTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        activityTitleLabel.numberOfLines = 3;
        [self.contentView addSubview:activityTitleLabel];
        
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 2.0f)];
        dividerView.backgroundColor = [UIColor grayColor];
        dividerView.alpha = 0.5f;
        [self.contentView addSubview:dividerView];
    }
    return self;
}

- (void)loadActivity:(ActivityInfo *)activity
{
    activityTitleLabel.text = activity.title;
    if ([activity.picture isEqualToString:kCommunityImageServer]) {
        return;
    }
    
    NSString *imgPath = [PathUtil pathOfImage:[NSString stringWithFormat:@"%lu", (unsigned long)[activity.picture hash]]];
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imgPath]) { // 图片文件不存在
        ImageDownloadingTask *task = [ImageDownloadingTask new];
        [task setImageUrl:activity.picture];
        [task setUserData:activity];
        [task setTargetFilePath:imgPath];
        [task setCompletionHandler:^(BOOL succeeded, ImageDownloadingTask *idt) {
            if(succeeded && idt != nil && [idt.userData isEqual:activity]){
                UIImage *tempImg = [UIImage imageWithData:[idt resultImageData]];
                [imageView setImage:tempImg];
            }
        }];
        [[ImageDownloader sharedInstance] download:task];
    } else { //图片存在
        NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
        [imageView setImage:[UIImage imageWithData:imgData]];
    }
}

@end

@implementation SQHDController

- (id)init
{
    self = [super init];
    if (self) {
        activityArray = [NSMutableArray new];
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
    iconView.image = [UIImage imageNamed:@"sqhd"];
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
    [self refreshActivities];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//读取数据库旧数据
- (void)loadDBData
{
    [activityArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryActivities:[AppSetting communityId]];
    [activityArray addObjectsFromArray:array];
    [tableView reloadData];
}

//刷新小区通知
- (void)refreshActivities
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (activityArray.count != 0) {
        ActivityInfo *info = activityArray[0];
        time = info.updateTime;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getActivitiesWithDict:dict
                                                     complete:^(BOOL success, GetActivitiesResponse *resp) {
                                                         if (success && resp.result == RESPONSE_SUCCESS) {
                                                             for (ActivityInfo *info in resp.list) {
                                                                 info.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.picture];
                                                                 [[CommunityDbManager sharedInstance] insertOrUpdateActivity:info];
                                                             }
                                                             if (resp.all == 1) {
                                                                 loadMore = NO;
                                                             }
                                                             [self loadDBData];
                                                         }
                                                         [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                     }];
}

//加载更多小区通知
- (void)loadMoreActivities
{
    ActivityInfo *info = (ActivityInfo *)[activityArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          @"0", @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getActivitiesWithDict:dict
                                                     complete:^(BOOL success, GetActivitiesResponse *resp) {
                                                         if (success && resp.result == RESPONSE_SUCCESS) {
                                                             for (ActivityInfo *info in resp.list) {
                                                                 if (info.type == 1) {
                                                                     info.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.picture];
                                                                     [activityArray addObject:info];
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
        return [activityArray count] + 1;
    }
    return [activityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [activityArray count]) {
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
        static NSString *CellIdentifier = @"activity_cell";
        SQHDCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[SQHDCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        [cell loadActivity:[activityArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [activityArray count]) {
        return LoadMoreCellHeight;
    }
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [activityArray count]) {
        return;
    }
    ActivityInfo *activity = [activityArray objectAtIndex:indexPath.row];
    SQHD_DetailController *controller = [SQHD_DetailController new];
    controller.activity = activity;
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
        [self loadMoreActivities];
    }
}

@end
