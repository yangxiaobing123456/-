//
//  WYJF_PayController.m
//  Community
//
//  Created by SYZ on 14-1-18.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "WYJF_PayController.h"

#define LeftMargin         8
#define ViewWidth          304
#define HEIGHT              0

@implementation WYJF_PayView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        float titleBgHeight = 34.0f;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(43.0f, titleBgHeight + 20.0f, 218.0f, 26.0f)];
        imageView.image = [UIImage imageNamed:@"fee_gray_bg"];
        [self addSubview:imageView];
        
        monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(43.0f, titleBgHeight + 20.0f-HEIGHT, 50.0f, 26.0f)];
        monthLabel.textColor = [UIColor grayColor];
        monthLabel.backgroundColor = [UIColor clearColor];
        monthLabel.font = [UIFont systemFontOfSize:14.0f];
        monthLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:monthLabel];
        
        feeLabel = [[UILabel alloc] initWithFrame:CGRectMake(93.0f, titleBgHeight + 20.0f-HEIGHT, 168.0f, 26.0f)];
        feeLabel.textColor = [UIColor grayColor];
        feeLabel.backgroundColor = [UIColor clearColor];
        feeLabel.font = [UIFont systemFontOfSize:16.0f];
        feeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:feeLabel];
        
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(43.0f, 100.0f-HEIGHT, 218.0f, 50.0f)];
        tipLabel.textColor = [UIColor grayColor];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:16.0f];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.numberOfLines = 0;
        [self addSubview:tipLabel];
        
        UILabel *payTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(43.0f, 210.0f-HEIGHT, 218.0f, 26.0f)];
        payTypeLabel.text = @"选择支付方式";
        payTypeLabel.textColor = [UIColor grayColor];
        payTypeLabel.backgroundColor = [UIColor clearColor];
        payTypeLabel.font = [UIFont systemFontOfSize:16.0f];
        payTypeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:payTypeLabel];
        
        UIButton *uppayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        uppayButton.frame = CGRectMake(43.0f, 246.0f-HEIGHT, 110.0f, 50.0f);
        uppayButton.tag = 20;
        [uppayButton setTitleColor:[UIColor whiteColor]
                          forState:UIControlStateNormal];
        [uppayButton setBackgroundImage:[UIImage imageNamed:@"uppay_220W"]
                               forState:UIControlStateNormal];
        [uppayButton setBackgroundImage:[UIImage imageNamed:@"uppay_220W"]
                               forState:UIControlStateHighlighted];
        [uppayButton addTarget:self action:@selector(payWithType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:uppayButton];
        
        
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(43.0f,166.0f-HEIGHT, 218.0f, 40.0f)];
        noticeLabel.textColor = [UIColor grayColor];
        noticeLabel.backgroundColor = [UIColor clearColor];
        noticeLabel.font = [UIFont systemFontOfSize:16.0f];
        noticeLabel.textAlignment = NSTextAlignmentLeft;
        noticeLabel.numberOfLines = 0;
        noticeLabel.text = @"支付成功后请于两个工作日后到服务中心领取票据";
        [self addSubview:noticeLabel];
    }
    return self;
}

- (void)loadIconWithType:(enum WYJFType)type
{
    _type = type;
    
    switch (_type) {
        case WYJFTypeWY:
            iconView.image = [UIImage imageNamed:@""];
            break;
         
        case WYJFTypePark:
            iconView.image = [UIImage imageNamed:@""];
            break;
            
        default:
            break;
    }
}

- (void)loadDataWithMonth:(int)month money:(double)money
{
    monthLabel.text = [NSString stringWithFormat:@"%d 个月", month];
    feeLabel.text = [NSString stringWithFormat:@"%.2f 元", money];
    switch (_type) {
        case WYJFTypeWY:
            tipLabel.text = [NSString stringWithFormat:@"您选择%d天的物业费用\n费用总额: %.2f 元", month, money];
            break;
            
        case WYJFTypePark:
            tipLabel.text = [NSString stringWithFormat:@"您选择%d个月的停车费用\n费用总额: %.2f 元", month, money];
            break;
            
        default:
            break;
    }
    if (money > 500) {
        alipayButton.hidden = YES;
        alipayTipLabel.hidden = YES;
    }
}

- (void)payWithType:(UIButton *)sender
{
    id object = [self nextResponder];
    while (![object isKindOfClass:[WYJF_PayController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    switch (sender.tag) {
        case 10:
            if ([object isKindOfClass:[WYJF_PayController class]]) {
                [((WYJF_PayController*)object) alipay];
            }
            break;
            
        case 20:
            if ([object isKindOfClass:[WYJF_PayController class]]) {
                [((WYJF_PayController*)object) uppay];
            }
            break;
            
        default:
            break;
    }
}

@end

@implementation WYJF_PayController

@synthesize result = _result;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"缴费";    
    _result = @selector(paymentResult:);
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, ViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
	payView = [[WYJF_PayView alloc] initWithFrame:CGRectMake(LeftMargin, TopMargin-40, ViewWidth, kNavContentHeight - TopMargin)];
    [self.view addSubview:payView];
    [payView loadIconWithType:_type];
    [payView loadDataWithMonth:_month money:_money];
    
    UIImageView *Image=[[UIImageView alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height-160, 50, 50)];
    Image.image=[UIImage imageNamed:@"二胡卵子1"];
    [self.view addSubview:Image];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(60, self.view.bounds.size.height-180, 250, 90)];
    l.lineBreakMode=NSLineBreakByCharWrapping;
    l.font=[UIFont systemFontOfSize:14.0f];
    l.textColor=[UIColor grayColor];
    l.numberOfLines=0;
    l.text=@"温馨提示:\n您通过益社区缴纳的物业费已由您所在小区的物业公司授权，委托多益物业收取，请放心使用";
    [self.view addSubview:l];
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------支付宝Begin------------------------------------
- (void)alipay
{
    if (_money > 500) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付提示"
                                                            message:@"支付宝储蓄卡和信用卡快捷支付每日单笔限额500元,您的支付金额大于500元,是否使用其他方式支付？"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"支付宝有余额,继续使用支付宝", @"银联支付", nil];
        alertView.tag = 1;
        [alertView show];
        return;
    }
    [self doAlipay];
}

