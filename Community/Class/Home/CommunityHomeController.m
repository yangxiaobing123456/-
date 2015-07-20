//
//  CommunityHomeController.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityHomeController.h"
#import "WYFWController.h"
#import "ZZFWController.h"
#import "UpdateUserInfoController.h"
#import "detailTuanViewController.h"
#import "PraiseViewController.h"
#import "FirstPageWebViewController.h"
#import "NewActivityViewController.h"

#import "ActivityEmptyViewController.h"
#define LeftMargin   8.0f

@implementation CommunityHomeController

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
    _AdData=[[NSMutableArray alloc]initWithCapacity:6];
    
    self.title = @"益社区";


    /*天气模块定位
    map = [[MKMapView alloc] init];
    map.hidden = YES;
    map.delegate = self;
    map.showsUserLocation =YES;
    map.mapType = MKMapTypeStandard;*/
    
    CGRect rect = CGRectMake(LeftMargin, iOS7 ? 20.0f + CellVerticalSpace * 2 : CellVerticalSpace, ViewWidth, kContentHeight - kTabBarHeight);
    NSLog(@"%f%f",rect.origin.x,rect.origin.y);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    if ([self didLogin]) {
        NSLog(@"已经登陆则调接口判断送积分----22-----");
        [self songJiFenRequest];
        
//        UILabel *redLabe = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 300, 300)] ;
//        redLabe.backgroundColor = [UIColor redColor];
//        [scrollView addSubview:redLabe];

    }

    
    headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth / 2, HomeHeaderViewHeight)];
    [scrollView addSubview:headerView];
    
    control1 = [[CommunityHomeControl alloc] initWithPoint:CGPointMake(ViewWidth / 2 + LeftMargin / 2, 0.0f) sizeType:MIDDLESIZE];
    control1.tag = 1;
    control1.layer.masksToBounds=YES;       
    control1.layer.cornerRadius=12;
    control1.backgroundColor = [UIColor colorWithHexValue:0xFF009FE8];
    [control1 setNotice:newestNotice];
    [control1 addTarget:self action:@selector(controlSelected:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control1];
    
    control2 = [[CommunityHomeControl alloc] initWithPoint:CGPointMake(0.0f, control1.frame.origin.y + control1.frame.size.height + CellVerticalSpace) sizeType:BIGSIZE];
    control2.tag = 2;
    control2.layer.masksToBounds=YES;
    control2.layer.cornerRadius=12;
    control2.backgroundColor = [UIColor colorWithHexValue:0xFFE95513];
    [control2 setImage:[UIImage imageNamed:@"首页投诉报修"] title:@"投诉报修"];
    [control2 addTarget:self action:@selector(controlSelected:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control2];
    
    control3 = [[CommunityHomeControl alloc] initWithPoint:CGPointMake(control2.frame.origin.x + control1.frame.size.width + CellHorizontalSpace, control1.frame.origin.y + control1.frame.size.height + CellHorizontalSpace) sizeType:MIDDLESIZE];
    control3.tag = 3;
    control3.layer.masksToBounds=YES;
    control3.layer.cornerRadius=12;
//    control3.backgroundColor = [UIColor colorWithHexValue:0xFFFFBC00];
    [control3 setImage:[UIImage imageNamed:@"首页缴物业费"] title:@"物业缴费"];
    control3 .backgroundColor=RGBA(242, 139, 35, 1);
    [control3 addTarget:self action:@selector(controlSelected:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control3];
    
    
    control4 = [[CommunityHomeControl alloc] initWithPoint:CGPointMake(control2.frame.origin.x + control1.frame.size.width + CellHorizontalSpace, control3.frame.origin.y + control3.frame.size.height + CellVerticalSpace) sizeType:MIDDLESIZE];
    control4.tag = 4;
    control4.layer.masksToBounds=YES;
    control4.layer.cornerRadius=12;
//    control4.backgroundColor = [UIColor colorWithHexValue:0xFF8DC21F];
    control4.backgroundColor=RGBA(242, 139, 35, 1);
    [control4 setImage:[UIImage imageNamed:@"首页_停车缴费"] title:@"停车缴费"];
    [control4 addTarget:self action:@selector(controlSelected:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control4];
    
    
//    adsView = [[AdsView alloc] initWithFrame:CGRectMake(0.0f, control4.frame.origin.y + control4.frame.size.height + CellVerticalSpace, ViewWidth, ViewWidth / 2) withController:self];
//    adsView.delegate=self;
//    adsView.backgroundColor = [UIColor clearColor];
//    [scrollView addSubview:adsView];

    
    welcomeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, control4.frame.origin.y + control4.frame.size.height + CellVerticalSpace, ViewWidth, ViewWidth / 2)];
    welcomeImage.image=[UIImage imageNamed:@"home_welcome_1"];
    welcomeImage.layer.masksToBounds=YES;
    welcomeImage.layer.cornerRadius=5;
    [scrollView addSubview:welcomeImage];
    
    welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 35.0f, 200.0f, 80.0f)];
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.font = [UIFont systemFontOfSize:16.0f];
    welcomeLabel.numberOfLines = 0;
    [welcomeImage addSubview:welcomeLabel];
    [self add];
    
    [self defaultRecommend];
