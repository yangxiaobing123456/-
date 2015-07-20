//
//  SHHY_ZWXXController.m
//  Community
//
//  Created by SYZ on 13-11-30.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "SHHY_ZWXXController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define SectionHeight        57
#define CellHeight           150
#define InvalidSection       -1
#define StationLabelHeight   30
#define LoadMoreCellHeight   40

static UIImage *bgImage = nil;
static UIImage *positionImage = nil;

@implementation SHHY_ZWXXSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"cell_bg_red_114H"];
        }
        if (!positionImage) {
            positionImage = [UIImage imageNamed:@"position"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.image = bgImage;
        [self addSubview:bgView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 65.0f, SectionHeight)];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:12.0f];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.numberOfLines = 3;
        [self addSubview:nameLabel];
        
        float positionViewW = 9.0f, positionViewH = 15.0f;
        positionView = [[UIImageView alloc] initWithFrame:CGRectMake(105.0f, (SectionHeight - positionViewH) / 2, positionViewW, positionViewH)];
        positionView.image = positionImage;
        [self addSubview:positionView];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(125.0f, 0.0f, 155.0f, SectionHeight)];
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.font = [UIFont systemFontOfSize:12.0f];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.numberOfLines = 0;
        [self addSubview:addressLabel];
    }
    return self;
}

- (void)loadYellowPage:(YellowPageInfo *)info
{
    nameLabel.text = info.name;
    addressLabel.text = info.address;
}

@end

static UIImage *locationImage = nil;

@implementation SHHY_ZWXXCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!locationImage) {
            locationImage = [UIImage imageNamed:@"location"];
        }
        self.contentView.backgroundColor = [UIColor colorWithHexValue:0xFFEAEAEA];
        
        textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 284.0f, CellHeight - 50.0f)];
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor colorWithHexValue:0xFFADADAD];
        textView.editable = NO;
        textView.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:textView];
        
        float buttonW = 22.0f, buttonH = 22.0f;
        UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        locationButton.frame = CGRectMake(TableViewWidth - buttonW - 20.0f, CellHeight - buttonH - 10.0f, buttonW, buttonH);
        [locationButton setBackgroundImage:locationImage forState:UIControlStateNormal];
        [locationButton addTarget:self action:@selector(openMap) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:locationButton];
    }
    return self;
}

- (void)loadData:(NSString *)string
{
    textView.text = string;
}

- (void)openMap
{
    id object = [self nextResponder];
    while (![object isKindOfClass:[SHHY_ZWXXController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    if ([object isKindOfClass:[SHHY_ZWXXController class]]) {
        [((SHHY_ZWXXController*)object) openMap];
    }
}

@end

@implementation SHHY_ZWXXController

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
	
    self.title = @"政务信息";
    
    float headerViewH = 34.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, headerViewH)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, headerViewH)];
    headerbg.image = [UIImage imageNamed:@"bg_red_68H"];
    [headerView addSubview:headerbg];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
    iconView.image = [UIImage imageNamed:@"zwxx"];
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
    [self refreshZWXX];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDBData
{
    [infoArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryYellowPages:[AppSetting communityId] pageType:1];
    [infoArray addObjectsFromArray:array];
    [tableView reloadData];
}

- (void)refreshZWXX
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (infoArray.count != 0) {
        YellowPageInfo *info = infoArray[0];
        time = info.updateTime;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%d", 1], @"pageType",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count", nil];
    
    [[HttpClientManager sharedInstance] getYellowPagesWithDict:dict
                                                      complete:^(BOOL success, GetYellowPagesResponse *resp) {
                                                          if (success && resp.result == RESPONSE_SUCCESS) {
                                                              for (YellowPageInfo *info in resp.list) {
                                                                  info.communityId = [AppSetting communityId];
                                                                  info.pageType = 1;
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
- (void)loadMoreZWXX
{
    YellowPageInfo *info = (YellowPageInfo *)[infoArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%d", 1], @"pageType",
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
        static NSString *CellIdentifier = @"zwxx_cell";
        SHHY_ZWXXCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[SHHY_ZWXXCell alloc] initWithStyle:UITableViewCellStyleValue1
                                        reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorWithHexValue:0xFFEAEAEA];
        }
        YellowPageInfo *zwxx = (YellowPageInfo *)[infoArray objectAtIndex:indexPath.section];
        [cell loadData:zwxx.content];
        
        return cell;
    }
}

#pragma mark UITableViewDelegate methods
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == infoArray.count) {
        return nil;
    }
    SHHY_ZWXXSectionView *view = [[SHHY_ZWXXSectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, SectionHeight)];
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
        [self loadMoreZWXX];
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
    }else{
        [tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [tableView endUpdates];
    
    if (nextDoInsert) {
        selectSction = endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)openMap
{
    if (selectSction == InvalidSection)
        return;
    
    YellowPageInfo *zwxx = (YellowPageInfo *)[infoArray objectAtIndex:selectSction];
    MapController *mapController = [[MapController alloc] initWithLat:zwxx.lat lon:zwxx.lon];
    mapController.telephone = zwxx.telephone;
    [self.navigationController pushViewController:mapController animated:YES];
}

@end
