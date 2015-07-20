//
//  detailTuanViewController.h
//  Community
//
//  Created by HuaMen on 14-10-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "ASIHTTPRequest.h"
@interface MyTuanCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *titleLabel;
    UILabel *contentlabel;
    UILabel *priceLabel;
    UILabel *timeLabel;
    UILabel *DingLabel;
}
@end

@interface detailTuanViewController : CommunityViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
    NSMutableArray *noticeArray;

    
    UIImageView *headImage;
    
}


@end
