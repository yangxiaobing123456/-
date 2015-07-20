//
//  WYJF_PayController.h
//  Community
//
//  Created by SYZ on 14-1-18.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "RoomInfo.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"
#import "NSString+Extensions.h"
#import "UPPayViewController.h"
//#import "RoomInfoView.h"

enum WYJFType
{
    WYJFTypeWY = 1,
    WYJFTypePark,
};

@interface WYJF_PayView : UIView
{
    UIImageView *iconView;
    UILabel *monthLabel;
    UILabel *feeLabel;
    UILabel *tipLabel;
    UIButton *alipayButton;
    UILabel *alipayTipLabel;
}

@property (nonatomic) enum WYJFType type;

- (void)loadIconWithType:(enum WYJFType)type;
- (void)loadDataWithMonth:(int)month money:(double)money;

@end

@interface WYJF_PayController : CommunityViewController
{
    WYJF_PayView *payView;
    SEL _result;
    long long alipayNumber;
}

@property (nonatomic) int month;
@property (nonatomic) double money;
@property (nonatomic) enum WYJFType type;
@property (nonatomic, strong) RoomInfo *room;
@property (nonatomic, strong) ParkingInfo *parking;
//属性传值
@property (nonatomic,copy)NSString *timestring;

@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
- (void)paymentResult:(NSString *)result;

- (void)alipay;
- (void)uppay;

@end
