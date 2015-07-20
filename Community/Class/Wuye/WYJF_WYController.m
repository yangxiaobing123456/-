//
//  WYJF_WYController.m
//  Community
//
//  Created by SYZ on 13-12-14.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "WYJF_WYController.h"
#define LeftMargin         0
#define ViewWidth          320

@implementation RoomInfoView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        setArrowImage=NO;

        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"WY_View" owner:self options:nil];
        myView = [array objectAtIndex:0];
        //xib坐标一定要和此处一致，不然控件不响应
        myView.frame = CGRectMake(0, 0, 320, 670);
        [self addSubview:myView];

        [myView.timeButton addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchUpInside];

        [myView.button addTarget:self action:@selector(makeFee) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

-(void)showDatePicker
{
    //好奇怪，下面两种写法竟然没有崩溃
//    strDate=0;
//    strDate=@"";;
    setArrowImage = !setArrowImage;
    if (setArrowImage==YES) {
        myView.arrowImage.image = [UIImage imageNamed:@"arrow_up.png"];
    }else
    {
        myView.arrowImage.image = [UIImage imageNamed:@"arrow.png"];
    }
    strDate=@"";
    days =0;

    myView.timeLabel.text = @"";
    myView.timeButton.userInteractionEnabled = NO;
    
    timeView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 420.0f, 320.0f, 250.0f)];
//    timeView.layer.cornerRadius = 10.0f;
    timeView.backgroundColor = [UIColor whiteColor];
    //timeView.backgroundColor = RGBA(255, 215, 0, 1);

//    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 100.0f)];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 50.0f, 320.0f, 199.0f)];
    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //[datePicker setMaximumDate:[NSDate date]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    //获得当前选择的日期
    //selected = [datePicker date];
    [datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];

    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 249, 320, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    line1.alpha = 0.5;
    [timeView addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 49.0f)];
    line2.backgroundColor = [UIColor lightGrayColor];
    line2.text = @"选择时间";
    line2.textAlignment = NSTextAlignmentCenter;
    line2.font = [UIFont systemFontOfSize:20];
    [timeView addSubview:line2];

    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    confirmButton.layer.cornerRadius = 5;
//    confirmButton.frame = CGRectMake(140.5f, 176.0f, 139.50f, 49.0f);
    confirmButton.frame = CGRectMake(205.0f, 0.0f, 139.50f, 49.0f);

    confirmButton.tag = 2;
    confirmButton.backgroundColor = [UIColor clearColor];
    [confirmButton setTitle:@"完成" forState:UIControlStateNormal];
    [confirmButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(dismissDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    [timeView addSubview:datePicker];
    [timeView addSubview:confirmButton];
    [myView addSubview:timeView];
}
- (void)datePickerDateChanged:(UIDatePicker *)paramDatePicker
{
    if ([paramDatePicker isEqual:datePicker])
    {
        //NSLog(@"Selected date = %@",paramDatePicker.date);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        strDate = [dateFormatter stringFromDate:paramDatePicker.date];
        
        int value1 =[strDate intValue]/10000;
        int value2 =[strDate intValue]%10000/100;
        int value3 =[strDate intValue]%10000%100;
        myView.timeLabel.text = [NSString stringWithFormat:@"%d年%d月%d日", value1,value2,value3];
        
        NSString *lastStr = [NSString stringWithFormat:@"%d",self.room.lastPropertyFee];
        lastDate = [dateFormatter dateFromString:lastStr];
//缴费方法优化
        NSTimeInterval times=[paramDatePicker.date timeIntervalSinceDate:lastDate];
        days=((int)times)/(3600*24);
        
        myView.dayLabel.text = [NSString stringWithFormat:@" 共计%d天，应付总价：",days];
        toTime = (NSInteger)paramDatePicker.date;

    }
}
- (void)dismissDatePicker:(UIButton *)btn
{

    myView.timeButton.userInteractionEnabled = YES;
            if (days<20)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"缴费时间不能小于20天" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
            }else
            {
            timeView.hidden = YES;
            int value1 =[strDate intValue]/10000;
            int value2 =[strDate intValue]%10000/100;
            int value3 =[strDate intValue]%10000%100;
            myView.timeLabel.text = [NSString stringWithFormat:@"%d年%d月%d日", value1,value2,value3];
                
            setArrowImage = !setArrowImage;
    
            [self showList];
                
            }

//    }
    
    if (setArrowImage==YES) {
        myView.arrowImage.image = [UIImage imageNamed:@"arrow_up.png"];
    }else
    {
        myView.arrowImage.image = [UIImage imageNamed:@"arrow.png"];
    }

}

