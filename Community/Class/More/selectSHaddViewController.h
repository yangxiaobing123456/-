//
//  selectSHaddViewController.h
//  Community
//
//  Created by HuaMen on 14-10-13.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@protocol ChangeDelegate <NSObject>

-(void)changeTitle:(NSDictionary *)aStr;

@end

@interface selectSHaddViewController : CommunityViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    NSMutableArray *noticeArray;
    
}
@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *typeStr;
@property(nonatomic,assign)id<ChangeDelegate>delegate;
@end