- (void)doAlipay
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", (long long)(_money * 100)], @"pai",
                          [NSString stringWithFormat:@"%d", 2], @"payType",
                          [NSString stringWithFormat:@"%d", _type == WYJFTypeWY ? _room.lastPropertyFee : _parking.lastFee], @"startMonth",
                          //截止日期
                          [NSString stringWithFormat:@"%d", _type == WYJFTypeWY ? [self.timestring intValue]: _parking.lastFee], @"endMonth",
                          [NSString stringWithFormat:@"%d", _month], @"month",
                          [NSString stringWithFormat:@"%d", _type], @"productType",
                          [NSString stringWithFormat:@"%lld", _type == WYJFTypeWY ? _room.roomId : _parking.parkingId], @"id",nil];
    
    
    [[HttpClientManager sharedInstance] getOrderNumberWithDict:dict
                                                      complete:^(BOOL success, GetOrderNumberResponse *resp) {
                                                          if (success && resp.result == RESPONSE_SUCCESS) {
                                                              alipayNumber = resp.no;
                                                              [AppSetting saveAlipayOrderNumber:alipayNumber];
                                                              [self generateOrder];
                                                          } else {
                                                              [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"生成订单错误,请重试"];
                                                          }
                                                      }];
}

- (void)generateOrder
{
    NSString *appScheme = URLScheme;
    NSString *orderInfo = [self getOrderInfo];
    NSString *signedStr = [self doRsa:orderInfo];
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
	
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
}

- (NSString*)getOrderInfo
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = [NSString stringWithFormat:@"%lld", alipayNumber];   //订单ID（由商家自行制定）
	order.productName = _type == WYJFTypeWY ? @"物业费" : @"停车费"; //商品标题
	order.productDescription =[NSString stringWithFormat:@"%d个月的%@用:%.2f", _month, _type == WYJFTypeWY ? @"物业费" : @"停车费", _money];                              //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f", _money];      //商品价格
	order.notifyURL = [NOTIFY_URL encodedStringWithUTF8];          //回调URL
	
	return [order description];
}

- (NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}


//wap回调函数
- (void)paymentResult:(NSString *)resultd
{
    //结果处理
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
	if (result) {
		if (result.statusCode == 9000) {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            //交易成功
            NSString *key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString]) {
                [self verifyAlipayResult:2];
                [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"交易成功"];
			} else {
                [self verifyAlipayResult:1];
                [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"交易失败"];
            }
        } else {
            [self verifyAlipayResult:1];
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"交易失败"];
        }
    } else {
        [self verifyAlipayResult:1];
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"支付失败"];
    }
}

- (void)verifyAlipayResult:(int)result
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", alipayNumber], @"id",
                          [NSString stringWithFormat:@"%d", result], @"type", nil];
    [[HttpClientManager sharedInstance] getPayResultWithDict:dict
                                                    complete:^(BOOL success, int result) {
                                                        if (success && result == RESPONSE_SUCCESS) {
                                                            
                                                        }
        
    }];
}     

- (void)paymentResultDelegate:(NSString *)result
{
    NSLog(@"----------%@",result);
}

//----------------------------------支付宝End------------------------------------

//----------------------------------银联Begin------------------------------------
- (void)uppay
{
    NSArray *array = [_timestring componentsSeparatedByString:@"-"];
    NSString *endMonthStr = [NSString stringWithFormat:@"%@%@%@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];
    NSString *str=[NSString stringWithFormat:@"%0.2f",_money];
    NSString *subStr=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%@", subStr], @"pai",
                          [NSString stringWithFormat:@"%d", 3], @"payType",
                          [NSString stringWithFormat:@"%d", _type == WYJFTypeWY ? _room.lastPropertyFee : _parking.lastFee], @"startMonth",
                          [NSString stringWithFormat:@"%d", _type == WYJFTypeWY ? [_timestring intValue] : [endMonthStr intValue]], @"endMonth",
                          [NSString stringWithFormat:@"%d", _month], @"month",
                          [NSString stringWithFormat:@"%d", _type], @"productType",
                          [NSString stringWithFormat:@"%lld", _type == WYJFTypeWY ? _room.roomId : _parking.parkingId], @"id", nil];
    NSLog(@"dict====%@",dict);
    
    [[HttpClientManager sharedInstance] getOrderNumberWithDict:dict
                                                      complete:^(BOOL success, GetOrderNumberResponse *resp) {
                                                          if (success && resp.result == RESPONSE_SUCCESS) {
                                        
                                                              UPPayViewController *controller = [UPPayViewController new];
                                                              controller.tradeNumber = resp.tradeNumber;
                                                              controller.orderNumber=[NSString stringWithFormat:@"%lld",resp.no];
                                                              [self.navigationController pushViewController:controller animated:YES];
                                                          } else {
                                                              [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"生成订单错误,请重试"];
                                                          }
                                                      }];
}

//------------------------------------银联End------------------------------------

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            [self doAlipay];
        } else if (buttonIndex == 2) {
            [self uppay];
        }
    } 
}

@end
