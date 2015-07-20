//
//  PersonalInfoController.m
//  Community
//
//  Created by SYZ on 13-11-26.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "PersonalInfoController.h"
#import "peronDingDanViewController.h"
#import "TSBXHistroyController.h"
#import "PayLogController.h"
#import "shouHuoAddViewController.h"
#import "personalWalletViewController.h"
#import "personIntergelViewController.h"
#import "MyAsssitViewController.h"
#import "MyActivityViewController.h"
#import "ActivityEmptyViewController.h"

#define ViewWidth               286
#define UserInfoControlHeight   176+200+40
#define CommunityControlHeight  65
#define CellHeight  80

@implementation UserInfoControl

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
//        bgView.image = [UIImage imageNamed:@"clear_bg_332H"];
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeprofile:) name:@"profileName" object:nil];
        
        float avatarPartH = 70.0f;
        float avatarW = 54.0f, avatarH = 54.0f;
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, (avatarPartH - avatarH) / 2, avatarW, avatarH)];
//        avatarView.image = [EllipseImage ellipseImage:[AppSetting avatarImage]
//                                            withInset:0.0f
//                                      withBorderWidth:5.0f
//                                      withBorderColor:[UIColor whiteColor]];
        avatarView.image=[AppSetting avatarImage];
        [self addSubview:avatarView];
        
        float arrowW = 12.0f, arrowH = 15.0f;
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - arrowW - 10.0f, (avatarPartH - arrowH) / 2, arrowW, arrowH)];
        arrowView.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:arrowView];
        
        float labelW = 180.0f; float labelw1=265.0f;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((ViewWidth - labelW) / 4+60, (avatarPartH - avatarH) / 2+20, labelW, 20.0f)];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:nameLabel];
        
        genderLabel = [[UILabel alloc] initWithFrame:CGRectMake((ViewWidth - labelW) / 4-15, 80.0f, labelW, 20.0f)];
        genderLabel.textColor = [UIColor blackColor];
        genderLabel.backgroundColor = [UIColor clearColor];
        genderLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:genderLabel];
        
        birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake((ViewWidth - labelW) / 4*3+40, 80.0f, labelW, 20.0f)];
        birthdayLabel.textColor = [UIColor blackColor];
        birthdayLabel.backgroundColor = [UIColor clearColor];
        birthdayLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:birthdayLabel];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 110.0f, 320, 10.0f)];
        [line setBackgroundColor:[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0]];
        [self addSubview:line];
        
        for (int i=0; i<6; i++) {
            UIImageView *arrow=[[UIImageView alloc]initWithFrame:CGRectMake(265,180.0f+50*i, 12, 15.0f)];
            [arrow setBackgroundColor:[UIColor whiteColor]];
            arrow.image=[UIImage imageNamed:@"arrow"];
            [self addSubview:arrow];

        }
        

        float heat = 5.0f; float heat1 = 50.0f;float w=50;
        UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1, 100.0f+CellHeight-heat, labelw1-100, 30.0f)];
        [l1 setText:@"我的订单"];
        [l1 setTextColor:[UIColor blackColor]];
        [self addSubview:l1];
        
        UIImageView *imageView10=[[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1-w, 100.0f+CellHeight-heat, 30.0f, 30.0f)];
        [imageView10 setImage:[UIImage imageNamed:@"wodedingdan"]];
        [self addSubview:imageView10];
        
        UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 100.0f+CellHeight-heat+33, 320-35, 0.5f)];
        [line1 setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:line1];

        
        UILabel *l2=[[UILabel alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1, 150.0f+CellHeight-heat, labelw1-100, 30.0f)];
        [l2 setText:@"我的缴费"];
        [l2 setTextColor:[UIColor blackColor]];
        [self addSubview:l2];
        
        UIImageView *imageView20=[[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1-w, 150.0f+CellHeight-heat, 30.0f, 30.0f)];
        [imageView20 setImage:[UIImage imageNamed:@"个人中心我的缴费.png"]];
        [self addSubview:imageView20];
        UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 150.0f+CellHeight-heat+33, 320-35,  0.5f)];
        [line2 setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:line2];


        UILabel *l3=[[UILabel alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1, 200.0f+CellHeight-heat, labelw1-100, 30.0f)];
        [l3 setText:@"我的服务"];
        [l3 setTextColor:[UIColor blackColor]];
        [self addSubview:l3];
        UIImageView *imageView30=[[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1-w, 200.0f+CellHeight-heat, 30.0f, 30.0f)];
        [imageView30 setImage:[UIImage imageNamed:@"小板子"]];
        [self addSubview:imageView30];
        UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 200.0f+CellHeight-heat+33, 320-35,  0.5f)];
        [line3 setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:line3];
        
        UILabel *l4=[[UILabel alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1, 250.0f+CellHeight-heat, labelw1-100, 30.0f)];
        [l4 setText:@"收货地址"];
        [l4 setTextColor:[UIColor blackColor]];
        [self addSubview:l4];
        UIImageView *imageView40=[[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1-w, 250.0f+CellHeight-heat, 30.0f, 30.0f)];
        [imageView40 setImage:[UIImage imageNamed:@"shouhuodizhi "]];
        [self addSubview:imageView40];
        UIImageView *line4=[[UIImageView alloc]initWithFrame:CGRectMake(0, 250.0f+CellHeight-heat+33, 320-35,  0.5f)];
        [line4 setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:line4];

        
        UILabel *l5=[[UILabel alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1, 300.0f+CellHeight-heat, labelw1-100, 30.0f)];
        [l5 setText:@"我的评价"];
        [l5 setTextColor:[UIColor blackColor]];
        [self addSubview:l5];
        UIImageView *imageView50=[[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1-w,300.0f+CellHeight-heat, 30.0f, 30.0f)];
        [imageView50 setImage:[UIImage imageNamed:@"wodepingjia"]];
        [self addSubview:imageView50];
        
         UIImageView *line5=[[UIImageView alloc]initWithFrame:CGRectMake(0, 300.0f+CellHeight-heat+33, 320-35,  0.5f)];
        [line5 setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:line5];


        UILabel *l6=[[UILabel alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1, 350.0f+CellHeight-heat, labelw1-100, 30.0f)];
        [l6 setText:@"我的活动"];
        [l6 setTextColor:[UIColor blackColor]];
        [self addSubview:l6];
        UIImageView *imageView60=[[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth - labelw1) / 2+heat1-w,350.0f+CellHeight-heat, 30.0f, 30.0f)];
        [imageView60 setImage:[UIImage imageNamed:@"社区活动.png"]];
        [self addSubview:imageView60];
        UIImageView *line6=[[UIImageView alloc]initWithFrame:CGRectMake(0, 350.0f+CellHeight-heat+33, 320-35,  0.5f)];
        [line6 setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:line6];


        
    }
    return self;
}
-(void)changeprofile:(NSNotification *)notice{
    NSLog(@"OK------");
    NSDictionary *dic=[notice userInfo];
    if (!dic||dic==nil) {
        return;
    }
    [nameLabel setText:[dic objectForKey:@"name"]];
    [genderLabel setText:[dic objectForKey:@"gender"]];
    [birthdayLabel setText:[dic objectForKey:@"birthday"]];

    
}

