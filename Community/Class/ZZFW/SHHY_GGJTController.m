//
//  SHHZ_GGJTController.m
//  Community
//
//  Created by SYZ on 13-11-30.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "SHHY_GGJTController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define SectionHeight        57
#define CellHeight           220
#define InvalidSection       -1
#define StationLabelHeight   30
#define LoadMoreCellHeight   40

static UIImage *bgImage = nil;

@implementation SHHY_GGJTSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"cell_bg_red_114H"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.image = bgImage;
        [self addSubview:bgView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 90.0f, SectionHeight)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.numberOfLines = 3;
        [self addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 0.0f, 180.0f, SectionHeight)];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:16.0f];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.numberOfLines = 0;
        [self addSubview:timeLabel];
    }
    return self;
}

- (void)loadYellowPage:(YellowPageInfo *)info
{
    float textWidth = [info.name sizeWithFont:[UIFont boldSystemFontOfSize:24.0f]].width;
    if (textWidth > 80.0f) {
        nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    } else {
        nameLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    }
    nameLabel.text = info.name;
    timeLabel.text = [NSString stringWithFormat:@"营运时间: %@", info.serviceTime];
}

@end

static NSArray *segmentedArray = nil;

@implementation SHHY_GGJTCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexValue:0xFFEAEAEA];
        if (!segmentedArray) {
            segmentedArray = [[NSArray alloc]initWithObjects:@"上行", @"下行", nil];
        }
        segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
        segmentedControl.frame = CGRectMake(90.0f, 0.0f, TableViewWidth - 90.0f, StationLabelHeight);
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.tintColor = [UIColor colorWithHexValue:0xFFEAEAEA];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:segmentedControl];
        
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexValue:0xFFADADAD],UITextAttributeTextColor, [UIFont systemFontOfSize:14.0f], UITextAttributeFont, [UIColor clearColor],UITextAttributeTextShadowColor, nil];
        [segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexValue:0xFF565656],UITextAttributeTextColor, [UIFont systemFontOfSize:14.0f], UITextAttributeFont, [UIColor clearColor],UITextAttributeTextShadowColor, nil];
        [segmentedControl setTitleTextAttributes:dic2 forState:UIControlStateSelected];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, StationLabelHeight, TableViewWidth, CellHeight - StationLabelHeight)];
        scrollView.pagingEnabled = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:scrollView];
    }
    return self;
}

-(void)segmentAction:(UISegmentedControl *)seg
{
    NSInteger index = segmentedControl.selectedSegmentIndex;
    switch (index) {
        case 0:
            _yellowPageInfo.stations = [_yellowPageInfo.content componentsSeparatedByString:@"#"];
            break;
            
        case 1:
            _yellowPageInfo.stations = [_yellowPageInfo.content2 componentsSeparatedByString:@"#"];
            break;
    }
    
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    scrollView.contentOffset = CGPointZero;
    for (int i = 0; i < _yellowPageInfo.stations.count; i ++ ) {
        UILabel *stationLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, StationLabelHeight * i, scrollView.frame.size.width - 90.0f, StationLabelHeight)];
        stationLabel.backgroundColor = [UIColor clearColor];
        float textWidth = [_yellowPageInfo.stations[i] sizeWithFont:[UIFont boldSystemFontOfSize:16.0f]].width;
        if (textWidth > scrollView.frame.size.width - 100.0f) {
            stationLabel.font = [UIFont systemFontOfSize:12.0f];
            stationLabel.text = [NSString stringWithFormat:@"    %@", _yellowPageInfo.stations[i]];
        } else {
            stationLabel.font = [UIFont systemFontOfSize:16.0f];
            stationLabel.text = [NSString stringWithFormat:@"   %@", _yellowPageInfo.stations[i]];
        }
        if (i % 2 == 0) {
            stationLabel.backgroundColor = [UIColor colorWithHexValue:0xFFF4F6F5];
            stationLabel.textColor = [UIColor colorWithHexValue:0xFF565656];
        } else {
            stationLabel.backgroundColor = [UIColor colorWithHexValue:0xFFEAEAEA];
            stationLabel.textColor = [UIColor colorWithHexValue:0xFFADADAD];
        }
        
        if ([_yellowPageInfo.stations[i] isEqualToString:_yellowPageInfo.station]) {
            stationLabel.textColor = [UIColor colorWithHexValue:0xFFE95513];
        }
        [scrollView addSubview:stationLabel];
    }
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, StationLabelHeight * _yellowPageInfo.stations.count)];
}

