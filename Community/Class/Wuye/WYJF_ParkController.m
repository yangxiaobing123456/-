//
//  WYJF_ParkController.m
//  Community
//
//  Created by SYZ on 13-12-14.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "WYJF_ParkController.h"

#define LeftMargin         8
#define ViewWidth          304

@implementation ParkInfoView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        float titleBgHeight = 34.0f;
//        UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, titleBgHeight)];
//        titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
//        [self addSubview:titleBgView];
        
//        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 3.0f, 28.0f, 28.0f)];
//        iconView.image = [UIImage imageNamed:@"wyjf"];
//        [titleBgView addSubview:iconView];
        
        UIImageView *roomIcon = [[UIImageView alloc] initWithFrame:CGRectMake(25.0f, titleBgHeight + 15.0f, 30.0f, 30.0f)];
        roomIcon.image = [UIImage imageNamed:@"物业缴费_小房子"];
        [self addSubview:roomIcon];
        
        float titleLabelX = 80.0f, titleLabelW = 70.0f;
        for (int i = 1; i <= 3; i++) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, roomIcon.frame.origin.y + 20.0f * (i - 1), titleLabelW, 20.0f)];
            titleLabel.textColor = [UIColor grayColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont systemFontOfSize:16.0f];
            [self addSubview:titleLabel];
            switch (i) {
                case 1:
                    titleLabel.text = @"小       区:";
                    break;
                case 2:
                    titleLabel.text = @"停车位号:";
                    break;
                case 3:
                    titleLabel.text = @"收费标准:";
                    break;
                default:
                    break;
            }
        }
        
        communityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(155.0f, 49.0f, 140, 20.0f)];
        communityNameLabel.textColor = [UIColor grayColor];
        communityNameLabel.backgroundColor = [UIColor clearColor];
        communityNameLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:communityNameLabel];
        
        parkNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(155.0f, 69.0f, 140, 20.0f)];
        parkNumberLabel.textColor = [UIColor grayColor];
        parkNumberLabel.backgroundColor = [UIColor clearColor];
        parkNumberLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:parkNumberLabel];
        
        feeLabel = [[UILabel alloc] initWithFrame:CGRectMake(155.0f, 89.0f, 140, 20.0f)];
        feeLabel.textColor = [UIColor grayColor];
        feeLabel.backgroundColor = [UIColor clearColor];
        feeLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:feeLabel];
        
        UIView *lastFeeLabelBg = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 125.0f, ViewWidth, 30.0f)];
        lastFeeLabelBg.backgroundColor = RGBA(255, 221, 41, 1);
        [self addSubview:lastFeeLabelBg];
        
        lastFeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 125.0f, ViewWidth - 20.0f, 30.0f)];
        lastFeeLabel.textColor = [UIColor grayColor];
        lastFeeLabel.backgroundColor = [UIColor clearColor];
        lastFeeLabel.font = [UIFont systemFontOfSize:16.0f];
        lastFeeLabel.text = @"您的停车费已经缴纳至";
        [self addSubview:lastFeeLabel];
        
        UIImageView *discountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 155.0f, ViewWidth, 69.0f)];
        discountImageView.image = [UIImage imageNamed:@"discount"];
        [self addSubview:discountImageView];
        
        discountLabel = [[UILabel alloc] initWithFrame:discountImageView.bounds];
        discountLabel.textColor = [UIColor grayColor];
        discountLabel.backgroundColor = [UIColor clearColor];
        discountLabel.numberOfLines = 0;
        [discountImageView addSubview:discountLabel];
        
        UILabel *feeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 230.0f, 200.0f, 20.0f)];
        feeTypeLabel.text = @"选择缴纳费用类型:";
        feeTypeLabel.textColor = [UIColor grayColor];
        feeTypeLabel.backgroundColor = [UIColor clearColor];
        feeTypeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:feeTypeLabel];
        
        for (int j = 1; j <= 3; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, feeTypeLabel.frame.origin.y + 30.0f + 36 * (j - 1), 218.0f, 26.0f)];
            imageView.image = [UIImage imageNamed:@"fee_gray_bg"];
            [self addSubview:imageView];
            
            UILabel *monthType = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, feeTypeLabel.frame.origin.y + 30.0f + 36 * (j - 1), 50.0f, 26.0f)];
            monthType.textColor = [UIColor grayColor];
            monthType.backgroundColor = [UIColor clearColor];
            monthType.font = [UIFont systemFontOfSize:14.0f];
            monthType.textAlignment = NSTextAlignmentCenter;
            [self addSubview:monthType];
            
            UILabel *feeType = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, feeTypeLabel.frame.origin.y + 30.0f + 36 * (j - 1), 168.0f, 26.0f)];
            feeType.tag = 10 + j;
            feeType.textColor = [UIColor grayColor];
            feeType.backgroundColor = [UIColor clearColor];
            feeType.font = [UIFont systemFontOfSize:16.0f];
            feeType.textAlignment = NSTextAlignmentCenter;
            [self addSubview:feeType];
            
            switch (j) {
                case 1:
                    monthType.text = @"6个月";
                    break;
                case 2:
                    monthType.text = @"12个月";
                    break;
                case 3:
                    monthType.text = @"24个月";
                    break;
                default:
                    break;
            }
            
            SevenSwitch *feeSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(244.0f, feeTypeLabel.frame.origin.y + 30.0f + 36 * (j - 1), 40.0f, 26.0f)];
            feeSwitch.tag = j;
            feeSwitch.isRounded = YES;
            feeSwitch.inactiveColor = [UIColor whiteColor];
            feeSwitch.onColor = [UIColor orangeColor];
            [feeSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            [self addSubview:feeSwitch];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((ViewWidth - 76) / 2, 376.0f, 76.0f, 26.0f);
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [button setTitle:@"去缴费" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                          forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"button_green_highlighted_152W"]
                          forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(makeFee) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)setParkingInfo:(ParkingInfo *)parkingInfo
{
    _parkingInfo = parkingInfo;
    if (!_parkingInfo) {
        return;
    }
    
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    communityNameLabel.text = user.communityName;
    parkNumberLabel.text = _parkingInfo.name;
    feeLabel.text = [NSString stringWithFormat:@"%.2f /月", _parkingInfo.fee / 100];
    //只显示到月
    lastFeeLabel.text = [NSString stringWithFormat:@"您的停车费已经缴纳至 %d", _parkingInfo.lastFee / 100];
    
    if (_parkingInfo.parkingDiscount >= 1.0) {
        discountLabel.textAlignment = NSTextAlignmentLeft;
        discountLabel.font = [UIFont systemFontOfSize:18.0f];
        discountLabel.text = @"       方便、快捷、简单\n             就在益社区iPhone客户端";
    } else {
        discountLabel.textAlignment = NSTextAlignmentCenter;
        discountLabel.font = [UIFont systemFontOfSize:24.0f];
        discountLabel.text = [NSString stringWithFormat:@"现在缴费享  %.1f  折优惠!", _parkingInfo.parkingDiscount * 10];
    }
    
    for (int i = 1; i <= 3; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:10 + i];
        switch (i) {
            case 1:
            {
                money = _parkingInfo.fee * _parkingInfo.parkingDiscount / 100 * 6;
                label.text = [NSString stringWithFormat:@"%.2f 元", money];
                break;
            }
            case 2:
            {
                money = _parkingInfo.fee * _parkingInfo.parkingDiscount / 100 * 12;
                label.text = [NSString stringWithFormat:@"%.2f 元", money];
                break;
            }
            case 3:
            {
                money = _parkingInfo.fee * _parkingInfo.parkingDiscount / 100 * 24;
                label.text = [NSString stringWithFormat:@"%.2f 元", money];
                break;
            }
            default:
                break;
        }
    }
}
-(NSString *)getTimeStrWithTimeInterval:(NSTimeInterval)interval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *datestr = [NSString stringWithFormat:@"%d-%d-%d",_parkingInfo.lastFee/10000,_parkingInfo.lastFee/100%100,_parkingInfo.lastFee%100];
    
    NSDate *Date0 = [dateFormatter dateFromString:datestr];
    NSString *titleString = [dateFormatter stringFromDate:[Date0 initWithTimeInterval:interval sinceDate:Date0]];
    NSLog(@"123-------%@",titleString);


    return titleString;
}
- (void)switchChanged:(SevenSwitch *)sender
{
    // 如果某个switch的状态是on,则要将其他switch的状态改为off
    if (sender.isOn) {
        for (int i = 1; i <= 3; i++)
        {
            if (i == sender.tag)
            {
                continue;
            }
            SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
            if (view.isOn)
            {
                [view setOn:NO animated:YES];
//                if (view.tag==1)
//                {
//                    timeString = [self getTimeStrWithTimeInterval:6];
//                }else if (view.tag==2)
//                {
//                    timeString = [self getTimeStrWithTimeInterval:12];
//                }else if (view.tag==3)
//                {
//                    timeString = [self getTimeStrWithTimeInterval:24];
//                }
            }
        }
    }
}