- (void)loadUserInfo:(UserInfo *)info
{
    nameLabel.text = [NSString stringWithFormat:@"%@", info.userName];
    genderLabel.text = [NSString stringWithFormat:@"性别：%@", info.gender == 1 ? @"男" : @"女"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:info.birthday / 1000];
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [df stringFromDate:date];
    birthdayLabel.text = [NSString stringWithFormat:@"生日：%@", dateString];
}

- (void)refreshAvatar
{
    avatarView.image = [EllipseImage ellipseImage:[AppSetting avatarImage]
                                        withInset:0.0f
                                  withBorderWidth:5.0f
                                  withBorderColor:[UIColor whiteColor]];
}

@end

@implementation CommunityControl

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
//        bgView.image = [UIImage imageNamed:@"clear_bg_170H"];
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        
        float arrowW = 12.0f, arrowH = 15.0f;
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - arrowW - 10.0f, (CommunityControlHeight - arrowH) / 2, arrowW, arrowH)];
        arrowView.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:arrowView];
        
        float labelW = 254.0f;
        communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 10.0f, labelW, 20.0f)];
        communityLabel.textColor = [UIColor blackColor];
        communityLabel.backgroundColor = [UIColor clearColor];
        communityLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:communityLabel];
        
        roomLabel = [[UILabel alloc] initWithFrame:communityLabel.frame];
        roomLabel.textColor = [UIColor blackColor];
        roomLabel.backgroundColor = [UIColor clearColor];
        roomLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:roomLabel];
        
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(5, 64, 280, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:line];
        
        companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 35.0f, labelW, 20.0f)];
        companyLabel.textColor = [UIColor blackColor];
        companyLabel.backgroundColor = [UIColor clearColor];
        companyLabel.font = [UIFont systemFontOfSize:17.0f];
        companyLabel.text = CommunityCompany;
        [self addSubview:companyLabel];
        [self homedown];
    }
    return self;
}