-(void)showList{
    [[CommunityIndicator sharedInstance] startLoading];
//    sleep(5);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *toTime1 = [dateFormatter stringFromDate:datePicker.date];
    //NSString *fromTime = [dateFormatter stringFromDate:self.room.lastPropertyFee];

    NSString *string1 = [NSString stringWithFormat:@"%d",self.room.lastPropertyFee/10000];
    NSString *string2 = [NSString stringWithFormat:@"%d",self.room.lastPropertyFee/100%100];
    NSString *string3 = [NSString stringWithFormat:@"%d",self.room.lastPropertyFee%100];
    NSString *fromTime = [NSString stringWithFormat:@"%@-%@-%@",string1,string2,string3];

    NSLog(@"self.room.unitPrice--%f",self.room.unitPrice);
    NSLog(@"self.room.totalArea--%f",self.room.totalArea);
    NSLog(@"self.room.discount--%f",self.room.roomDiscount);

    NSString *unit = [NSString stringWithFormat:@"%f",self.room.unitPrice];
    NSString *area = [NSString stringWithFormat:@"%.2f",self.room.totalArea];
    NSString *discount = [NSString stringWithFormat:@"%.2f",self.room.roomDiscount];

    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:fromTime,@"fromTime",toTime1,@"toTime",unit,@"unit",area,@"area",discount,@"discount", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:wuyeGetFee];
        //ASIHTTPRequest的post
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=101;
        request.delegate=self;
        [request startAsynchronous];

    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [[CommunityIndicator sharedInstance]hideIndicator:YES];
    [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"服务器挂了sorry!"];
    
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==101) {
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"dic==%@",dic);
//        NSString *result=[dic objectForKey:@"result"];
//        if ([result isEqualToString:@"1"]) {
//        }
        roomFee = [dic objectForKey:@"roomFee"];
        //优惠价格 roomFee
        discountFee = [dic objectForKey:@"discountFee"];
        
        myView.priceLabel1.text = [NSString stringWithFormat:@"%@元",roomFee];
        
        myView.priceLabel2.text = [NSString stringWithFormat:@"%@元",discountFee];
        discountFee1 = [discountFee doubleValue];

        [[CommunityIndicator sharedInstance]hideIndicator:YES];

    }
}

- (void)loadRoomInfo:(RoomInfo *)room
{
    _room = room;
    if (!_room) {
        return;
    }
    
    myView.communityNameLabel.text = _room.communityName;
    myView.buildingNameLabel.text = _room.buildingName;
    myView.unitNameLabel.text = _room.unitName;
    myView.roomNameLabel.text = [NSString stringWithFormat:@"%@号",_room.roomName];
    myView.areaLabel.text = [NSString stringWithFormat:@"%.2f㎡", _room.totalArea];
    if (_room.propertyType == 1) {
        propertyTypeLabel.text = @"普通物业";
    } else if (_room.propertyType == 2) {
        propertyTypeLabel.text = @"别墅住宅";
    } else if (_room.propertyType == 3) {
        propertyTypeLabel.text = @"写字楼";
    }
    if (_room.roomDiscount >= 1.0) {
        myView.discountLabel.textAlignment = NSTextAlignmentLeft;
        myView.discountLabel.font = [UIFont systemFontOfSize:18.0f];
//        myView.discountLabel.text = @"       方便、快捷、简单\n             就在益社区iPhone客户端";
        myView.discountLabel.text = @"     方便、快捷、简单就在益社区";

    } else {
//        myView.discountLabel.textAlignment = NSTextAlignmentCenter;
//        myView.discountLabel.font = [UIFont systemFontOfSize:24.0f];
        myView.discountLabel.text = [NSString stringWithFormat:@"马上缴费可享受 %.1f 折优惠!", _room.roomDiscount * 10];
    }
    //显示到年月日
//    int nowFeeTime = [self.timestring intValue];
//    int value4 =nowFeeTime/10000;
//    int value5 =nowFeeTime%10000/100;
//    int value6 =nowFeeTime%10000%100;

    int value1 =_room.lastPropertyFee/10000;
    int value2 =_room.lastPropertyFee%10000/100;
    int value3 =_room.lastPropertyFee%10000%100;

    myView.lastFeeLabel.text = [NSString stringWithFormat:@"您的物业费已经缴纳至 %d年%d月%d日", value1,value2,value3];
    myView.unitPriceLabel.text = [NSString stringWithFormat:@"￥ %.2f 元/㎡", _room.unitPrice / 100];
    for (int i = 1; i <= 3; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:10 + i];
        UILabel *disLabel = (UILabel *)[self viewWithTag:20 + i];
        switch (i) {
            case 1:
            {
                label.text = [NSString stringWithFormat:@"原价: %.2f 元", _room.totalArea * _room.unitPrice / 100 * 6];
                money = _room.totalArea * _room.unitPrice * _room.roomDiscount / 100 * 6;
                disLabel.text = [NSString stringWithFormat:@"优惠: %.2f 元", money];
                break;
            }
            case 2:
            {
                label.text = [NSString stringWithFormat:@"原价: %.2f 元", _room.totalArea * _room.unitPrice / 100 * 12];
                money = _room.totalArea * _room.unitPrice * _room.roomDiscount / 100  * 12;
                disLabel.text = [NSString stringWithFormat:@"优惠: %.2f 元", money];
                break;
            }
            case 3:
            {
                label.text = [NSString stringWithFormat:@"原价: %.2f 元", _room.totalArea * _room.unitPrice / 100 * 24];
                money = _room.totalArea * _room.unitPrice * _room.roomDiscount / 100 * 24;
                disLabel.text = [NSString stringWithFormat:@"优惠: %.2f 元", money];
                break;
            }
            default:
                break;
        }
    }
}
//计算时间差   因为响应问题，方法废弃
//- (int)dateChange:(NSDate *)date1 withEndDate:(NSDate *)date2
//{
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyyMMdd"];
//    
//    NSTimeInterval times=[date2 timeIntervalSinceDate:date1];
//    int day=((int)times)/(3600*24);
//    return day;
//}