//    [self getHomeRecommendnew];
    
    float y;
    for (int i = 5; i < 9; i ++) {
        CommunityHomeControl *control = [[CommunityHomeControl alloc] initWithPoint:CGPointMake((SmallSize.width + CellHorizontalSpace) * (i - 5), control4.frame.origin.y + control4.frame.size.height + CellVerticalSpace + ViewWidth / 2 + CellVerticalSpace) sizeType:SMALLSIZE];
        control.tag = i;
        control.layer.masksToBounds=YES;
        control.layer.cornerRadius=12;
        [control addTarget:self action:@selector(controlSelected:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:control];
        
        if (i == 5) {
            control.backgroundColor = [UIColor colorWithHexValue:0xFF009FE8];
            [control setImage:[UIImage imageNamed:@"shhy"] title:@"表扬物业"];
        } else if (i == 6) {
            control.backgroundColor = [UIColor colorWithHexValue:0xFFE95513];
            [control setImage:[UIImage imageNamed:@"sqhd"] title:@"社区活动"];
        } else if (i == 7) {
            control.backgroundColor = [UIColor colorWithHexValue:0xFFFFBC00];
            [control setImage:[UIImage imageNamed:@"新购物车"] title:@"我要团购"];
        } else if (i == 8) {
            control.backgroundColor = [UIColor colorWithHexValue:0xFF8DC21F];
            [control setImage:[UIImage imageNamed:@"zbyh_discount"] title:@"周边优惠"];
        }
        y = control.frame.origin.y + control.frame.size.height + 2 * CellVerticalSpace;
    }
    scrollView.contentSize = CGSizeMake(ViewWidth, y);
    if ([self didLogin]) {
        [self isfee];
    }
     [self getHomeRecommend];
//    [self downLoad];
//    [self getHomeRecommendnew];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(successChangeCommunity)
                                                 name:kChangeCommunity
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(successDownloadAvatar)
                                                 name:kDownloadAvatar
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLogout)
                                                 name:kUserLogout
                                               object:nil];
}

//userPassword    
#pragma mark request methods
-(void)songJiFenRequest{
    
    NSString *phoneS = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneMHP"];
    
//    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"activityId", nil];
    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:
                               [AppSetting userPassword], @"password",
                               phoneS, @"telephone",
                               [NSNumber numberWithInt:1], @"from",
                               [AppSetting deviceToken] == nil ? @"12345" : [AppSetting deviceToken], @"token", nil];
    NSLog(@"user====%@",user);

    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:kUserLoginURL];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=800;
        request.delegate=self;
        [request startAsynchronous];
    }
    
    
}