- (void)loadUserCommunity:(UserInfo *)info
{
//    communityLabel.text = info.communityName;
    roomLabel.text = info.roomName;
}
-(void)homedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting communityId]],@"id", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:findCompany];
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
    //    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络不给力啊"];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str====%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            [companyLabel setText:[dic objectForKey:@"companyName"]];
            
        }
    }
    
}

@end

@implementation ParkingControl

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
//        bgView.image = [UIImage imageNamed:@"clear_bg_170H"];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bgView];
        
        float arrowW = 12.0f, arrowH = 15.0f;
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - arrowW - 10.0f, (CommunityControlHeight - arrowH) / 2, arrowW, arrowH)];
        arrowView.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:arrowView];
        
        float labelW = 254.0f;
        communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 10.0f, labelW, 20.0f)];
        communityLabel.textColor = [UIColor blackColor];
        communityLabel.backgroundColor = [UIColor clearColor];
        communityLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:communityLabel];
        
        parkingLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 35.0f, labelW, 20.0f)];
        parkingLabel.textColor = [UIColor blackColor];
        parkingLabel.backgroundColor = [UIColor clearColor];
        parkingLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:parkingLabel];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(5, 64, 280, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:line];
        
       
        
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 60.0f, labelW, 20.0f)];
        companyLabel.textColor = [UIColor blackColor];
        companyLabel.backgroundColor = [UIColor clearColor];
        companyLabel.font = [UIFont systemFontOfSize:17.0f];
        companyLabel.text = CommunityCompany;
        [self addSubview:companyLabel];
    }
    return self;
}

- (void)loadParking:(NSArray *)array
{
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    communityLabel.text = user.communityName;
    
    if (array == nil || array.count == 0) {
        parkingLabel.text = @"您在当前物业无停车位";
    } else if (array.count == 1) {
        ParkingInfo *info = array[0];
        parkingLabel.text = info.name;
    } else if (array.count > 1) {
        parkingLabel.text = [NSString stringWithFormat:@"您在当前物业有%d个停车位", array.count];
    }
}

- (void)loadDefaultParkingTip:(NSString *)tip
{
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    communityLabel.text = user.communityName;
    parkingLabel.text = tip;
}

@end

@implementation PersonalInfoController