- (void)setYellowPageInfo:(YellowPageInfo *)yellowPageInfo
{
    _yellowPageInfo = yellowPageInfo;
    segmentedControl.selectedSegmentIndex = 0;
    [self segmentAction:nil];
}

@end

@implementation SHHY_GGJTController

- (id)init
{
    self = [super init];
    if (self) {
        infoArray = [NSMutableArray new];
        selectSction = InvalidSection;
        loadMore = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"公共交通";
	
    float headerViewH = 44.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, headerViewH)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, TableViewWidth, headerViewH - 10.0f)];
    headerbg.image = [UIImage imageNamed:@"bg_red_68H"];
    [headerView addSubview:headerbg];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 14.0f, 28.0f, 28.0f)];
    iconView.image = [UIImage imageNamed:@"ggjt"];
    [headerView addSubview:iconView];
	
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    CGRect rect = CGRectMake(LeftMargin, -44.0f, TableViewWidth, kContentHeight);
    tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:headerView];
    tableView.contentInset = UIEdgeInsetsMake(44.0f, 0.0f, 0.0f, 0.0f);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44.0f, 0.0f, 0.0f, 0.0f);
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
    
    //先读取数据库缓存数据
    [self loadDBData];
    //读取旧数据后刷新数据
    [self refreshGGJT];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDBData
{
    [infoArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryYellowPages:[AppSetting communityId] pageType:2];
    [infoArray addObjectsFromArray:array];
    [tableView reloadData];
}

- (void)refreshGGJT
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (infoArray.count != 0) {
        YellowPageInfo *info = infoArray[0];
        time = info.updateTime;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%d", 2], @"pageType",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getYellowPagesWithDict:dict
                                                      complete:^(BOOL success, GetYellowPagesResponse *resp) {
                                                          if (success && resp.result == RESPONSE_SUCCESS) {
                                                              for (YellowPageInfo *info in resp.list) {
                                                                  info.communityId = [AppSetting communityId];
                                                                  info.pageType = 2;
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
- (void)loadMoreGGJT
{
    YellowPageInfo *info = (YellowPageInfo *)[infoArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%d", 2], @"pageType",
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (loadMore) {
        return [infoArray count] + 1;
    }
    return [infoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == selectSction || section == infoArray.count) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == infoArray.count) {
        return 0;
    }
    return SectionHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == infoArray.count) {
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
        static NSString *CellIdentifier = @"ggjt_cell";
        SHHY_GGJTCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[SHHY_GGJTCell alloc] initWithStyle:UITableViewCellStyleValue1
                                        reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorWithHexValue:0xFFEAEAEA];
        }
        YellowPageInfo *publicTransport = (YellowPageInfo *)[infoArray objectAtIndex:indexPath.section];
        [cell setYellowPageInfo:publicTransport];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SHHY_GGJTSectionView *view = [[SHHY_GGJTSectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, SectionHeight)];
    [view loadYellowPage:[infoArray objectAtIndex:section]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:view.bounds];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTag:section];
    [button addTarget:self action:@selector(expandCell:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == selectSction) {
        return CellHeight;
    } else if (indexPath.section == infoArray.count) {
        return LoadMoreCellHeight;
    }
    return 0;
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
        [self loadMoreGGJT];
    }
}

- (void)expandCell:(UIButton *)sender
{
    endSection = sender.tag;
    if (selectSction == InvalidSection) {
        expand = NO;
        selectSction = endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    } else{
        if (selectSction == endSection) {
            [self didSelectCellRowFirstDo:NO nextDo:NO];
        } else{
            [self didSelectCellRowFirstDo:NO nextDo:YES];
        }
    }
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    [tableView beginUpdates];
    
    expand = firstDoInsert;
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:selectSction];
    [rowToInsert addObject:indexPath];
    if (!expand) {
        selectSction = InvalidSection;
        [tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [tableView endUpdates];
    
    if (nextDoInsert) {
        selectSction = endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
