//
//  TS_pingjiaViewController.m
//  Community
//
//  Created by HuaMen on 14-10-20.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "TS_pingjiaViewController.h"
#import "TSBXHistroyController.h"
#define ViewWidth       304.0f
#define LeftMargin      8.0f
#define addHeatch       210.0f
#define addWitdth       160.0f
#define witdth          150.0f
#define addSubHeatch    80.0f

@interface TS_pingjiaViewController ()

@end

@implementation TS_pingjiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请评价我们的服务";
    [self customBackButton:self];
    [self downLoad];
    NSLog(@"1111");
    str1=@"0";
    str2=@"0";
    str3=@"0";
    str4=@"0";
    str5=@"0";
    str6=@"0";
    str7=@"0";
    str8=@"5";
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, ViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, -kNavigationBarPortraitHeight, kContentWidth, kContentHeight)];
    scrollView.pagingEnabled = NO;
    scrollView.contentInset = UIEdgeInsetsMake(44.0f, 0.0f, 0.0f, 0.0f);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, kContentWidth, kContentHeight)];
    [control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:control];
    
    
    UIImageView *wImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 20.0f, ViewWidth, 40)];
    [wImage setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:wImage];
    
    headimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4确认订单_03.png"]];
    [headimage setBackgroundColor:[UIColor greenColor]];
    
    headimage.frame = CGRectMake(5.f, 2.f, 36.f, 36.f);
    headimage.layer.masksToBounds = YES;
    headimage.layer.cornerRadius = 18;
    [wImage addSubview:headimage];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.f, 2.f, 100, 36.f)];
    nameLabel.text = @"";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:13.0f];
    [wImage addSubview:nameLabel];
    
    jibieLabel = [[UILabel alloc] initWithFrame:CGRectMake(150.f, 2.f, 110.f, 36.f)];
    jibieLabel.text = @"";
    jibieLabel.textColor = [UIColor blackColor];
    jibieLabel.backgroundColor = [UIColor clearColor];
    jibieLabel.font = [UIFont systemFontOfSize:13.0f];
    [wImage addSubview:jibieLabel];
    
    jibieImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"报修评价_03.png"]];
    [jibieImage setBackgroundColor:[UIColor greenColor]];
    jibieImage.frame = CGRectMake(265.f, 2.f, 36.f, 36.f);
    //    imageView1.layer.masksToBounds = YES;
    //    imageView1.layer.cornerRadius = 18;
    [wImage addSubview:jibieImage];


    