- (NSInteger)numberOfPages
{
    return [_AdData count];
}
-(void)add{
    long long time = [[CommunityDbManager sharedInstance] queryAdsUpdateTimeMax:YES communityId:[AppSetting communityId]];
    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          [NSString stringWithFormat:@"%d", 0], @"updateTime",nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:kGetHomeRecommendURL];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=300;
        request.delegate=self;
        [request startAsynchronous];
    }
}
- (UIView *)pageAtIndex:(NSInteger)index
{
//    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth/2)];
//    imageView1.image=[UIImage imageNamed:@"home_welcome_0"];
    //        NSString *str1=[_dataArr objectAtIndex:index];
    //        NSURL *url1=[NSURL URLWithString:str1];
    //        [imageView1 setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"1.png"]];
//    return imageView1;
    if (_AdData!=nil||!_AdData) {
        UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth/2)];
        NSString *str1=[[_AdData objectAtIndex:index]objectForKey:@"picture"];
        NSURL *url1=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,str1]];
        [imageView1 setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"home_welcome_1"]];
        return imageView1;
        
        //        UIImageView *imageView=[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 90)]autorelease];
        //        NSString *str=[_dataArr objectAtIndex:index];
        //        NSURL *url=[NSURL URLWithString:str];
        //        UIImage *img=[[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]]autorelease];
        //        imageView.image=img;
        //        return imageView;
    }if (_AdData==nil) {
        UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth/2)];
        [imageView1 setImage:[UIImage imageNamed:@"home_welcome_1"]];
        return imageView1;
    }else{
        return 0;
    }
    
}

-(void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    if ([[[_AdData objectAtIndex:index]objectForKey:@"picture"]isEqualToString:@""]) {
        return;
        
    }else{
        if ([[[_AdData objectAtIndex:index]objectForKey:@"content"]isEqualToString:@"ms"]) {
            FirstPageController *fv=[FirstPageController new];
            fv.hidesBottomBarWhenPushed=YES;
            fv.urlStr=[[_AdData objectAtIndex:index]objectForKey:@"html"];
            [self.navigationController pushViewController:fv animated:YES];
        }else{
            if ([[[_AdData objectAtIndex:index]objectForKey:@"html"]isEqualToString:@""]) {
                return;
            }else{
                FirstPageWebViewController *fv=[FirstPageWebViewController new];
                fv.hidesBottomBarWhenPushed=YES;
                fv.urlStr=[[_AdData objectAtIndex:index]objectForKey:@"html"];
                [self.navigationController pushViewController:fv animated:YES];
                
            }
        }
    }

//     NSLog(@"str===%@\n5t,content===%@",[[_AdData objectAtIndex:index]objectForKey:@"picture"],[[_AdData objectAtIndex:index]objectForKey:@"content"]);
//    if ([[[_AdData objectAtIndex:index]objectForKey:@"html"]isEqualToString:@""]) {
//        return;
//        
//
//    }
////    if ([[[_AdData objectAtIndex:index]objectForKey:@"content"]isEqualToString:@""]) {
////        return;
////    }
//    if([[[_AdData objectAtIndex:index]objectForKey:@"content"]isEqualToString:@"ms"]){
//        FirstPageController *fv=[FirstPageController new];
//        fv.hidesBottomBarWhenPushed=YES;
//        fv.urlStr=[[_AdData objectAtIndex:index]objectForKey:@"html"];
//        [self.navigationController pushViewController:fv animated:YES];
//        
//    }
//    else{
//
//        FirstPageWebViewController *fv=[FirstPageWebViewController new];
//        fv.hidesBottomBarWhenPushed=YES;
//        fv.urlStr=[[_AdData objectAtIndex:index]objectForKey:@"html"];
//        [self.navigationController pushViewController:fv animated:YES];
//    }
    
    
   
    
    
}

