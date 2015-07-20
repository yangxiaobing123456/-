//
//  CommunitySplashController.m
//  Community
//
//  Created by SYZ on 13-12-9.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunitySplashController.h"

@interface CommunitySplashController ()
{
    NSURL *imageurl;
    
}
@end

@implementation CommunitySplashController

- (id)init
{
    self = [super init];
    if (self) {
        
        [self homedown];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // maomao
    //   [self homedown];
    
    //    UIImageView *whiteBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-80)];
    //    whiteBg.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:whiteBg];
    //
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:5];
    //    whiteBg.alpha = 0;
    //    [UIView commitAnimations];
    
    adView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:adView];
    
    adView1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:adView1];
    
    backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    if (iPhone5) {
        backgroundView.image = [UIImage imageNamed:@"引导页m1136.png"];
    } else {
        backgroundView.image = [UIImage imageNamed:@"引导页m960.png"];
    }
    [self.view addSubview:backgroundView];
    
    //
    //    contentView = [[UIView alloc] initWithFrame:CGRectMake(116.0f, 35.0f, 93.0f, 92.0f)];
    //    contentView.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:contentView];
    //
    //    logoPart1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 5.0f, 39.0f, 51.0f)];
    //    logoPart1.image = [UIImage imageNamed:@"logo_part_1"];
    ////    [contentView addSubview:logoPart1];
    //
    //    logoPart2 = [[UIImageView alloc] initWithFrame:CGRectMake(38.0f, 0.0f, 51.0f, 39.0f)];
    //    logoPart2.image = [UIImage imageNamed:@"logo_part_2"];
    ////    [contentView addSubview:logoPart2];
    //
    //    logoPart3 = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 53.0f, 51.0f, 39.0f)];
    //    logoPart3.image = [UIImage imageNamed:@"logo_part_3"];
    ////    [contentView addSubview:logoPart3];
    //
    //    logoPart4 = [[UIImageView alloc] initWithFrame:CGRectMake(54.0f, 36.0f, 39.0f, 51.0f)];
    //    logoPart4.image = [UIImage imageNamed:@"logo_part_4"];
    ////    [contentView addSubview:logoPart4];
    //
    //    UIBezierPath *onePath = [UIBezierPath bezierPath];
    //    [onePath moveToPoint:CGPointMake(-116.0f, -35.0f)];
    //    [onePath addQuadCurveToPoint:CGPointMake(19.5f, 30.5f) controlPoint:CGPointMake(-90.0f, -10.0f)];
    //
    //    //关键帧动画（位置）
    //    CAKeyframeAnimation *oneAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    oneAnim.path = onePath.CGPath;
    //    oneAnim.delegate = self;
    //    oneAnim.duration = 0.5f;
    //    oneAnim.removedOnCompletion = YES;
    //
    ////    [logoPart1.layer addAnimation:oneAnim forKey:@"one"];
    //
    //    UIBezierPath *twoPath = [UIBezierPath bezierPath];
    //    [twoPath moveToPoint:CGPointMake(364.0f, -35.0f)];
    //    [twoPath addQuadCurveToPoint:CGPointMake(63.5f, 19.5f) controlPoint:CGPointMake(250.0f, -20.0f)];
    //
    //    CAKeyframeAnimation *twoAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    twoAnim.path = twoPath.CGPath;
    //    twoAnim.delegate = self;
    //    twoAnim.duration = 0.5f;
    //    twoAnim.removedOnCompletion = YES;
    //
    ////    [logoPart2.layer addAnimation:twoAnim forKey:@"two"];
    //
    //    UIBezierPath *threePath = [UIBezierPath bezierPath];
    //    [threePath moveToPoint:CGPointMake(-116.0f, 445.0f)];
    //    [threePath addQuadCurveToPoint:CGPointMake(30.5f, 72.5f) controlPoint:CGPointMake(-70.0f, 320.0f)];
    //
    //    CAKeyframeAnimation *threeAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    threeAnim.path = threePath.CGPath;
    //    threeAnim.delegate = self;
    //    threeAnim.duration = 0.5f;
    //    threeAnim.removedOnCompletion = YES;
    //
    ////    [logoPart3.layer addAnimation:threeAnim forKey:@"three"];
    //
    //    UIBezierPath *fourPath = [UIBezierPath bezierPath];
    //    [fourPath moveToPoint:CGPointMake(364.0f, 445.0f)];
    //    [fourPath addQuadCurveToPoint:CGPointMake(73.5f, 61.5f) controlPoint:CGPointMake(100.0f, 230.0f)];
    //
    //    CAKeyframeAnimation *fourAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    fourAnim.path = fourPath.CGPath;
    //    fourAnim.delegate = self;
    //    fourAnim.duration = 0.5f;
    //    fourAnim.removedOnCompletion = YES;
    //
    //    [logoPart4.layer addAnimation:fourAnim forKey:@"four"];
    
    [self getUserInfo];
}

#pragma mark request methods
-(void)homedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:Getqidongguanggao];
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
    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络不给力啊"];
    
    [self qiSiHuiSheng];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"dic==%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        NSArray *ad=[dic objectForKey:@"ad"];

        if ([result isEqualToString:@"1"]&&ad.count==0) {
            [self qiSiHuiSheng];
            return;

        }
        else{
             NSString *picture=[[[dic objectForKey:@"ad"] objectAtIndex:0] objectForKey:@"picture"];
            
            imageurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,picture]];
            //  /*   */          [adView1 setImageWithURL:imageurl];
