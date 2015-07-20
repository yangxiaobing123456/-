//
//  peronDingDanViewController.h
//  Community
//
//  Created by HuaMen on 14-10-14.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface peronDingDanViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableView;
    NSMutableArray *noticeArray;
    
    UIImageView *headImage;

}

@end
