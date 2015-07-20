//
//  WYJF_WYController.h
//  Community
//
//  Created by SYZ on 13-12-14.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "RoomInfo.h"
#import "SevenSwitch.h"
#import "WYJF_PayController.h"
#import "WYJF_WYNewController.h"
#import "WY_View.h"

@interface RoomInfoView : UIView
{
    UILabel *propertyTypeLabel;
    
    float money;
    UIView *timeView;
    
    NSDate *selected;
    NSString *strDate;
    UIDatePicker *datePicker;
    int days;
    
    NSInteger toTime;
    NSString *roomFee;
    NSString *discountFee;
    double discountFee1;
//    ASIHTTPRequest *request;
    
    WY_View *myView;
    
    BOOL setArrowImage;
    NSDate *lastDate;

}
@property (nonatomic, strong) RoomInfo *room;
@property(nonatomic,copy)NSString *moneyStr;

- (void)loadRoomInfo:(RoomInfo *)info;

@end

@interface WYJF_WYController : CommunityViewController
{
    RoomInfoView *roomInfoView;
    RoomInfo *room;
}
- (void)pushToPayControllerWithMonth:(int)month money:(double)money timeStr:(NSString *)timestr roomFee:(NSString *)roomFeeStr;

@end
