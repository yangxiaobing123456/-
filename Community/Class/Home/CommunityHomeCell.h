//
//  CommunityHomeCell.h
//  Community
//
//  Created by SYZ on 13-11-26.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EllipseImage.h"

#define CellHorizontalSpace  8
#define CellVerticalSpace    8
#define ViewWidth            304
#define CellLeftMargin       0
#define RecommendCellHeight  150
#define FunctionCellHeight   90
#define HomeHeaderViewHeight 70
#define TopMargin            10

enum FunctionItemIndex
{
    FunctionWYFW = 0,      //物业服务
    FunctionZZFW,          //增值服务
    FunctionSQHD,          //社区活动
};

//首页顶部view,包括头像、时间和天气
@interface HomeHeaderView : UIView
{
    UIImageView *avatarView;
    UILabel *dayLabel;
    UILabel *monthLabel;
    UILabel *weekdayLabel;
    UILabel *tempLabel;
}

- (void)refreshAvatar;
//- (void)setTemp:(NSString *)temp;

@end

//首页的推荐
@interface HomeRecommendCell : UITableViewCell
{
    UIImageView *recommendView;
}

@end

//首页的功能选项
@interface HomeFunctionCell : UITableViewCell
{
    UIImageView *cellBgView;
    UIImageView *cellThemeView;
    
    UILabel *cellTitleLabel;
}

- (void)loadFuctionData:(NSIndexPath*)indexPath;

@end