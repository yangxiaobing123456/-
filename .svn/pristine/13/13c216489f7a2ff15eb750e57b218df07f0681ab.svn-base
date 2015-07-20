//
//  ZBYHItemController.m
//  Community
//
//  Created by SYZ on 14-3-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "ZBYHItemController.h"
#import "ImageDownloader.h"
#import "PathUtil.h"
#import "ImageUtil.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62
#define TopAdHeight          125
#define LoadMoreCellHeight   40

@implementation TopAdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        recommendView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, TopAdHeight)];
        recommendView.image = [UIImage imageNamed:@"top_ad"];
        [self.contentView addSubview:recommendView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

static UIImage *arrowImage = nil;

@implementation AdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        if (!arrowImage) {
            arrowImage = [UIImage imageNamed:@"arrow"];
        }
        
        float imageW = 93.0f;
        adLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, imageW, CellHeight)];
        adLogoView.image = [ImageUtil imageCenterWithImage:[UIImage imageNamed:@"default_loading"]
                                                targetSize:CGSizeMake(imageW, CellHeight)
                                           backgroundColor:[UIColor colorWithHexValue:0xFFDBDCDC]];
        [self.contentView addSubview:adLogoView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageW + 12.0f, 0.0f, 155.0f, CellHeight)];
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:16.0f];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.numberOfLines = 3;
        [self.contentView addSubview:nameLabel];
        
        float arrowW = 12.0f, arrowH = 15.0f;
        arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(TableViewWidth - arrowW - 15.0f, (CellHeight - arrowH) / 2, arrowW, arrowH)];
        arrowView.image = arrowImage;
        [self.contentView addSubview:arrowView];
        
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 2.0f)];
        dividerView.backgroundColor = [UIColor grayColor];
        dividerView.alpha = 0.5f;
        [self.contentView addSubview:dividerView];
    }
    return self;
}

- (void)loadShop:(ShopInfo *)shop
{
    nameLabel.text = shop.shopName;
    
    if ([shop.logo isEqualToString:kCommunityImageServer]) {
        return;
    }
    NSString *imgPath = [PathUtil pathOfImage:[NSString stringWithFormat:@"%lu", (unsigned long)[shop.logo hash]]];
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imgPath]) { // 图片文件不存在
        ImageDownloadingTask *task = [ImageDownloadingTask new];
        [task setImageUrl:shop.logo];
        [task setUserData:shop];
        [task setTargetFilePath:imgPath];
        [task setCompletionHandler:^(BOOL succeeded, ImageDownloadingTask *idt) {
            if(succeeded && idt != nil && [idt.userData isEqual:shop]){
                UIImage *tempImg = [UIImage imageWithData:[idt resultImageData]];
                [adLogoView setImage:tempImg];
            }
        }];
        [[ImageDownloader sharedInstance] download:task];
    } else { //图片存在
        NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
        [adLogoView setImage:[UIImage imageWithData:imgData]];
    }
}

@end

@implementation ZBYHItemController

- (id)init
{
    self = [super init];
    if (self) {
        loadMore = YES;
        adArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    [self.view addSubview:tableView];
    
//    [self getHeaderAd];
    
	[self customBackButton:self];
    
//    //先读取数据库缓存数据
//    [self loadDBData];
    //读取旧数据后刷新数据
    [self refreshShops];
//    [self loadMoreShops];
}

- (void)getHeaderAd
{
    getTopAd = NO;
    
    if (!getTopAd) {
        float headerViewH = 34.0f;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, headerViewH)];
        headerView.backgroundColor = [UIColor clearColor];
        UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, headerViewH)];
        headerbg.image = [UIImage imageNamed:@"bg_red_68H"];
        [headerView addSubview:headerbg];
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(262.0f, 5.0f, 25.0f, 25.0f)];
        iconView.image = _iconImage;
        [headerView addSubview:iconView];
        tableView.tableHeaderView = headerView;
    } else {
        tableView.tableHeaderView = nil;
    }
}

- (void)loadDBData
{
    [adArray removeAllObjects];
    NSArray *array = [[CommunityDbManager sharedInstance] queryShops:[AppSetting communityId] type:_item];
    [adArray addObjectsFromArray:array];
    [tableView reloadData];
}