- (void)switchChanged:(SevenSwitch *)sender
{
    // 如果某个switch的状态是on,则要将其他switch的状态改为off
    if (sender.isOn) {
        for (int i = 1; i <= 3; i++) {
            if (i == sender.tag) {
                continue;
            }
            SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
            if (view.isOn) {
                [view setOn:NO animated:YES];
            }
        }
    }
}
//点击 去缴费
- (void)makeFee
{
    if (days<20) {
        UIAlertView *alertTime = [[UIAlertView alloc] initWithTitle:nil message:@"请选择缴费时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertTime show];
        return;
    }
    if (!_room) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取房间信息失败"];
        return;
    }
    
    //int feeType = 0;
//    for (int i = 1; i <= 3; i++) {
//        SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
//        if (view.isOn) {
//            feeType = i;
//        }
//    }
    
//    if (feeType == 0) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"选择缴费类型"];
//        return;
//    }
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[WYJF_WYController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    //int month=6;
//    switch (feeType) {
//        case 1:
//            month = 6;
//            break;
//        case 2:
//            month = 12;
//            break;
//        case 3:
//            month = 24;
//            break;
//        default:
//            break;
//    }
    
    if ([object isKindOfClass:[WYJF_WYController class]])
    {
        [((WYJF_WYController*)object) pushToPayControllerWithMonth:days money:discountFee1 timeStr:strDate roomFee:roomFee];
    }
}

@end

@implementation WYJF_WYController

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
	
    self.title = @"物业缴费";
    
//    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 304.0f, kNavContentHeight)];
//    blurView.backgroundColor = BlurColor;
//    [self.view addSubview:blurView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, -64.0f, kContentWidth, kContentHeight)];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.contentInset = UIEdgeInsetsMake(kNavigationBarPortraitHeight, 0.0f, 0.0f, 0.0f);
    
    
    scrollView.backgroundColor = [UIColor clearColor];
//    scrollView.backgroundColor = [UIColor greenColor];

    [self.view addSubview:scrollView];
    
    roomInfoView = [[RoomInfoView alloc] initWithFrame:CGRectMake(LeftMargin, TopMargin, ViewWidth, 680.0f)];
    
    roomInfoView.backgroundColor = [UIColor clearColor];
//    roomInfoView.backgroundColor = [UIColor redColor];

    [scrollView addSubview:roomInfoView];
    
    scrollView.contentSize = CGSizeMake(ViewWidth, 680.0f);
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadRoomInfo];
}

- (void)loadRoomInfo
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", user.roomId], @"id",
                          [NSString stringWithFormat:@"%d", 0], @"updateTime", nil];
    [[HttpClientManager sharedInstance] getRoomInfoWithDict:dict
                                                   complete:^(BOOL success, GetRoomInfoResponse *resp) {
                                                       
        if (success && resp.result == RESPONSE_SUCCESS) {
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            room = resp.info;
            [roomInfoView loadRoomInfo:room];
        } else {
            [roomInfoView loadRoomInfo:nil];
            if (resp) {
                [HttpResponseNotification getRoomInfoHttpResponse:resp.result];
            } else {
                [HttpResponseNotification getRoomInfoHttpResponse:RESPONSE_ERROR];
            }
        }
    }];
}
- (void)pushToPayControllerWithMonth:(int)month money:(double)money timeStr:(NSString *)timestr roomFee:(NSString *)roomFeeStr
{
    
    WYJF_WYNewController *controller = [WYJF_WYNewController new];
    controller.month = month;
    controller.money = money;
    //controller.type = WYJFTypeWY;
    //controller.room = room;
    controller.timestring = timestr;
    controller.roomFeeStr = roomFeeStr;
    [self.navigationController pushViewController:controller animated:YES];
}



@end
