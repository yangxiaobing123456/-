//
//  SHHY_GGJTController.h
//  Community
//
//  Created by SYZ on 13-11-30.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "YellowPageInfo.h"
#import "HttpClientManager.h"
#import "LoadMoreCell.h"
#import "SevenSwitch.h"

@interface SHHY_GGJTSectionView : UIView
{
    UIImageView *bgView;
    UILabel *nameLabel;
    UILabel *timeLabel;
}

- (void)loadYellowPage:(YellowPageInfo *)info;

@end

@interface SHHY_GGJTCell : UITableViewCell
{
    UIScrollView *scrollView;
    UISegmentedControl *segmentedControl;
}

@property(nonatomic, strong) YellowPageInfo *yellowPageInfo;

@end

@interface SHHY_GGJTController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
    NSMutableArray *infoArray;
    BOOL loadMore;
    
    NSInteger selectSction;
    NSInteger endSection;
    BOOL expand;
}

@end
