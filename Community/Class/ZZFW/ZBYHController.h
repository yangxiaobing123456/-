//
//  ZBYHController.h
//  Community
//
//  Created by SYZ on 13-12-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "HttpClientManager.h"
#import "ShopInfo.h"
#import "LoadMoreCell.h"

//和ZBYH_List.txt对应
typedef enum
{
    FOOD = 1,      //餐饮美食
    MARKET,        //超市便利
    MRJS,          //美容健身
    XXYL,          //休闲娱乐
    JDLX,          //酒店旅行
    WXFW,          //维修服务
    OTHER,         //其他优惠
} ZBYHItem;

@interface ZBYHCell : UITableViewCell
{
    UIImageView *bgView;
    UIImageView *iconView;
    UILabel *itemLabel;
    UIImageView *arrowView;
}

- (void)loadFunction:(NSDictionary *)dict;

@end

@interface ZBYHController : CommunityViewController <UITableViewDelegate, UITableViewDataSource>
{
    CommunityTableView *tableView;
    NSArray *functionArray;
}

@end
