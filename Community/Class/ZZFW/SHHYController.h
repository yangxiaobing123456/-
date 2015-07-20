//
//  SHHYController.h
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

//  生活黄页

#import "CommunityViewController.h"

//和SHHY_List.txt对应
typedef enum
{
    ZWXX = 1,      //政务信息
    GGJT,          //公共交通
    ZBYH_BANK,     //周边银行
    GGJY,          //公共教育
    YLWS,          //医疗卫生
} SHHYItem;

@interface SHHYCell : UITableViewCell
{
    UIImageView *bgView;
    UIImageView *iconView;
    UILabel *itemLabel;
    UIImageView *arrowView;
}

- (void)loadFunction:(NSDictionary *)dict;

@end

@interface SHHYController : CommunityViewController <UITableViewDataSource, UITableViewDelegate>
{
    CommunityTableView *tableView;
    NSArray *functionArray;
}

@end
