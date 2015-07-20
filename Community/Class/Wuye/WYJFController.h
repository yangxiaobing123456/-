//
//  WYJFController.h
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

//  物业缴费

#import "CommunityViewController.h"
#import "TSBXAndWYJFViewControl.h"
#import "PayLogController.h"
#import "UserParkingController.h"

@interface WYJFView : UIView

@end

@interface WYJFController : CommunityViewController

- (void)didWuyeFeeAction;
- (void)didParkFeeAction;
- (void)didMakeCallAction;
-(void)getinfo;
@end
