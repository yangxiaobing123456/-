//
//  CWBG_DetailController.h
//  Community
//
//  Created by SYZ on 13-12-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "NoticeInfo.h"

@interface CWBG_DetailCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *itemLabel;
    UILabel *amountLabel;
}

- (void)loadItemAndAmount:(NSString *)string income:(BOOL)income;

@end

@interface CWBG_DetailController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
}

@property (nonatomic, strong) FinanceReportInfo *report;

@end
