//
//  FirstPageController.m
//  Community
//
//  Created by HuaMen on 14-11-19.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "FirstPageController.h"
#import "AnimatedView.h"
#import "UMSocial.h"
#import "KilllistViewController.h"

@interface FirstPageController (){
    UIImageView *headerImage;
    UILabel *label;
    UIWebView *webView;
    UIButton *btn;
}

@end

@implementation FirstPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"url====%@",_urlStr);
//    NSString *url=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,_urlStr];
//    UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [self.view addSubview:webView];
//    [webView loadRequest:request];
    [self customBackButton:self];

    
    
    
    headerImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [headerImage setBackgroundColor:[UIColor whiteColor]];
    headerImage.layer.shadowColor = [UIColor blackColor].CGColor;
    headerImage.layer.shadowOffset = CGSizeMake(4, 4);
    headerImage.layer.shadowOpacity = 0.5;
    headerImage.layer.shadowRadius = 2.0;
    [self.view addSubview:headerImage];
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 450)];
    [self.view addSubview:webView];
    
    
    
    UIImageView *greenImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, kNavContentHeight-50, self.view.bounds.size.width, 50)];
    [greenImage setBackgroundColor:[UIColor whiteColor]];
    [greenImage setAlpha:0.5];
    greenImage.layer.shadowColor = [UIColor blackColor].CGColor;
    greenImage.layer.shadowOffset = CGSizeMake(4, 4);
    greenImage.layer.shadowOpacity = 0.5;
    greenImage.layer.shadowRadius = 2.0;
    [self.view addSubview:greenImage];
    
    timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 110, 40)];
    [timeLabel setTextAlignment:YES];
    timeLabel.lineBreakMode=NSLineBreakByCharWrapping;
    timeLabel.numberOfLines=0;
    [timeLabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
    
    [timeLabel setTextColor:[UIColor orangeColor]];
    [greenImage addSubview:timeLabel];
    
    checkLabel =[[UILabel alloc]initWithFrame:CGRectMake(320-80, 5, 80, 40)];
    [checkLabel setTextAlignment:YES];
    checkLabel.lineBreakMode=NSLineBreakByCharWrapping;
    checkLabel.numberOfLines=0;
    [checkLabel setFont:[UIFont fontWithName:@"helvetica" size:11]];
    
    [checkLabel setTextColor:[UIColor orangeColor]];
    [greenImage addSubview:checkLabel];
    
//    UIButton *testbtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [testbtn setTitle:@"测试" forState:UIControlStateNormal];
//    testbtn.layer.masksToBounds=YES;
//    testbtn.layer.cornerRadius=5;
//    [testbtn setBackgroundImage:[UIImage imageNamed:@"秒杀按钮"] forState:UIControlStateNormal];
//    //    [btn setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:239.0/255.0 blue:0.0/255.0 alpha:1]];
//    [testbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [testbtn setFrame:CGRectMake(120+90, kNavContentHeight-40, 80, 20)];
//    [testbtn addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:testbtn];

    
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"马上抢" forState:UIControlStateNormal];
    btn.layer.masksToBounds=YES;
    [btn setEnabled:NO];
    btn.layer.cornerRadius=5;
    [btn setBackgroundImage:[UIImage imageNamed:@"秒杀按钮"] forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:239.0/255.0 blue:0.0/255.0 alpha:1]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(120, kNavContentHeight-40, 80, 20)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self down];
    [self check];
    