- (id)init
{
    self = [super init];
    if (self) {
        parkingsArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downLoad];
	
    self.title = @"个人中心";
    
    self.tabBarController.delegate = self;
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 304.0f, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, -124.0f, kContentWidth, kNavContentHeight+80)];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.contentInset = UIEdgeInsetsMake(kNavigationBarPortraitHeight, 0.0f, 0.0f, 0.0f);
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];


    
//    userBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, 10.0f, 304.0f, 66.0f)];
//    userBackgroundView.image = [UIImage imageNamed:@"bg2"];
//    [scrollView addSubview:userBackgroundView];
    float labelW = 100.0f; float labelW1=260.0f;
    userInfoControl = [[UserInfoControl alloc] initWithFrame:CGRectMake(17.0f, 96.0f, ViewWidth, UserInfoControlHeight+43)];
    [userInfoControl addTarget:self action:@selector(updateProfile) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:userInfoControl];
    
    UIImageView *integralImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yijifen_pic"]];
    integralImage.frame=CGRectMake(40, 170.0f+96+CellHeight-40-85, 20, 20.0f);
    [scrollView addSubview:integralImage];
    
    
    integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 170.0f+96+CellHeight-40-85, labelW, 20.0f)];
    integralLabel.textColor = [UIColor blackColor];
    integralLabel.backgroundColor = [UIColor clearColor];
    integralLabel.font = [UIFont systemFontOfSize:17.0f];
    [scrollView addSubview:integralLabel];
    
    UIImageView *integralImage1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yiqianbao_pic"]];
    integralImage1.frame=CGRectMake(180, 170.0f+96+CellHeight-40-85, 20, 20.0f);
    [scrollView addSubview:integralImage1];
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(160, 170.0f+96+CellHeight-40-85, 1, 20)];
    line.backgroundColor=[UIColor grayColor];
    [scrollView addSubview:line];
    
    walletLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 170.0f+96+CellHeight-40-85, labelW, 20.0f)];
    walletLabel.textColor = [UIColor blackColor];
    walletLabel.backgroundColor = [UIColor clearColor];
    walletLabel.font = [UIFont systemFontOfSize:17.0f];
    [scrollView addSubview:walletLabel];
    
    UIButton *btn5=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setFrame:integralLabel.frame];
    [btn5 setTag:50];
    [btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn5];
    
    UIButton *btn6=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn6 setFrame:walletLabel.frame];
    [btn6 setTag:60];
    [btn6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn6 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn6];
    
    UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 170.0f+96+CellHeight-40-90+30, 320, 10.0f)];
    [lineView setBackgroundColor:[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f]];
    [scrollView addSubview:lineView];
    
    UIImageView *sublineView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 170.0f+96+CellHeight-40-85-10-3, 300-14, 1.0f)];
    [sublineView setBackgroundColor:[UIColor lightGrayColor]];
    [scrollView addSubview:sublineView];
    
    UIImageView *sublineView1=[[UIImageView alloc]initWithFrame:CGRectMake(15, 170.0f+96+CellHeight-40-85+25, 300-14, 1.0f)];
    [sublineView1 setBackgroundColor:[UIColor lightGrayColor]];
    [scrollView addSubview:sublineView1];


    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake((ViewWidth - labelW1) / 2, 95.0f+96+CellHeight, 300, 30.0f)];
    [btn1 setTag:10];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn1];
    
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake((ViewWidth - labelW1) / 2, 145.0f+96+CellHeight, 300, 30.0f)];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTag:20];
    [btn2 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn2];

   
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setFrame:CGRectMake((ViewWidth - labelW1) / 2, 195.0f+96+CellHeight, 300, 30.0f)];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTag:30];
    [btn3 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn3];
    
    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake((ViewWidth - labelW1) / 2, 245.0f+96+CellHeight, 300, 30.0f)];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTag:40];
    [btn4 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn4];
    
    UIButton *btn7=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn7 setFrame:CGRectMake((ViewWidth - labelW1) / 2, 295.0f+96+CellHeight, 300, 30.0f)];
    [btn7 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn7 setTag:70];
    [btn7 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn7];

    UIButton *btn8=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn8 setFrame:CGRectMake((ViewWidth - labelW1) / 2, 345.0f+96+CellHeight, 300, 30.0f)];
    [btn8 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn8 setTag:80];
    [btn8 setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:btn8];

    communityControl = [[CommunityControl alloc] initWithFrame:CGRectMake(17.0f, 106.0f + UserInfoControlHeight+50, ViewWidth, CommunityControlHeight)];
    [communityControl addTarget:self action:@selector(updateCommunitys) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:communityControl];
    
    parkingControl = [[ParkingControl alloc] initWithFrame:CGRectMake(17.0f, 116.0f + UserInfoControlHeight + CommunityControlHeight+50, ViewWidth, CommunityControlHeight)];
    [parkingControl loadDefaultParkingTip:@"正在刷新停车位信息..."];
    [parkingControl addTarget:self action:@selector(updateParkings) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:parkingControl];
    
    float buttonW = 100.0f, buttonH = 32.0f;
    UIButton *changePwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changePwdButton.frame = CGRectMake(35.0f, 482+150.0f+CellHeight, buttonW, buttonH);
    [changePwdButton setTitle:@"修改密码"
                     forState:UIControlStateNormal];
    [changePwdButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                          forState:UIControlStateNormal];
    [changePwdButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                               forState:UIControlStateNormal];
    [changePwdButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                               forState:UIControlStateHighlighted];
    [changePwdButton addTarget:self
                        action:@selector(changePwdAction)
              forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:changePwdButton];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(185.0f-70, 482.0f+150+CellHeight+40, buttonW, buttonH);
    [logoutButton setTitle:@"注  销"
                  forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                       forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                            forState:UIControlStateHighlighted];
    [logoutButton addTarget:self
                     action:@selector(logoutAction)
           forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:logoutButton];
    
    scrollView.contentSize = CGSizeMake(kContentWidth, logoutButton.frame.origin.y + buttonH + 20.0f+CellHeight);
    
    [self customBackButton:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(successDownloadAvatar)
                                                 name:kDownloadAvatar
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(successChangeCommunity)
                                                 name:kChangeCommunity
                                               object:nil];
    [self loadData];
    [self getBindParkings];
}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:maShangQiang];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
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
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSString *str=[[dic objectForKey:@"wallet"]stringValue];
            NSString *str1=[[dic objectForKey:@"integral"]stringValue];
            NSUserDefaults *d=[NSUserDefaults standardUserDefaults];
            [d setObject:str forKey:@"personWallet"];
            [d setObject:str1 forKey:@"personIntegral"];
            [d synchronize];
            [walletLabel setText:[NSString stringWithFormat:@"益钱包"]];
            [integralLabel setText:[NSString stringWithFormat:@"益积分"]];
            
            
            
        }
    }
    if (request.tag==200) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"dic===%@",dic);
        int result=[[dic objectForKey:@"result"]intValue];
        if (result==1) {
            MyActivityViewController *controller = [MyActivityViewController new];
            controller.title = @"社区活动";
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else
        {
            
            ActivityEmptyViewController *controller = [ActivityEmptyViewController new];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        
    }

}
-(void)homedownM{
    //11
    NSDictionary *user = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"page",nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //22
        NSURL *url = [NSURL URLWithString:getFlagCommActivity];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        //33
        //传参数 密码加密        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSString *str=[NSString stringWithFormat:@"%lld",[AppSetting userId]];
        
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=200;
        request.delegate=self;
        [request startAsynchronous];
        
    }
    
    
}

