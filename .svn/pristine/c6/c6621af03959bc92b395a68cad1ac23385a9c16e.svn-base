//
//  SHHY_ZWXXController.h
//  Community
//
//  Created by SYZ on 13-11-30.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "YellowPageInfo.h"
#import "HttpClientManager.h"
#import "MapController.h"
#import "LoadMoreCell.h"

@interface SHHY_ZWXXSectionView : UIView
{
    UIImageView *bgView;
    UILabel *nameLabel;
    UILabel *addressLabel;
    UIImageView *positionView;
}

- (void)loadYellowPage:(YellowPageInfo *)info;

@end

@interface SHHY_ZWXXCell : UITableViewCell
{
    UITextView *textView;
}

- (void)loadData:(NSString *)string;

@end

@interface SHHY_ZWXXController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSMutableArray *infoArray;
    BOOL loadMore;
    
    int selectSction;
    int endSection;
    BOOL expand;
}

- (void)openMap;

@end