- (void)makeFee
{

    if (!_parkingInfo) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取车位信息失败"];
        return;
    }
    
    int feeType = 0;
    for (int i = 1; i <= 3; i++) {
        SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
        if (view.isOn) {
            feeType = i;
        }
    }
    
    if (feeType == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"选择缴费类型"];
        return;
    }
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[WYJF_ParkController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    int month;
    switch (feeType) {
        case 1:
            month = 6;
            timeString = [self getTimeStrWithTimeInterval:181*24*60*60*1];
            NSLog(@"666----%@",timeString);
            break;
        case 2:
            month = 12;
            timeString = [self getTimeStrWithTimeInterval:365*24*60*60*1];
            NSLog(@"121212----%@",timeString);

            break;
        case 3:
            month = 24;
            timeString = [self getTimeStrWithTimeInterval:730*24*60*60*1];
            NSLog(@"12121224----%@",timeString);

            break;
        default:
            break;
    }
    
//    if ([object isKindOfClass:[WYJF_ParkController class]])
//    {
//        [((WYJF_ParkController*)object) pushToPayControllerWithMonth:month money:_parkingInfo.fee * month * _parkingInfo.parkingDiscount / 100 string:timeString];
//    }
    if ([object isKindOfClass:[WYJF_ParkController class]])
    {
        [((WYJF_ParkController*)object) pushToPayControllerWithMonth:month money:_parkingInfo.fee * month * _parkingInfo.parkingDiscount / 100 string:timeString];
    }

}