-(void)btnClick:(UIButton *)btn{
    if (btn.tag==10) {
        peronDingDanViewController *pv=[[peronDingDanViewController alloc]init];
        pv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pv animated:YES];
        
    }if (btn.tag==20) {
        PayLogController *controller = [PayLogController new];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    }if (btn.tag==30) {
        TSBXHistroyController *pv=[[TSBXHistroyController alloc]init];
        pv.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:pv animated:YES];
        
    }if (btn.tag==40) {
        shouHuoAddViewController *pv=[[shouHuoAddViewController alloc]init];
        pv.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:pv animated:YES];
        
    }
    if (btn.tag==50) {
        personalWalletViewController *pv=[[personalWalletViewController alloc]init];
        pv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pv animated:YES];
        
    }if (btn.tag==60) {
        personIntergelViewController *pv=[[personIntergelViewController alloc]init];
        pv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pv animated:YES];
        
    }if (btn.tag==70) {
        MyAsssitViewController *pv=[[MyAsssitViewController alloc]init];
        pv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pv animated:YES];
        
    }if (btn.tag==80) {
        
        // 社区活动入口
        
        [self homedownM];

//        MyActivityViewController *pv=[[MyActivityViewController alloc]init];
//        pv.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:pv animated:YES];
        
        
    }
    
}

