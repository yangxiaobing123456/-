//
//  GetDiscussNumViewController.h
//  Community
//
//  Created by HuaMen on 15-2-27.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "PeopleNumTableViewCell.h"
#import "PinglunCell.h"
#import "DianZanTableViewCell.h"
#import "TalkCell.h"
#import "PinglunView.h"

@interface GetDiscussNumViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIScrollView *myScrollview;

    UITableView *talkTable;
    NSMutableArray *discussListArray;
//    NSArray *commentListArray;
    
//    CGFloat contentHeight;
//    CGFloat table2Height;
    
    PinglunView *pingView;
    NSString *zanFlagString;
    
    UIView *send_view;
    UITextField *message_field;

    NSString *idstringPing;
    
    NSString *idstringTao;

}

@property (nonatomic,copy)NSString *activityId;

@end
