//
//  SelectOptionController.h
//  Community
//
//  Created by SYZ on 14-1-3.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityInfo.h"
#import "EditCommunityView.h"
#import "ChinaCityInfo.h"

@protocol SelectOptionControllerDelegate;

@interface SelectOptionCell : UITableViewCell
{
    UILabel *contentLabel;
}

@property (nonatomic, strong) NSString *content;

@end

@interface SelectOptionController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
    NSMutableArray *optionArray;
}

@property (nonatomic) long long parentId;
@property (nonatomic) int tag;
@property (nonatomic, weak) id<SelectOptionControllerDelegate> delegate;

@end

@protocol SelectOptionControllerDelegate <NSObject>

@optional
- (void)selectCity:(HotCity *)c;
- (void)selectCommunity:(Community *)c;
- (void)selectBuilding:(Building *)b;
- (void)selectUnit:(Unit *)u;
- (void)selectRoom:(Room *)r;
- (void)addedParking;

@end