-(void)isfee{
    NSDictionary *user = [[NSDictionary alloc]init];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:isFee];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=200;
        request.delegate=self;
        [request startAsynchronous];
    }

    
    
}
-(void)pushtoController{
    FirstPageController *fv=[FirstPageController new];
    [self.navigationController pushViewController:fv animated:YES];
    NSLog(@"12345");
    
}
-(void)pushAdView{
    FirstPageController *fv=[FirstPageController new];
    [self.navigationController pushViewController:fv animated:YES];
    NSLog(@"2312");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self changBackgroundViewFrame];
    
    //进入主页则判断是否登录，，如果登录则调用送积分接口
    NSLog(@"已经登陆则调接口判断送积分----11-----");

    if ([self didLogin]) {
        NSLog(@"已经登陆则调接口判断送积分----22-----");
        
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!checkUpdate && [AppSetting alertAppCheckUpdate]) {
        [self checkUpdate];
    }
    if ([AppSetting newestNoticeChecked]) {
        [control1 setNotice:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)controlSelected:(UIControl *)sender
{
    NSLog(@"已经登陆则调接口判断送积分------=00---");

    // 判断是否登陆
    if (![self didLogin]) {
        LoginController *controller = [[LoginController alloc] init];
        CommunityNavigationController *navController = [[CommunityNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:NO completion:nil];
        return;
    }
    else{
        NSLog(@"已经登陆则调接口判断送积分------99---");

        
    }
    if (![self didUpdatedUserInfo]) {
        [self enterUpdateUserInfoView];
        return;
    }
    switch (sender.tag) {
        case 1:{
            if (!newestNotice || [AppSetting newestNoticeChecked]) {
                return;
            }
            
            //最新通知看过之后就不在显示了
            [AppSetting saveNewestNoticeChecked:YES];
            
            XQTZ_DetailController *controller = [XQTZ_DetailController new];
            controller.notice = newestNotice;
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:{
            TSBXController *controller = [TSBXController new];
            controller.title = @"投诉报修";
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case 3:{
            if (checkIsFee==YES) {
                WYJF_WYController *controller = [WYJF_WYController new];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }else{
                [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"该小区暂未开通此功能"];
                
            }
            
        }
            break;
            
        case 4:{
            if (checkIsFee==YES) {
                [self didTCJFAction];
            }else{
                [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"该小区暂未开通此功能"];

            }
            
        }
            break;
            
        case 5:
        {
//            SHHYController *controller = [SHHYController new];
//            controller.title = @"生活黄页";
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
            PraiseViewController *controller = [PraiseViewController new];
            controller.title = @"表扬物业";
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case 6:{
//            社区活动入口    发版本前必须条换
            
            [self homedownM];
            
//            NewActivityViewController *controller = [NewActivityViewController new];
//            controller.title = @"社区活动";
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
            
        case 7:{
//            XQTZController *controller = [XQTZController new];
//            controller.title = @"小区通知";
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
            [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"该功能尚未开通"];
            return;
             detailTuanViewController *controller = [detailTuanViewController new];
            controller.title = @"我的团购";
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];

        }
            break;
            
        case 8:{
            ZBYHController *controller = [ZBYHController new];
            controller.title = @"周边优惠";
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
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
        request.tag=400;
        request.delegate=self;
        [request startAsynchronous];
        
    }
    
    
}


- (void)defaultRecommend
{
    int x = arc4random() % 2;
    if (x == 0) {
        welcomeImage.image = [UIImage imageNamed:@"home_welcome_0"];
        welcomeLabel.text = @"益社区iPhone客户端\n\n缴费更优惠";
    } else if (x == 1) {
        welcomeImage.image = [UIImage imageNamed:@"home_welcome_1"];
        welcomeLabel.text = @"欢迎使用益社区\n\n       iPhone客户端";
    }
}

- (void)getHomeRecommend
{
    if ([AppSetting communityId] == ILLEGLE_COMMUNITY_ID) {
        return;
    }
    [adsView loadAdArray:[[CommunityDbManager sharedInstance] queryAds:[AppSetting communityId] type:1]];
    
    long long time = [[CommunityDbManager sharedInstance] queryAdsUpdateTimeMax:YES communityId:[AppSetting communityId]];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                          [NSString stringWithFormat:@"%lld", time], @"after",
                          [NSString stringWithFormat:@"%d", 0], @"updateTime",nil];
    
    [[HttpClientManager sharedInstance] getHomeRecommendWithDict:dict
                                                        complete:^(BOOL newAds, int result, NoticeInfo *notice) {
                                                            if (result == RESPONSE_SUCCESS) {
                                                                if ([self showNewestNotice:notice.noticeId]) {
                                                                    newestNotice = notice;
                                                                    [control1 setNotice:newestNotice];
                                                                    
                                                                }
                                                            }
                                                            if ([[CommunityDbManager sharedInstance] queryAds:[AppSetting communityId] type:1].count > 0) {
                                                                welcomeImage.hidden = YES;
                                                                [adsView loadAdArray:[[CommunityDbManager sharedInstance] queryAds:[AppSetting communityId] type:1]];
                                                            } else {
                                                                if (welcomeImage.hidden == YES) {
                                                                    welcomeImage.hidden = NO;
                                                                    [self defaultRecommend];
                                                                }
                                                            }
     }];
}
- (void)didTCJFAction
{
    UserParkingController *controller = [UserParkingController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)checkUpdate
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSArray *numArray = [version componentsSeparatedByString:@"."];
    NSString *versionNumber = [[NSString alloc] init];
    for (NSString *num in numArray) {
        versionNumber = [versionNumber stringByAppendingString:num];
    }
    int v = [versionNumber intValue];
    //loginFrom==1表示iphone用户
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:v], @"version", [NSNumber numberWithInt:1], @"loginFrom", nil];
    [[HttpClientManager sharedInstance] checkUpdateWithDict:dict
                                                   complete:^(BOOL success, CheckUpdateResponse *resp) {
                                                       if (success) {
                                                           checkUpdate = YES;
                                                           if (resp.latestVersion > v) {
                                                               [self alertView:resp];
                                                           }
                                                       }
                                                   }
     ];
    
}

- (void)alertView:(CheckUpdateResponse *)resp
{
    if (resp.result == RESPONSE_FORCE_UPDATE) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:resp.versionName
                                                            message:resp.description
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"更       新", nil];
        alertView.tag = 1;
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:resp.versionName
                                                            message:resp.description
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"下次提醒", @"不在提醒", @"更       新", nil];
        alertView.tag = 2;
        [alertView show];
    }
}

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            //跳转itunes
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppItunesURL]];
        }
    } else {
        if (buttonIndex == 1) {
            [AppSetting saveAppCheckUpdate:NO];
        } else if (buttonIndex == 2) {
            //跳转itunes
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppItunesURL]];
        }
    }
}

