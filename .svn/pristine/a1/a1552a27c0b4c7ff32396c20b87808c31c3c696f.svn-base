//
//  ZBYHItemController.h
//  Community
//
//  Created by SYZ on 14-3-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "ZBYHController.h"
#import "ZBYH_DetailController.h"

//首页的推荐
@interface TopAdCell : UITableViewCell
{
    UIImageView *recommendView;
}

@end

//首页的功能选项
@interface AdCell : UITableViewCell
{
    UIImageView *arrowView;
    UIImageView *adLogoView;
    
    UILabel *nameLabel;
}

- (void)loadShop:(ShopInfo *)shop;

@end

@interface ZBYHItemController : CommunityViewController <UITableViewDelegate, UITableViewDataSource>
{
    CommunityTableView *tableView;
    
    BOOL getTopAd;
    BOOL loadMore;
    
    NSMutableArray *adArray;
}

@property (nonatomic) ZBYHItem item;
@property (nonatomic, strong) UIImage *iconImage;

@end
