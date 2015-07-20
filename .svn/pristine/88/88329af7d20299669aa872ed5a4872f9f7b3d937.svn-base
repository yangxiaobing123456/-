//
//  XQTZController.h
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

//  小区通知

#import "CommunityViewController.h"
#import "XQTZ_DetailController.h"
#import "HttpClientManager.h"
#import "NoticeInfo.h"
#import "LoadMoreCell.h"
#import "ImageDownloader.h"
#import "PathUtil.h"

enum XQTZType
{
    JJTZ = 1,      //紧急通知
    TZ,            //通知
    WXTS,          //温馨提示
    GG,            //公告
    ZX,            //资讯
};

@interface XQTZCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *noticeTypeLabel;
    UILabel *timeLabel;
    UILabel *noticeSummaryLabel;
}

- (void)loadNotice:(NoticeInfo *)notice;

@end

@interface XQTZController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    BOOL loadMore;
    NSMutableArray *noticeArray;
}

@end
