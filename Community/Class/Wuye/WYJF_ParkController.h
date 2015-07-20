//
//  WYJF_ParkController.h
//  Community
//
//  Created by SYZ on 13-12-14.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "SevenSwitch.h"
#import "WYJF_PayController.h"
//#import "WYJF_WYNewController.h"
#import "WYJF_ParkNew_ControllerViewController.h"
@interface ParkInfoView : UIView
{
    UILabel *communityNameLabel;
    UILabel *parkNumberLabel;
    UILabel *feeLabel;
    
    UILabel *lastFeeLabel;
    UILabel *discountLabel;
    NSString *timeString;
    float money;
}
@property (nonatomic, strong) ParkingInfo *parkingInfo;

@end

@interface WYJF_ParkController : CommunityViewController
{
    ParkInfoView *parkInfoView;
}

@property (nonatomic, strong) ParkingInfo *parking;

- (void)pushToPayControllerWithMonth:(int)month money:(double)money string:(NSString *)timestring;

@end
