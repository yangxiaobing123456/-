//
//  ActivityDetailSecondViewController.h
//  Community
//
//  Created by HuaMen on 15-3-8.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

#import "PeopleNumTableViewCell.h"
#import "JoinTableViewCell.h"

#import "DianZanTableViewCell.h"

#import "PinglunCell.h"
#import "TalkCell.h"

#import "ShareActivityViewController.h"
#import "JoinActViewController.h"
#import "AcDetailThirdViewController.h"
#import "BottomBtnView.h"
#import "TabartwoView.h"
#import "PinglunView.h"
#import "GetJoinNumViewController.h"
#import "GetDiscussNumViewController.h"
#import "GetShareLisViewController.h"
#import "FaBuActivityViewController.h"

#import "ActivityDetailTitleView.h"
@interface ActivityDetailSecondViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIScrollView *myScrollview;
    
    ActivityDetailTitleView *acDtitleView;
    UITableView *peopleTable;
    UITableView *talkTable;
    UITableView *shareTable;
    //111
    NSDictionary *detailDic;
//    CGSize sizeScroll;
    
    NSMutableArray *userListArray;
    NSMutableArray *discussListArray;
    NSMutableArray *commentListArray;
    NSMutableArray *shareListArray;
    
    NSString *idString;
    NSString *flagString;
    NSString *shareFlagString;
    
    CGFloat contentHeight;
    CGFloat pingBtnHeight;
    CGFloat table2Height;
    
    CGFloat shareContentHeight;
    CGFloat shareTable2Height;
    
    PinglunView *pingView;
    NSString *zanFlagString;
    
    UIView *send_view;
    UITextField *message_field;
    
    BottomBtnView *bottomView;
    TabartwoView *tabarView;
    
    NSString *urlString;
    
    NSString *numString;
    NSString *discussNumString;
    NSString *shareNumString;
    
    NSArray *_imageNameArray;
    
    NSString *deletePingString;
//    NSString *idSting_mhp;
    NSString *talkidstring;

}
@property(nonatomic,retain)NSString *idStr;
@property (nonatomic,copy)NSString *displayPhone;


@end