//    AnimatedView *view=[[AnimatedView alloc]initWithFrame:CGRectMake(120, 100, 50, 50)];
//    [self.view addSubview:view];
    
    
    


}
-(void)checkwithStr:(NSString *)str{
    NSDictionary *user=[[NSDictionary alloc]initWithObjectsAndKeys:str,@"secKillId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:checkComm];
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
        [btn setEnabled:NO];
        [request startAsynchronous];
    }

    
}
-(void)check{
    NSDictionary *user=[[NSDictionary alloc]init];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:checkRoomFee];
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
-(void)btnClick{
//    NSDictionary *user=[[NSDictionary alloc]initWithObjectsAndKeys:secIdStr,@"secKillId", nil];
//    if ([NSJSONSerialization isValidJSONObject:user])
//    {
//        NSError *error;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
//        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
//        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
//        NSURL *url = [NSURL URLWithString:kill];
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
//        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
//        [request addRequestHeader:@"Accept" value:@"application/json"];
//        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
//        NSLog(@"%lld",[AppSetting userId]);
//        [request addRequestHeader:@"Authorization" value:str];
//        [request setRequestMethod:@"POST"];
//        [request setPostBody:tempJsonData];
//        request.tag=400;
//        request.delegate=self;
//        [request startAsynchronous];
//    }
//    秒杀
//    for (int i=0; i<1000000; i++) {
        [self kills];
//    }
//
    [btn setEnabled:NO];
    
//    btn.userInteractionEnabled = NO;

    
}
-(void)kills{
    NSDictionary *user=[[NSDictionary alloc]initWithObjectsAndKeys:secIdStr,@"secKillId",[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:@"http://api.yicommunity.cn/SeckillQueue/seckill/queue"];
        //         NSURL *url = [NSURL URLWithString:@"http://115.29.251.197:8080/SeckillQueue/seckill/queue"];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=1000;
        request.delegate=self;
        [request startAsynchronous];
    }

    
}
-(void)down{
    NSDictionary *user=[[NSDictionary alloc]init];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:appSeckill];
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
    [btn setEnabled:YES];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"OK!!");
    if (request.tag==100) {
        NSLog(@"%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"0"]||[dic objectForKey:@"appSeckillVo"]==[NSNull null]||![dic objectForKey:@"appSeckillVo"]) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        }
       else {
            NSString *str=[[dic objectForKey:@"appSeckillVo"]objectForKey:@"startTime"];
            NSString *str1=[[dic objectForKey:@"appSeckillVo"]objectForKey:@"curTime"];
            [self dateChange:str withEndString:str1];
            [label setText:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"appSeckillVo"]objectForKey:@"content"]]];
            NSString *imagestr=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,[[dic objectForKey:@"appSeckillVo"]objectForKey:@"pic"]];
            [headerImage setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:[UIImage imageNamed:@"home_welcome_1"]];
//            [webView loadHTMLString:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"appSeckillVo"]objectForKey:@"content"]] baseURL:nil];
            NSString *Path = [[NSBundle mainBundle] pathForResource:@"seckill" ofType:@"css"];
            NSLog(@"path===%@",Path);
            NSString *bodyStr=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"appSeckillVo"]objectForKey:@"content"]];
            
            NSString *headStr=@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head>";
            NSString *midStr=@"<link rel=\"stylesheet\" href=\"seckill.css\" type=\"text/css\">";
            NSString *midStr2=@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><title></title><body>";
            NSString *endStr=@"</body></head></html>";
            NSString *htmlStr=[NSString stringWithFormat:@"%@%@%@%@%@",headStr,midStr,midStr2,bodyStr,endStr];
            NSLog(@"htmlStr=====%@",htmlStr);
