//
//  TSBXController.m
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "TSBXController.h"
#import "TSBX_TSController.h"
#import "TSBX_BXController.h"

#define LeftMargin         8
#define ViewWidth          304

@implementation TSBXView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BlurColor;
        isTSBX=YES;
        
        float offset = iPhone5 ? 30.0f : 0.0f;
        float space = iPhone5 ? 20.0f : 0.0f;
        UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, 34.0f)];
//        titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
        [self addSubview:titleBgView];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
//        iconView.image = [UIImage imageNamed:@"tsbx"];
        [self addSubview:iconView];
        
        TSBXAndWYJFViewControl *complainControl = [[TSBXAndWYJFViewControl alloc] initWithFrame:CGRectMake((ViewWidth - 76.0f) / 2, 196.0f + offset + space-20, 76.0f, 112.0f)];
        [complainControl setTag:1];
        [complainControl addTarget:self
                            action:@selector(didControlClick:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:complainControl];
        [complainControl setImage:[UIImage imageNamed:@"报修_02"] title:@"投  诉"];
        
        TSBXAndWYJFViewControl *repairControl = [[TSBXAndWYJFViewControl alloc] initWithFrame:CGRectMake((ViewWidth - 76.0f) / 2, 60.0f + offset-15, 76.0f, 112.0f)];
        [repairControl setTag:2];
        [repairControl addTarget:self
                          action:@selector(didControlClick:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:repairControl];
        [repairControl setImage:[UIImage imageNamed:@"投诉_01"] title:@"报  修"];
        
        UIButton *makeCallButton = [UIButton buttonWithType:UIButtonTypeCustom];
        makeCallButton.frame = CGRectMake((ViewWidth - 251.0f) / 2, 338.0f + offset + space+15, 251.0f, 34.0f);
        [makeCallButton setTag:3];
        [makeCallButton setTitle:[NSString stringWithFormat:@"服务电话: %@", [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]]]
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
        
        
        
//        subImage=[[UIImageView alloc]init];
//        [subImage setFrame:CGRectMake((ViewWidth - 251.0f) / 2, 338.0f + offset + space+15-60, 251.0f, 60)];
//        [subImage setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.3]];
//        [self addSubview:subImage];
//
//        
//        
//        subLabel=[[UILabel alloc]init];
//        [subLabel setFrame:CGRectMake(50,0, 251.0f-50, 60)];
//        subLabel.font=[UIFont systemFontOfSize:13];
//        [subLabel setBackgroundColor:[UIColor clearColor]];
//        [subLabel setTextColor:[UIColor whiteColor]];
//        [subLabel setLineBreakMode:NSLineBreakByCharWrapping];
//        [subImage addSubview:subLabel];
        [self downLoad];

        
        
        [[HttpClientManager sharedInstance] getCommunityInfoWithCommunityId:[AppSetting communityId] complete:^(BOOL success) {
            if (success) {
                [makeCallButton setTitle:[NSString stringWithFormat:@"服务电话: %@", [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]]]
                                forState:UIControlStateNormal];
            } else {
                NSString *phoneNum = [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]];
                if (!phoneNum || [phoneNum isEmptyOrBlank]) {
                    [makeCallButton setTitle:@"暂无服务电话"
                                    forState:UIControlStateNormal];
                } else {
                    //如果服务端修改了,这里有可能显示的是旧号码
                    [makeCallButton setTitle:phoneNum
                                    forState:UIControlStateNormal];
                }
            }
        }];
    }
    return self;
}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld", [AppSetting communityId]],@"communityId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:getCommunityCompalinTimeAndPhone];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"faild===%@",request.error);
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSString *str1=[dic objectForKey:@"after"];
            NSString *str2=[dic objectForKey:@"before"];
            isTSBX=[[dic objectForKey:@"flag"]boolValue];
            noticeStr=[NSString stringWithFormat:@"亲,晚上%@至早上%@是物业公司打烊时间,不能及时受理。若有紧急报修,请拨打物业电话,喊他起床哦",str1,str2];
            [subLabel setText:[NSString stringWithFormat:@"亲,晚上%@至早上%@是物业公司打烊时间,不能及时受理。若有紧急报修,请拨打物业电话,喊他起床哦",str1,str2]];
            [subLabel setNumberOfLines:3];
            
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
            
        }
        
    }
    
    
}

- (void)didControlClick:(UIControl *)sender
{
        id object = [self nextResponder];
        while (![object isKindOfClass:[TSBXController class]] &&
               object != nil) {
            object = [object nextResponder];
        }
        
        switch (sender.tag) {
            case 1:
                if (!isTSBX) {
                    if ([object isKindOfClass:[TSBXController class]]) {
                        [((TSBXController*)object) didComplainAction];
                    }

                }else{
                    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:noticeStr delegate:self cancelButtonTitle:@"暂不投诉" otherButtonTitles:nil];
                    [alertView addButtonWithTitle:@"继续投诉"];
                    alertView.tag=100;
                    [alertView show];
                }
                break;
                
            case 2:
                if (!isTSBX) {
                    if ([object isKindOfClass:[TSBXController class]]) {
                        [((TSBXController*)object) didRepairAction];
                    }

                }else{
                    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:noticeStr delegate:self cancelButtonTitle:@"暂不报修" otherButtonTitles:nil];
                    alertView.tag=200;
                    [alertView addButtonWithTitle:@"继续报修"];
                    [alertView show];
                    
                }
            break;
                
            default:
                break;
        }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    id object = [self nextResponder];
    while (![object isKindOfClass:[TSBXController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            if ([object isKindOfClass:[TSBXController class]]) {
                [((TSBXController*)object) didComplainAction];
            }
        }
        
        
    }if (alertView.tag==200) {
        if (buttonIndex==1) {
            if ([object isKindOfClass:[TSBXController class]]) {
                [((TSBXController*)object) didRepairAction];
            }
        }
        
    }
}
- (void)didButtonClick:(id)sender
{
    id object = [self nextResponder];
    while (![object isKindOfClass:[TSBXController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    if ([object isKindOfClass:[TSBXController class]]) {
        [((TSBXController*)object) didMakeCallAction];
    }
}

@end

@implementation TSBXController

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
    
    TSBXView *view = [[TSBXView alloc] initWithFrame:CGRectMake(LeftMargin, 10.0f, ViewWidth, kNavContentHeight)];
    [self.view addSubview:view];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0.0f, 0.0f, 31.0f, 31.0f);
//    [button setImage:[UIImage imageNamed:@"tsbx_history"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(checkTSBXHistory) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = buttonItem;
//    
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didComplainAction
{
    TSBX_TSController *ts = [TSBX_TSController new];
    [self.navigationController pushViewController:ts animated:YES];
}

- (void)didRepairAction
{
    TSBX_BXController *ts = [TSBX_BXController new];
    [self.navigationController pushViewController:ts animated:YES];
}

- (void)didMakeCallAction
{
    NSString *number = [[CommunityDbManager sharedInstance] queryTelephone:[AppSetting communityId]]; //此处读入电话号码
    //NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //结束电话之后会进入联系人列表
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框,打完电话之后回到程序中
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

- (void)checkTSBXHistory
{
    TSBXHistroyController *controller = [TSBXHistroyController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