- (void)refreshShops
{
//    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = 0;
    if (adArray.count != 0) {
        ShopInfo *info = adArray[0];
        time = info.updateTime;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count",
                          [NSString stringWithFormat:@"%d", _item], @"type", nil];
    
    [[HttpClientManager sharedInstance] getShopsWithDict:dict
                                                complete:^(BOOL success, GetShopsResponse *resp) {
                                                    if (success && resp.result == RESPONSE_SUCCESS) {
                                                        for (ShopInfo *info in resp.list) {
                                                            //                                                            NSLog(@"statueType==%d",info.statueType);
                                                            //                                                            if (info.statueType!=0) {
                                                            info.communityId = [AppSetting communityId];
                                                            info.logo = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.logo];
//                                                            [[CommunityDbManager sharedInstance] insertOrUpdateShop:info];
                                                            //                                                            }
                                                            
                                                        }
                                                        
//                                                        if ([adArray count]<1) {
//                                                            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(100, 120, 80, 80)];
//                                                            image.image=[UIImage imageNamed:@"无订单"];
//                                                            UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(80, 200, 120, 80)];
//                                                            l.text=@"去别处逛逛吧……";
//                                                            l.textColor=[UIColor grayColor];
//                                                            [self.view addSubview:image];
//                                                            [self.view addSubview:l];
//                                                        }
                                                        [adArray addObjectsFromArray:resp.list];
                                                        [tableView reloadData];
                                                    }
                                                    
                                                }];

    
//    [[HttpClientManager sharedInstance] getShopsWithDict:dict
//                                                complete:^(BOOL success, GetShopsResponse *resp) {
//                                                    if (success && resp.result == RESPONSE_SUCCESS) {
//                                                        for (ShopInfo *info in resp.list) {
//                                                            NSLog(@"statueType==%d",info.statueType);
//                                                            if (info.statueType!=0) {
//                                                                info.communityId = [AppSetting communityId];
//                                                                info.logo = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.logo];
//                                                                [[CommunityDbManager sharedInstance] insertOrUpdateShop:info];
//                                                            }
//                                                            
//
//                                        
//                                                                                                                    }
//                                                        if (resp.all == 1) {
//                                                            loadMore = NO;
//                                                        }
////                                                        [self loadDBData];
//                                                        [adArray removeAllObjects];
//                                                        NSArray *array = [[CommunityDbManager sharedInstance] queryShops:[AppSetting communityId] type:_item];
//                                                        NSLog(@"%@",array);
//                                                        [adArray addObjectsFromArray:array];
//                                                        [tableView reloadData];
//                                                    }
//                                                    [[CommunityIndicator sharedInstance] hideIndicator:YES];
//                                                }];
    
}

//加载更多
- (void)loadMoreShops
{
    
    ShopInfo *info = (ShopInfo *)[adArray lastObject];
    long long time  = info.updateTime;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          @"0", @"before",
                          [NSString stringWithFormat:@"%d", HttpRequestCount], @"count",
                          [NSString stringWithFormat:@"%d", _item], @"type", nil];
    
    [[HttpClientManager sharedInstance] getShopsWithDict:dict
                                                complete:^(BOOL success, GetShopsResponse *resp) {
                                                    if (success && resp.result == RESPONSE_SUCCESS) {
                                                        for (ShopInfo *info in resp.list) {
                                                            if (info.type != 0) {
                                                                info.logo = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.logo];
                                                                [adArray addObject:info];
                                                            }
                                                        }
                                                        if (resp.all == 1) {
                                                            loadMore = NO;
                                                        }
                                                        [tableView reloadData];
                                                    }
                                                }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 这里要判断是否有置顶广告, 1表示无RecommendCell, 2为有RecommendCell
    if (getTopAd) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 这里要判断是否有置顶广告
    if (getTopAd && section == 0) {
        return 1;
    } else if (loadMore){
        return adArray.count;
    }
    return adArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 这里要判断是否有置顶广告
    if (getTopAd && indexPath.section == 0) {
        static NSString *CellIdentifier = @"top_ad_cell";
        TopAdCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[TopAdCell alloc] initWithStyle:UITableViewCellStyleValue1
                                    reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    } else {
        if (indexPath.row == adArray.count) {
            static NSString *CellIdentifier = @"load_more_cell";
            LoadMoreCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[LoadMoreCell alloc] initWithStyle:UITableViewCellStyleValue1
                                           reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
            [cell startActivityView];
            return cell;
        } else {
            static NSString *CellIdentifier = @"ad_cell";
            AdCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[AdCell alloc] initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor whiteColor];
            }
            
            [cell loadShop:[adArray objectAtIndex:indexPath.row]];
            return cell;
        }
    }
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 这里要判断是否有置顶广告
    if (getTopAd && indexPath.section == 0) {
        return TopAdHeight;
    } else if (indexPath.row == adArray.count) {
        return LoadMoreCellHeight;
    }
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (getTopAd && indexPath.section == 0) {
        
    } else if (indexPath.row == adArray.count) {
        return;
    } else {
        ShopInfo *shop = [adArray objectAtIndex:indexPath.row];
        ZBYH_DetailController *controller = [ZBYH_DetailController new];
        controller.title = @"优惠详情";
        controller.shopInfo = shop;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动到底部，自动加载更多数据
    float scrollContentHeight = scrollView.contentSize.height;
    float scrollHeight = scrollView.bounds.size.height;
    if (scrollView.contentOffset.y >= scrollContentHeight - scrollHeight - LoadMoreCellHeight &&
        loadMore) {
        [self loadMoreShops];
    }
}

@end
