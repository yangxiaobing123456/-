//
//  SHHY_OtherController.m
//  Community
//
//  Created by SYZ on 13-11-30.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "SHHY_OtherController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           57
#define LoadMoreCellHeight   40

static UIImage *bgImage = nil;
static UIImage *locationImage = nil;
static UIImage *positionImage = nil;

@implementation SHHY_OtherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"cell_bg_red_114H"];
        }
        if (!locationImage) {
            locationImage = [UIImage imageNamed:@"location"];
        }
        if (!positionImage) {
            positionImage = [UIImage imageNamed:@"position"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, CellHeight)];
        bgView.image = bgImage;
        [self.contentView addSubview:bgView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 60.0f, CellHeight)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:12.0f];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.numberOfLines = 3;
        [self.contentView addSubview:nameLabel];
        
        float positionViewW = 9.0f, positionViewH = 15.0f;
        positionView = [[UIImageView alloc] initWithFrame:CGRectMake(105.0f, (CellHeight - positionViewH) / 2, positionViewW, positionViewH)];
        positionView.image = positionImage;
        [self.contentView addSubview:positionView];
        
        locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(125.0f, 0.0f, 140.0f, CellHeight)];
        locationLabel.textColor = [UIColor grayColor];
        locationLabel.backgroundColor = [UIColor clearColor];
        locationLabel.font = [UIFont systemFontOfSize:12.0f];
        locationLabel.textAlignment = NSTextAlignmentLeft;
        locationLabel.numberOfLines = 0;
        [self.contentView addSubview:locationLabel];
        
        float imageW = 22.0f, imageH = 22.0f;
        locationView = [[UIImageView alloc] initWithFrame:CGRectMake(TableViewWidth - imageW - 15.0f, (CellHeight - imageH) / 2, imageW, imageH)];
        locationView.image = locationImage;
        [self.contentView addSubview:locationView];
    }
    return self;
}

- (void)loadYellowPage:(YellowPageInfo *)info
{
    nameLabel.text = info.name;
    locationLabel.text = info.address;
}

@end

@implementation SHHY_OtherController

- (id)init
{
    self = [super init];
    if (self) {
        infoArray = [NSMutableArray new];
        loadMore = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTitle];
    
    float headerViewH = 34.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, headerViewH)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, headerViewH)];
    headerbg.image = [UIImage imageNamed:@"bg_red_68H"];
    [headerView addSubview:headerbg];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
    iconView.image = iconImage;
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
    [tableView setTableHeaderView:headerView];
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
    
    //先读取数据库缓存数据
    [self loadDBData];
    //读取旧数据后刷新数据
    [self refreshYellowPages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTitle
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SHHY_List" ofType:@"txt"];
    NSArray *array = [EzJsonParser deserializeFromJson:[NSString stringWithContentsOfFile:path
                                                                                 encoding:NSUTF8StringEncoding error:nil]
                                                asType:[NSArray class]];
    for (NSDictionary *dict in array) {
        if ([[dict valueForKey:@"index"] intValue] == _sshyItem) {
            self.title = [dict valueForKey:@"function"];
            iconImage = [UIImage imageNamed:[dict valueForKey:@"imageName"]];
            break;
        }
    }
}

- (void)loadDBData
{
    [infoArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryYellowPages:[AppSetting communityId] pageType:_sshyItem];
    [infoArray addObjectsFromArray:array];
    [tableView reloadData];
}

- (void)refreshYellowPages
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (infoArray.count != 0) {
        YellowPageInfo *info = infoArray[0];
        time = info.updateTime;
    }
        
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%d", _sshyItem], @"pageType",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getYellowPagesWithDict:dict
                                                      complete:^(BOOL success, GetYellowPagesResponse *resp) {
                                                          if (success && resp.result == RESPONSE_SUCCESS) {
                                                              for (YellowPageInfo *info in resp.list) {
                                                                  info.communityId = [AppSetting communityId];
                                                                  info.pageType = _sshyItem;
                                                                  [[CommunityDbManager sharedInstance] insertOrUpdateYellowPage:info];
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
- (void)loadMoreYellowPages
{
    YellowPageInfo *info = (YellowPageInfo *)[infoArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%d", _sshyItem], @"pageType",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          @"0", @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getYellowPagesWithDict:dict
                                                      complete:^(BOOL success, GetYellowPagesResponse *resp) {
                                                          if (success && resp.result == RESPONSE_SUCCESS) {
                                                              for (YellowPageInfo *info in resp.list) {
                                                                  if (info.type == 1) {
                                                                      [infoArray addObject:info];
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
        return [infoArray count] + 1;
    }
    return [infoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == infoArray.count) {
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
        SHHY_OtherCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[SHHY_OtherCell alloc] initWithStyle:UITableViewCellStyleValue1
                                         reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        [cell loadYellowPage:[infoArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == infoArray.count) {
        return LoadMoreCellHeight;
    }
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == infoArray.count) {
        return;
    }
    YellowPageInfo *info = [infoArray objectAtIndex:indexPath.row];
    MapController *mapController = [[MapController alloc] initWithLat:info.lat lon:info.lon];
    mapController.telephone = info.telephone;
    [self.navigationController pushViewController:mapController animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动到底部，自动加载更多数据
    float scrollContentHeight = scrollView.contentSize.height;
    float scrollHeight = scrollView.bounds.size.height;
    if (scrollView.contentOffset.y >= scrollContentHeight - scrollHeight - LoadMoreCellHeight &&
        loadMore) {
        [self loadMoreYellowPages];
    }
}

@end