/*   本地沙盒存储还没有做， 有待优化
            NSLog(@"picture===%@",picture);
            NSUserDefaults *mmuser=[NSUserDefaults standardUserDefaults];
            //[mmuser setObject:newadvert.picture forKey:@"myKey"];
            NSString *value = [mmuser objectForKey:@"myKey"];
            
            if ((!value||[value isEqualToString:@""])&&(!picture||![picture isEqualToString:@""])) {
                [mmuser setObject:picture forKey:@"myKey"];
                [self test:picture];
                
            }else if([picture isEqualToString:value]){
                
            }else if(![picture isEqualToString:value]){
                [mmuser setObject:picture forKey:@"myKey"];
                if([picture isEqualToString:@""]){
                    NSFileManager *fileManage = [NSFileManager defaultManager];
                    [fileManage removeItemAtPath:pngFilePath error:nil];
                    
                }else{
                    [self test:picture];
                }
           }
*/
            
        }
        
        float delay = 0.0f;
        if ([self readAd]) {
            //广告时间
            NSLog(@"广告时间3秒");
            delay = 3.0f;
            [UIView animateWithDuration:0.1f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 backgroundView.alpha = 0.0f;
                                 contentView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     [self performSelector:@selector(enterToMainPage) withObject:nil afterDelay:delay];
                                 }
                             }];
        } else {
            [self performSelector:@selector(enterToMainPage) withObject:nil afterDelay:delay];
        }
        
    }
    
}

//开机动画
-(void)test:(NSString *)Pictureurl{
    
    NSLog(@"Downloading…");
    // Get an image from the URL below
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://image.yicommunity.cn%@",Pictureurl]]]];
    adView1.image = image;
    
    NSLog(@"%@huanghao",[NSString stringWithFormat:@"http://image.yicommunity.cn%@",Pictureurl]);
    NSLog(@"%f,%f",image.size.width,image.size.height);
    
    // Let’s save the file into Document folder.
    // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
    // NSString *deskTopDir = @”/Users/kiichi/Desktop”;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // If you go to the folder below, you will find those pictures
    NSLog(@"%@",docDir);
    
    NSLog(@"saving png");
    pngFilePath = [NSString stringWithFormat:@"%@/mao.png",docDir];
    NSLog(@"huanghao%@",pngFilePath);
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [data1 writeToFile:pngFilePath atomically:YES];
    
    //    NSLog(@"saving jpeg");
    //    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/test.jpeg",docDir];
    //    NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
    //    [data2 writeToFile:jpegFilePath atomically:YES];
    
    NSLog(@"saving image done");
    
    //[image release];
    
}

-(BOOL)guanggaoisExist{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"huanghao%@",pngFilePath);
    if(![fileManager fileExistsAtPath:pngFilePath]) //如果不存在
        
    {
        return NO;
    }else{
        return YES;
    }
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserInfo
{
    if ([AppSetting userId] == ILLEGLE_USER_ID) {
        return;
    }
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithLongLong:user.updateTime] forKey:@"updateTime"];
    [[HttpClientManager sharedInstance] getProfileWithDict:dict complete:nil];
}

- (void)qiSiHuiSheng
{
   adView1.image = [UIImage imageNamed:iPhone5 ?@"splash1136.png":@"splash960"];
//    adView1.image = [UIImage imageNamed:iPhone5 ? @"guide_iphone59":@"guide_iphone49"];
    
    [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        backgroundView.alpha = 0.0f;
        contentView.alpha = 0.0f;

    } completion:^(BOOL finished) {
        [self performSelector:@selector(enterToMainPage) withObject:nil afterDelay:2.0];

    }];
}
//读取广告
- (BOOL)readAd
{
    NSLog(@"每次必须进入方法----------33--------");

    NSLog(@"imageurl===%@",imageurl);
//    UIImage *imga = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:imageurl]];
//    adView.image=imga;
//    [adView setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"splash960"]];
    
    [adView setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:iPhone5 ?@"引导页m1136.png":@"引导页m960.png"]];

//    [adView setImageWithURL:imageurl];
    
    adView1.image = [UIImage imageNamed:iPhone5 ? @"guide_iphone59":@"guide_iphone49"];
    
    return YES;
}

- (void)enterToMainPage
{
    [contentView.layer removeAllAnimations];
    CommunityRootController *rootController = [CommunityRootController new];
    [self presentViewController:rootController animated:NO completion:nil];
}

#pragma mark CAAnimationDelegate methods
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{//此方法暂时废弃
    if (flag) {
        CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.delegate = self;
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:MAXFLOAT];
        fullRotation.duration = MAXFLOAT * 0.15;
        fullRotation.removedOnCompletion = YES;
        [contentView.layer addAnimation:fullRotation forKey:@"top"];
        
        float delay = 4.0f;
        if ([self readAd]) {
            delay = 4.0f;
            [UIView animateWithDuration:1.5f
                                  delay:1.5f
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 backgroundView.alpha = 0.0f;
                                 contentView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     [self performSelector:@selector(enterToMainPage) withObject:nil afterDelay:delay];
                                 }
                             }];
        } else {
            [self performSelector:@selector(enterToMainPage) withObject:nil afterDelay:delay];
        }
    }
}

@end
