//
//  CommunityMoreController.h
//  Community
//
//  Created by SYZ on 13-12-20.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityMoreHeaderView.h"
#import "GuideController.h"
#import "FeedBackController.h"
#import "AboutUsController.h"
#import "selectPwdViewController.h"
#import "shouHuoAddViewController.h"

@interface CommunityMoreCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *titleLabel;
    UIImageView *iconView;
}

- (void)setTitle:(NSString *)title bgWithArrow:(BOOL)arrow Image:(UIImage *)image;

@end

@interface CommunityMoreController : CommunityViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    CommunityTableView *tableView;
}

@end
