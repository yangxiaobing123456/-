//
//  WYJF_ParkNew_ControllerViewController.h
//  Community
//
//  Created by wutao on 15-1-21.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "RoomInfo.h"
#import "WYJF_PayController.h"
#import "WYJF_moneyView.h"
#import "ASIHTTPRequest.h"
@interface WYJF_ParkNew_ControllerViewController : CommunityViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *titleArray;
    UIScrollView *wuyeScrollView;
    
    NSString *communityNameLabel;
    NSString *buildingNameLabel;
    NSString *unitNameLabel;
    NSString *roomNameLabel;
    UILabel *areaLabel;
    UILabel *propertyTypeLabel;
    
    
    UILabel *lastFeeLabel;
    UILabel *discountLabel;
    UILabel *unitPriceLabel;
    
    
    //RoomInfo *room;
    NSArray *roomInfoArray;
    UITableView *listTableView;
    UIButton *buttonFee;
    
    WYJF_moneyView *myView;
    
    NSString *wallet;
    NSString *integral;
    NSString *integralNum;
    BOOL qianbaoBool;
    BOOL jifenBool;
    BOOL yinlianBool;
    NSString *strT;
    
//    ASIHTTPRequest *request;
    
    
}

@property (nonatomic, strong) RoomInfo *room;
@property(nonatomic,copy)NSString *moneyStr;

@property (nonatomic) double money;
@property (nonatomic,copy)NSString *timestring;
@property (nonatomic, strong) RoomInfo *room1;

@property (nonatomic) enum WYJFType type;
//@property (nonatomic, strong) RoomInfo *room;
//@property (nonatomic, strong) ParkingInfo *parking;
@property (nonatomic, strong) ParkingInfo *parkingInfo;

@property (nonatomic) int month;

@property(nonatomic,copy)NSString *startStr;
@property(nonatomic,copy)NSString *endStr;

- (void)loadRoomInfo:(RoomInfo *)info;


@end