//是否登录
- (BOOL)didLogin
{
    if ([AppSetting userId] == ILLEGLE_USER_ID) {
        return NO;
    }
    return YES;
}

//判断是否完善信息
- (BOOL)didUpdatedUserInfo
{
    UserInfo *info = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    if ([info.roomName isEmptyOrBlank] || info.roomName == nil) {
        return NO;
    }
    return YES;
}

//进入完善个人信息页面
- (void)enterUpdateUserInfoView
{
    UpdateUserInfoController *controller = [[UpdateUserInfoController alloc] init];
    controller.delegate = self;
    controller.hideBackButton = YES;
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (showMainPage) {
        self.tabBarController.selectedIndex = 2;
        showMainPage = NO;
        return;
    }
    if (![self didLogin]) {
        showMainPage = YES;
        LoginController *controller = [[LoginController alloc] init];
        CommunityNavigationController *navController = [[CommunityNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:NO completion:nil];
        return;
    }
    
    if (![self didUpdatedUserInfo]) {
        [self enterUpdateUserInfoView];
        return;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    UserInfo *info = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    
    [userInfoControl loadUserInfo:info];
    [communityControl loadUserCommunity:info];
}

- (void)getBindParkings
{
    UserInfo *info = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];

    if (info == nil || info.roomId == 0) {
        return;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", info.roomId], @"id",
                          [NSString stringWithFormat:@"%lld", info.communityId],@"comm",
                          [NSString stringWithFormat:@"%d", 0], @"before",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%d", 100], @"count", nil];
    
    [[HttpClientManager sharedInstance] getBindParkingsWithDict:dict
                                                       complete:^(BOOL success, int result, NSArray *array) {
                                                           if (success == YES && result == RESPONSE_SUCCESS) {
                                                               [parkingControl loadParking:array];
                                                               [parkingsArray removeAllObjects];
                                                               [parkingsArray addObjectsFromArray:array];
                                                           } else {
                                                               [parkingControl loadDefaultParkingTip:@"刷新车位列表失败"];
                                                               [self alertRefreshParking];
                                                           }
                                                       }];
}

- (void)alertRefreshParking
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"获取车位列表失败，是否重新获取？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    alertView.tag = 2;
    [alertView show];
}

- (void)updateProfile
{
    UpdateProfileController *controller = [UpdateProfileController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)updateCommunitys
{
    UserCommunityController *controller = [UserCommunityController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)updateParkings
{
    if (parkingsArray == nil || parkingsArray.count == 0) {
        return;
    }
    UserParkingController *controller = [UserParkingController new];
    controller.hidesBottomBarWhenPushed = YES;
    controller.parkingsArray = parkingsArray;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)changePwdAction
{
    ChangePasswordController *controller = [ChangePasswordController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)logoutAction
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您确定要注销账户吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    alertView.tag = 1;
    [alertView show];
}

#pragma mark NSNotificationCenter methods
- (void)successDownloadAvatar
{
    [userInfoControl refreshAvatar];
}

- (void)successChangeCommunity
{
    [self loadData];
    [self getBindParkings];
}

#pragma mark UITabBarControllerDelegate methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (self.tabBarController.selectedViewController == viewController) {
        return NO;
    }
    return YES;
}

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            //注销
            [AppSetting userLogout];
            self.tabBarController.selectedIndex = 2;
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogout object:nil];
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            [self getBindParkings];
        }
    }
}

#pragma mark UpdateUserInfoControllerDelegate methods
- (void)popViewController:(UpdateUserInfoController *)controller
{
//    [controller.navigationController popViewControllerAnimated:YES];
    CommunityRootController *rootController = [CommunityRootController new];
    //                                                            UpdateUserInfoController *rootController = [UpdateUserInfoController new];
    [self presentViewController:rootController animated:YES completion:nil];
    [self loadData];
    [self getBindParkings];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kDownloadAvatar
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kChangeCommunity
                                                  object:nil];
}

@end