@end

@implementation WYJF_ParkController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"车位缴费";
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 304.0f, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight)];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.contentInset = UIEdgeInsetsMake(kNavigationBarPortraitHeight, 0.0f, 0.0f, 0.0f);
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    parkInfoView = [[ParkInfoView alloc] initWithFrame:CGRectMake(LeftMargin, TopMargin, ViewWidth, 450.0f)];
    parkInfoView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:parkInfoView];
    
    scrollView.contentSize = CGSizeMake(ViewWidth, 455.0f);
    
    [self customBackButton:self];
    
    [parkInfoView setParkingInfo:_parking];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//物业缴费
//- (void)pushToPayControllerWithMonth:(int)month money:(double)money timeStr:(NSString *)timestr
//{
//    
//    WYJF_WYNewController *controller = [WYJF_WYNewController new];
//    controller.month = month;
//    controller.money = money;
//    //controller.type = WYJFTypeWY;
//    //controller.room = room;
//    controller.timestring = timestr;
//    [self.navigationController pushViewController:controller animated:YES];
//}
//停车缴费
- (void)pushToPayControllerWithMonth:(int)month money:(double)money string:(NSString *)timestring
{
    WYJF_ParkNew_ControllerViewController *controller = [WYJF_ParkNew_ControllerViewController new];
    controller.month = month;
    controller.money = money;
    controller.type = WYJFTypePark;//    controller.parking = _parking;

    controller.parkingInfo = _parking;
    controller.timestring = timestring;
    NSLog(@"7777----%@",timestring);

    [self.navigationController pushViewController:controller animated:YES];
}

@end