//    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.f, 2.f, 80, 36.f)];
//    nameLabel.text = @"管家:吴成影";
//    nameLabel.textColor = [UIColor blackColor];
//    nameLabel.backgroundColor = [UIColor whiteColor];
//    nameLabel.font = [UIFont systemFontOfSize:14.0f];
//    [wImage addSubview:nameLabel];
//    
//    jibieLabel = [[UILabel alloc] initWithFrame:CGRectMake(130.f, 2.f, 130.f, 36.f)];
//    jibieLabel.text = @"管家级别:金牌管家";
//    jibieLabel.textColor = [UIColor blackColor];
//    jibieLabel.backgroundColor = [UIColor clearColor];
//    jibieLabel.font = [UIFont systemFontOfSize:14.0f];
//    [wImage addSubview:jibieLabel];
//    
//    jibieImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4确认订单_03.png"]];
//    [jibieImage setBackgroundColor:[UIColor greenColor]];
//    jibieImage.frame = CGRectMake(265.f, 2.f, 36.f, 36.f);
//    //    imageView1.layer.masksToBounds = YES;
//    //    imageView1.layer.cornerRadius = 18;
//    [wImage addSubview:jibieImage];

    
    UILabel *sqaqLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f+addSubHeatch, witdth, 20.0f)];
    sqaqLabel.text = @"是否事先沟通";
    sqaqLabel.textColor = [UIColor grayColor];
    sqaqLabel.backgroundColor = [UIColor clearColor];
    sqaqLabel.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:sqaqLabel];
    
    intimeSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f+addWitdth, 20.0f+addSubHeatch, 40.0f, 25.0f)];
    intimeSwitch.tag = 1;
    intimeSwitch.isRounded = YES;
    intimeSwitch.inactiveColor = [UIColor whiteColor];
    intimeSwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
    [intimeSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:intimeSwitch];
    
    
    UILabel *sqaqLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f+30+addSubHeatch, witdth, 20.0f)];
    sqaqLabel1.text = @"处理是否及时";
    sqaqLabel1.textColor = [UIColor grayColor];
    sqaqLabel1.backgroundColor = [UIColor clearColor];
    sqaqLabel1.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:sqaqLabel1];
    
    needMaterialSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f+addWitdth, 20.0f+30+addSubHeatch, 40.0f, 25.0f)];
    needMaterialSwitch.tag = 2;
    needMaterialSwitch.isRounded = YES;
    needMaterialSwitch.inactiveColor = [UIColor whiteColor];
    needMaterialSwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
    [needMaterialSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:needMaterialSwitch];

    UILabel *sqaqLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f+60+addSubHeatch, witdth, 20.0f)];
    sqaqLabel2.text = @"对处理态度是否满意";
    sqaqLabel2.textColor = [UIColor grayColor];
    sqaqLabel2.backgroundColor = [UIColor clearColor];
    sqaqLabel2.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:sqaqLabel2];
    
    attitudeSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f+addWitdth, 20.0f+60+addSubHeatch, 40.0f, 25.0f)];
    attitudeSwitch.tag = 3;
    attitudeSwitch.isRounded = YES;
    attitudeSwitch.inactiveColor = [UIColor whiteColor];
    attitudeSwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
    [attitudeSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:attitudeSwitch];
    
    UILabel *sqaqLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f+90+addSubHeatch, witdth, 20.0f)];
    sqaqLabel3.text = @"是否提供材料";
    sqaqLabel3.textColor = [UIColor grayColor];
    sqaqLabel3.backgroundColor = [UIColor clearColor];
    sqaqLabel3.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:sqaqLabel3];
    
    paySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f+addWitdth, 20.0f+90+addSubHeatch, 40.0f, 25.0f)];
    paySwitch.tag = 4;
    paySwitch.isRounded = YES;
    paySwitch.inactiveColor = [UIColor whiteColor];
    paySwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
    [paySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:paySwitch];
    
    
    
    
    UILabel *sqaqLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f+120+addSubHeatch, witdth, 20.0f)];
    sqaqLabel4.text = @"是否提供发票";
    sqaqLabel4.textColor = [UIColor grayColor];
    sqaqLabel4.backgroundColor = [UIColor clearColor];
    sqaqLabel4.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:sqaqLabel4];
    
    invoicedSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f+addWitdth, 20.0f+120+addSubHeatch, 40.0f, 25.0f)];
    invoicedSwitch.tag = 5;
    invoicedSwitch.isRounded = YES;
    invoicedSwitch.inactiveColor = [UIColor whiteColor];
    invoicedSwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
    [invoicedSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:invoicedSwitch];
    
    UILabel *sqaqLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f+150+addSubHeatch, witdth, 20.0f)];
    sqaqLabel5.text = @"管家是否回访";
    sqaqLabel5.textColor = [UIColor grayColor];
    sqaqLabel5.backgroundColor = [UIColor clearColor];
    sqaqLabel5.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:sqaqLabel5];
    
    visitedSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f+addWitdth, 20.0f+150+addSubHeatch, 40.0f, 25.0f)];
    visitedSwitch.tag = 6;
    visitedSwitch.isRounded = YES;
    visitedSwitch.inactiveColor = [UIColor grayColor];
    visitedSwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
    [visitedSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:visitedSwitch];
    
    UILabel *sqaqLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f+180+addSubHeatch, witdth, 20.0f)];
    sqaqLabel6.text = @"是否收取费用";
    sqaqLabel6.textColor = [UIColor grayColor];
    sqaqLabel6.backgroundColor = [UIColor clearColor];
    sqaqLabel6.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:sqaqLabel6];
    
    isGetfeed = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f+addWitdth, 20.0f+180+addSubHeatch, 40.0f, 25.0f)];
    isGetfeed.tag = 7;
    isGetfeed.isRounded = YES;
    isGetfeed.inactiveColor = [UIColor whiteColor];
    isGetfeed.onColor = [UIColor colorWithHexValue:0xFF86C433];
    [isGetfeed addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:isGetfeed];


    
    
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 20.0f+addHeatch+addSubHeatch, 90.0f, 20.0f)];
    statusLabel.text = @"服务满意度:";
    statusLabel.textColor = [UIColor grayColor];
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:statusLabel];
    
    satisfactionLabel = [[UILabel alloc] initWithFrame:CGRectMake(110.0f, 20.0f+addHeatch+addSubHeatch, 90.0f, 20.0f)];
    satisfactionLabel.textColor = [UIColor grayColor];
    satisfactionLabel.backgroundColor = [UIColor clearColor];
    satisfactionLabel.font = [UIFont systemFontOfSize:16.0f];
    satisfactionLabel.text = @"满意";
    [scrollView addSubview:satisfactionLabel];
    
    rateView = [[RatingView alloc] initWithFrame:CGRectMake(110.0f, 50.0f+addHeatch+addSubHeatch, 0.0f, 0.0f)];
    [rateView setImagesDeselected:@"unselect_star.png" partlySelected:nil fullSelected:@"select_star.png" andDelegate:self];
    [rateView displayRating:5.0f];
    [scrollView addSubview:rateView];
    
    UILabel *suggestionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 85.0f+addHeatch+addSubHeatch, 90.0f, 20.0f)];
    suggestionLabel.text = @"意见或建议:";
    suggestionLabel.textColor = [UIColor grayColor];
    suggestionLabel.backgroundColor = [UIColor clearColor];
    suggestionLabel.font = [UIFont systemFontOfSize:16.0f];
    [scrollView addSubview:suggestionLabel];
    
    UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - 290.0f) / 2, 110.0f+addHeatch+addSubHeatch, 290.0f, 165.0f)];
    textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
    [scrollView addSubview:textViewBg];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake((kContentWidth - 276.0f) / 2, 115.0f+addHeatch+addSubHeatch, 276.0f, 145.0f)];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.textColor = [UIColor grayColor];
    contentView.returnKeyType = UIReturnKeyDefault;
    contentView.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [scrollView addSubview:contentView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake((kContentWidth - 100.0f) / 2, 300.0f+addHeatch+addSubHeatch, 100.0f, 32.0f);
    [submitButton setTitle:@"确  定"
                  forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [submitButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                       forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                            forState:UIControlStateHighlighted];
    [submitButton addTarget:self
                     action:@selector(submitButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitButton];

    
    scrollView.contentSize = CGSizeMake(kContentWidth, 700.0f);

}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [contentView resignFirstResponder];
    return YES;
}
-(void)downLoad{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",_taskId,@"complainId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:getHousekeeper];
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
    if (request.tag==200) {
        NSLog(@"faild=====%@",request.error);
    }
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSString *substr2=[[dic objectForKey:@"housekeeper"]objectForKey:@"butlerName"];
            NSString *substr=[[dic objectForKey:@"housekeeper"]objectForKey:@"butlerGrade"];
            NSString *substr1=[[dic objectForKey:@"housekeeper"]objectForKey:@"butlerGrade"];
            [nameLabel setText:[NSString stringWithFormat:@"管家姓名:%@",substr2]];
            [jibieLabel setText:[NSString stringWithFormat:@"管家级别:%@",substr]];
            [headimage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,substr1]] placeholderImage:[UIImage imageNamed:@"4确认订单_03.png"]];
            
        }
    } if (request.tag==200) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            NSString *str=[[dic objectForKey:@"integral"]stringValue];
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:[NSString stringWithFormat:@"评价成功！"]];
            for(UIViewController *controller in self.navigationController.viewControllers) {
                if([controller isKindOfClass:[TSBXHistroyController class]]){
                    TSBXHistroyController*owr = (TSBXHistroyController *)controller;
                    [self.navigationController popToViewController:owr animated:YES];
                }
            }
            
            
            
        }
    }
    
}
-(void)controlClick{
    [contentView resignFirstResponder];
}
-(void)switchChanged:(UISwitch *)sw{
    if (sw.tag==1) {
        if (sw.isOn==YES) {
            str1=@"1";
        }else{
            str1=@"0";
        }
    }if (sw.tag==2) {
        if (sw.isOn==YES) {
            str2=@"1";
        }else{
            str2=@"0";
        }
        
    }
    if (sw.tag==3) {
        if (sw.isOn==YES) {
            str3=@"1";
        }else{
            str3=@"0";
        }
        
    }
    if (sw.tag==4) {
        if (sw.isOn==YES) {
            str4=@"1";
        }else{
            str4=@"0";
        }
        
    }
    if (sw.tag==5) {
        if (sw.isOn==YES) {
            str5=@"1";
        }else{
            str5=@"0";
        }
        
    }if (sw.tag==6) {
        if (sw.isOn==YES) {
            str6=@"1";
        }else{
            str6=@"0";
        }
        
    }if (sw.tag==7) {
        if (sw.isOn==YES) {
            str7=@"1";
        }else{
            str7=@"0";
        }
        
    }





    
}
-(void)submitButtonClick{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",_taskId,@"id",str1,@"isInTime",str2,@"isVisited",str3,@"visitIsIntime",str4,@"visitIsVisited",str5,@"isChargeFee",str6,@"isInvoice",str7,@"needMaterial",str8,@"star",contentView.text,@"reviews", nil];
    NSLog(@"%@",user);
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:repair];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=200;
        request.delegate=self;
        [request startAsynchronous];
    }

    
}
#pragma mark RatingViewDelegate method
- (void)ratingChanged:(float)newRating
{
    switch ((int)newRating) {
        case 1:
            satisfactionLabel.text = @"非常不满意";
            str8=@"1";
            break;
            
        case 2:
            satisfactionLabel.text = @"不满意";
            str8=@"2";
            break;
            
        case 3:
            satisfactionLabel.text = @"一般";
            str8=@"3";
            break;
            
        case 4:
            satisfactionLabel.text = @"较满意";
            str8=@"4";
            break;
            
        case 5:
            satisfactionLabel.text = @"满意";
            str8=@"5";
            break;
            
        default:
            break;
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