//            [webView loadHTMLString:htmlStr baseURL:nil];
            NSData* htmlData = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
            secIdStr=[[dic objectForKey:@"appSeckillVo"]objectForKey:@"id"];
            webView.scalesPageToFit=YES;
            [webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
            [self checkwithStr:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"appSeckillVo"]objectForKey:@"id"]]];

        }
    }if (request.tag==200) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            if (![dic objectForKey:@"flag"]) {
                [checkLabel setText:@"请先交清2015年物业费"];
                
            }
        }
        else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        }
    }
    if (request.tag==300) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            if (![dic objectForKey:@"flag"]) {
                [checkLabel setText:@"该活动不在本小区"];
                
            }
        }
        else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        }
    }if (request.tag==400) {
        [btn setEnabled:YES];
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            if ([[dic objectForKey:@"flag"]isEqualToString:@"ok"]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:[NSString stringWithFormat:@"已秒杀"]
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//                [alert show];
                KilllistViewController *kv=[KilllistViewController new];
                kv.idStr=secIdStr;
                kv.telArr=[dic objectForKey:@"telephone"];
                [self.navigationController pushViewController:kv animated:YES];
            }if ([[dic objectForKey:@"flag"]isEqualToString:@"2"]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:[NSString stringWithFormat:@"已结束"]
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//                [alert show];
                KilllistViewController *kv=[KilllistViewController new];
                kv.idStr=secIdStr;
                [self.navigationController pushViewController:kv animated:YES];

            }if ([[dic objectForKey:@"flag"]isEqualToString:@"1"]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:[NSString stringWithFormat:@"未开始"]
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//                [alert show];
            }
        }
        else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        }

    }
    if (request.tag==1000) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            if ([[dic objectForKey:@"flag"]isEqualToString:@"ok"]) {
                KilllistViewController *kv=[KilllistViewController new];
                kv.idStr=secIdStr;
                kv.telArr=[dic objectForKey:@"telephone"];
                kv.isSuccess=@"ok";
                [self.navigationController pushViewController:kv animated:YES];

                
            }if ([[dic objectForKey:@"flag"]isEqualToString:@"2"]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:[NSString stringWithFormat:@"已结束"]
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//                [alert show];
                KilllistViewController *kv=[KilllistViewController new];
                kv.idStr=secIdStr;
                kv.isSuccess=@"fail";
                kv.telArr=[dic objectForKey:@"telephone"];
                [self.navigationController pushViewController:kv animated:YES];
            }if ([[dic objectForKey:@"flag"]isEqualToString:@"0"]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:[NSString stringWithFormat:@"未开始"]
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//                [alert show];
                [self kills];
            }
            if ([[dic objectForKey:@"flag"]isEqualToString:@"exist"]) {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                message:[NSString stringWithFormat:@"您已经秒杀过啦"]
                                                                               delegate:self
                                                                      cancelButtonTitle:@"确定"
                                                                      otherButtonTitles:nil];
                                [alert show];
                KilllistViewController *kv=[KilllistViewController new];
                kv.idStr=secIdStr;
                kv.telArr=[dic objectForKey:@"telephone"];
                kv.isSuccess=@"had";
                [self.navigationController pushViewController:kv animated:YES];
            }

            
        }
        else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"秒杀失败，下次再来吧"];

        }
        
        
    }


}
-(void)dateChange:(NSString *)curentStr withEndString:(NSString *)endStr{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSDate *date = [formatter dateFromString:@"1283376197"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[curentStr longLongValue]/1000];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[endStr longLongValue]/1000];
    NSLog(@"时间   date:%@    date1:%@",date,date1);
    long dd = (long)[date timeIntervalSince1970] - (long)[date1 timeIntervalSince1970];
    time=dd;
    [self startTimer];
    
    NSLog(@"%ld",dd/86400);
//    [timeLabel setText:[NSString stringWithFormat:@"%ld",dd/86400]];
}
- (void)startTimer
{
    if(timer == nil){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer
{
    if(timer != nil)
        [timer invalidate];
    timer = nil;
    time = 0;
    [btn setEnabled:YES];
    
    
    
}

- (void)timerFired:(NSTimer *)_timer
{
    if (time >= 0) {
        time --;
        NSLog(@"time==%ld",time);
        int day=(int)time/86400;
        int hour=(int)time/3600%24;
        int min=(int)time/60%60;
        int sec=(int)time%60;
//        NSLog(@"%d天 %d小时 %d分钟 %d秒 ",day,hour,min,sec);
        [timeLabel setText:[NSString stringWithFormat:@"%d天%d小时%d分钟%d秒",day,hour,min,sec]];
        if (time<5) {
            [btn setEnabled:YES];
        }
    } else {
        [self stopTimer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