- (BOOL)showNewestNotice:(long long)noticeId
{
    if (noticeId != [AppSetting newestNoticeId]) {
        [AppSetting saveNewestNoticeId:noticeId];
        [AppSetting saveNewestNoticeChecked:NO];
        return YES;
    } else {
        if (![AppSetting newestNoticeChecked]) {
            return YES;
        }
    }
    return NO;
}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]init];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:getMSYAdvertise];
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
    NSLog(@"OK!!");
    if (request.tag==100) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        NSMutableArray *addArr=[[NSMutableArray alloc]init];
        if ([result isEqualToString:@"1"]) {
            AdInfo *ad=[[AdInfo alloc]init];
            for (int i=0; i<[[dic objectForKey:@"advertise"] count]; i++) {
                NSString *str123=[[[dic objectForKey:@"advertise"]objectAtIndex:i]objectForKey:@"pic"];
                ad.picture=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,str123];
                //            [NSString stringWithFormat:@"%@%@",kCommunityImageServer,[[[dic objectForKey:@"advertise"]objectForKey:@"pic"] stringValue]]
                
                [addArr addObject:ad];
            }
            //        NSArray *addArr1=addArr;
            [adsView loadAdArray:addArr];
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
            
        }

    }if (request.tag==200) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            if ([[dic objectForKey:@"isFee"]intValue]==0) {
//                [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"该功能暂未开通"];
                checkIsFee=NO;
                
            }else{
                checkIsFee=YES;
                
            }
            
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        }

    }
    if (request.tag==300) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"300===%@",dic);
        int result=[[dic objectForKey:@"result"]intValue];
        NSLog(@"%@",[dic objectForKey:@"list"]);
        if (result==1) {
            if ([[dic objectForKey:@"list"] count]>0) {
                _AdData=[dic objectForKey:@"list"];
                xlCycleScroll = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, control4.frame.origin.y + control4.frame.size.height + CellVerticalSpace+35-35, ViewWidth, ViewWidth / 2)];
                xlCycleScroll.delegate = self;
                xlCycleScroll.datasource = self;
                xlCycleScroll.layer.masksToBounds=YES;
                xlCycleScroll.layer.cornerRadius=5;
                xlCycleScroll.tag=10000;
                [scrollView addSubview:xlCycleScroll];

            }
            
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        }
        
    }
    if (request.tag==400) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"dicMHP===%@",dic);
        int result=[[dic objectForKey:@"result"]intValue];
        if (result==1) {
            NewActivityViewController *controller = [NewActivityViewController new];
            controller.title = @"社区活动";
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else
        {

                ActivityEmptyViewController *controller = [ActivityEmptyViewController new];
//                controller.title = @"社区活动";
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];


        }
        
    }
    if (request.tag==800) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"dicMHP===%@",dic);
        int result=[[dic objectForKey:@"result"]intValue];
        if (result==1) {
            NSLog(@"送积分-------");
            
//            UILabel *redLabe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)] ;
//            redLabe.backgroundColor = [UIColor redColor];
//            [scrollView addSubview:redLabe];
 
        }else
        {
            
            NSLog(@"不送积分");
            
        }
        
    }

    
    
}

