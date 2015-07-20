//
//  GetShareLisViewController.h
//  Community
//
//  Created by HuaMen on 15-2-28.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

#import "PeopleNumTableViewCell.h"
#import "PinglunCell.h"
#import "DianZanTableViewCell.h"
#import "TalkCell.h"
#import "PinglunView.h"


@interface GetShareLisViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIScrollView *myScrollview;
    UITableView *talkTable;
    
//    CGFloat contentHeight;
//    CGFloat table2Height;
    
    PinglunView *pingView;
    
    UIView *send_view;
    UITextField *message_field;
    int picNum;
    NSArray *imageArray;

    NSMutableArray *discussListArray;
//    NSArray *commentListArray;
    NSString *zanFlagString;
    NSString *deletePingString;



}
@property (nonatomic,copy)NSString *activityId;

@end
