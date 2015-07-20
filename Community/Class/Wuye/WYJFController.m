//
//  WYJFController.m
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "WYJFController.h"
#import "WYJF_WYController.h"
#import "WYJF_ParkController.h"

#define LeftMargin         8
#define ViewWidth          304

@implementation WYJFView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        float offset = iPhone5 ? 30.0f : 0.0f;
        float space = iPhone5 ? 20.0f : 0.0f;
//        UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, 34.0f)];
//        titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
//        [self addSubview:titleBgView];
//        
//        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
//        iconView.image = [UIImage imageNamed:@"wyjf"];
//        [self addSubview:iconView];
        
        TSBXAndWYJFViewControl *wujfControl = [[TSBXAndWYJFViewControl alloc] initWithFrame:CGRectMake((ViewWidth - 76.0f) / 2, 60.0f + offset, 76.0f, 112.0f)];
        [wujfControl setTag:1];
        [wujfControl addTarget:self
                        action:@selector(didControlClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:wujfControl];
        [wujfControl setImage:[UIImage imageNamed:@"物业缴费"] title:@"物业缴费"];
        
        TSBXAndWYJFViewControl *tcjfControl = [[TSBXAndWYJFViewControl alloc] initWithFrame:CGRectMake((ViewWidth - 76.0f) / 2, 196.0f + offset + space, 76.0f, 112.0f)];
        [tcjfControl setTag:2];
        [tcjfControl addTarget:self
                        action:@selector(didControlClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tcjfControl];
        [tcjfControl setImage:[UIImage imageNamed:@"停车缴费"] title:@"停车缴费"];
        
        UIButton *makeCallButton = [UIButton buttonWithType:UIButtonTypeCustom];
        makeCallButton.frame = CGRectMake((ViewWidth - 251.0f) / 2, 338.0f + offset + space, 251.0f, 34.0f);
        [makeCallButton setTag:3];
        [makeCallButton setTitle:[NSString stringWithFormat:@"咨询电话: %@", [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]]]
                        forState:UIControlStateNormal];
        [makeCallButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [makeCallButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 60.0f)];
        [makeCallButton setTitleColor:[UIColor blackColor]
                             forState:UIControlStateNormal];
        [makeCallButton setBackgroundImage:[UIImage imageNamed:@"投诉报修电话"]
                                  forState:UIControlStateNormal];
        [makeCallButton addTarget:self
                           action:@selector(didButtonClick:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:makeCallButton];
        
        NSString *phoneNum = [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]];
        if (!phoneNum || [phoneNum isEmptyOrBlank]) {
            [[HttpClientManager sharedInstance] getCommunityInfoWithCommunityId:[AppSetting communityId] complete:^(BOOL success) {
                if (success) {
                    [makeCallButton setTitle:[NSString stringWithFormat:@"咨询电话: %@", [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]]]
                                    forState:UIControlStateNormal];
                } else {
                    [makeCallButton setTitle:@"暂无咨询电话"
                                    forState:UIControlStateNormal];
                }
            }];
        }
    }
    return self;
}

- (void)didControlClick:(UIControl *)sender
{
    id object = [self nextResponder];
    while (![object isKindOfClass:[WYJFController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    switch (sender.tag) {
        case 1:
            if ([object isKindOfClass:[WYJFController class]]) {
                [((WYJFController*)object) didWuyeFeeAction];
                 [((WYJFController*)object) getinfo];
            }
            break;
            
        case 2:
            if ([object isKindOfClass:[WYJFController class]]) {
                [((WYJFController*)object) didParkFeeAction];
            }
            break;
            
        default:
            break;
    }
}

- (void)didButtonClick:(UIButton *)sender
{
    id object = [self nextResponder];
    while (![object isKindOfClass:[WYJFController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    if ([object isKindOfClass:[WYJFController class]]) {
        [((WYJFController*)object) didMakeCallAction];
    }
}

@end

@implementation WYJFController

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
	
    WYJFView *view = [[WYJFView alloc] initWithFrame:CGRectMake(LeftMargin, 10.0f, ViewWidth, kNavContentHeight)];
    [self.view addSubview:view];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0.0f, 0.0f, 31.0f, 28.0f);
//    [button setImage:[UIImage imageNamed:@"paylog_button"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(checkPayLog) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didWuyeFeeAction
{
    WYJF_WYController *wy = [WYJF_WYController new];
    [self.navigationController pushViewController:wy animated:YES];
}
-(void)getinfo
{
    
}
- (void)didParkFeeAction
{
    UserParkingController *controller = [UserParkingController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didMakeCallAction
{
    NSString *number = [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]];// 此处读入电话号码
    //NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //结束电话之后会进入联系人列表
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框,打完电话之后回到程序中
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

- (void)checkPayLog
{
    PayLogController *controller = [PayLogController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