#pragma mark NSNotificationCenter methods
- (void)successChangeCommunity
{
    [self getHomeRecommend];
}

- (void)successDownloadAvatar
{
    [headerView refreshAvatar];
}

- (void)userLogout
{
    [headerView refreshAvatar];
    
    newestNotice = nil;
    [control1 setNotice:newestNotice];
    if (welcomeImage.hidden == YES) {
        welcomeImage.hidden = NO;
        [self defaultRecommend];
    }
}

/*天气模块定位,解析xml,获取天气
#pragma mark MKMapViewDelegate methods
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocation *newLocation = userLocation.location;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && newLocation) {
        CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
        CLGeocodeCompletionHandler handle = ^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                NSString *city = nil;
                if (placemark.locality != nil) {
                    city = placemark.locality;
                } else {  //有可能是直辖市的情况
                    city = placemark.administrativeArea;
                }
                NSRange range = [city rangeOfString:@"市"];
                if (range.location != NSNotFound) {
                    city = [city substringToIndex:range.location];
                }
                [AppSetting saveLoactionCity:city];
                [self parseCitys];
            }
            map.showsUserLocation = NO;
        };
        [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
    } else {
        map.showsUserLocation = NO;
    }
}

#pragma mark NSXMLParserDelegate method
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"city"]) {
        NSString *string = [attributeDict JSONString];
        CityInfo *city = [EzJsonParser deserializeFromJson:string asType:[CityInfo class]];
        if ([city.name isEqualToString:[AppSetting locationCity]]) {
            cityId = city.cityId;
            return;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {}

//解析错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {}

//xml解析完成
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [[HttpClientManager sharedInstance] getIntimeWeather:cityId
                                                complete:^(NSString *_temp) {
                                                    [headerView setTemp:_temp];
                                                    
    }];
}

- (void)parseCitys
{
    NSString * cityPath =[[NSBundle mainBundle] pathForResource:@"Citys" ofType:@"xml"];
    NSData *citysData = [NSData dataWithContentsOfFile:cityPath];
    
    //解析xml文件内容
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:citysData];
    [parser setDelegate:self];
    [parser parse];
}*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kChangeCommunity
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kDownloadAvatar
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kUserLogout
                                                  object:nil];
}

@end