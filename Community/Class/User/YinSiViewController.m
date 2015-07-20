//
//  YinSiViewController.m
//  Housekeeper
//
//  Created by HuaMen on 14-9-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "YinSiViewController.h"
#import "GetVerifyCodeController.h"
#import "ConfirmPasswordController.h"

@interface YinSiViewController ()

@end

@implementation YinSiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addScrollView];
    agree=NO;
    
//    AgreeSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(5, 270, 50, 20)];
//    [AgreeSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:AgreeSwitch];
    
    gouBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    gouBtn.frame = CGRectMake(20, 275.0f, 25, 25);
    [gouBtn setTag:10];
    [gouBtn setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
    [gouBtn setBackgroundImage:[UIImage imageNamed:@"没勾子.png"]
                          forState:UIControlStateNormal];
    [gouBtn addTarget:self
               action:@selector(btnClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gouBtn];


    
    AgreeLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 280, 240, 15)];
    [AgreeLabel setText:@"我已阅读并接受以上条款"];
    [AgreeLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:AgreeLabel];
    
    float buttonW = 260.0f, buttonH = 30.0f;
    nextTepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextTepBtn setTag:100];
    nextTepBtn.frame = CGRectMake((self.view.frame.size.width - buttonW) / 2, 320.0f, buttonW, buttonH);
    [nextTepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextTepBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [nextTepBtn setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
    [nextTepBtn setBackgroundImage:[UIImage imageNamed:@"red_button"]
                          forState:UIControlStateDisabled];
    [nextTepBtn setBackgroundImage:[UIImage imageNamed:@"button_normal_148W"]
                          forState:UIControlStateNormal];
    [nextTepBtn setEnabled:NO];
    [nextTepBtn addTarget:self
                   action:@selector(btnClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextTepBtn];


}

-(void)btnClick:(UIButton *)btn{
    if (btn.tag==10) {
        if (agree==NO) {
            [gouBtn setBackgroundImage:[UIImage imageNamed:@"勾子.png"]
                              forState:UIControlStateNormal];
            [AgreeLabel setTextColor:[UIColor redColor]];
            [nextTepBtn setEnabled:YES];
            agree=YES;
            
        }else {
            [gouBtn setBackgroundImage:[UIImage imageNamed:@"没勾子.png"]
                              forState:UIControlStateNormal];
            [AgreeLabel setTextColor:[UIColor blackColor]];
            [nextTepBtn setEnabled:NO];
            agree=NO;
        }
        
        
    }if (btn.tag==100) {
        ConfirmPasswordController *vc=[[ConfirmPasswordController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    
}
-(void)addScrollView{ Scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(5, 10, 310, 250)];
    Scrollview.contentSize = CGSizeMake(310, 620);
    [self.view addSubview:Scrollview];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 310, 620)];
                    
    label.text=@"本隐私政策介绍本公司的隐私数据相关政策和惯例，这将涵盖我们如何收集、使用、处理、存储和/或披露那些通过本公司的移动App收集的关于您的个人信息。请你仔细阅读我们的隐私政策。\n"
    @"一、本公司如何收集您的个人信息\n"
    @"个人信息是可用于唯一地识别或联系某人的数据。\n"
    @"当您使用本公司的移动App，注册用户过程中我们将会收集您的个人信息，如：个人姓名、小区信息。为了保护个人隐私，您不应提供除本公司特别要求之外的任何其它信息。\n"
    @"二、本公司如何使用您的个人信息\n"
    @"1、通过您的个人信息，向您发送本公司移动App的服务信息。\n"
    @"2、通过您的个人信息实现密码找回功能\n"
    @"3、除本公司发生重组、合并或出售，可将我们收集的一切个人信息转让给相关第三方外，本公司不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和本公司单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些信息。\n"
    @" 三、个人信息安全\n"
    @"保证您的个人数据的安全对我们来说至关重要。当您在本公司的移动App中注册输入个人数据时，我们会利用安全套接字层技术 (SSL) 对这些信息进行加密。\n"
    @"在数据传输和数据保管两个阶段里，我们会通过广为接受的行业标准（如防火墙、加密和数据隐私法律要求）来保护您向我们提交的信息。\n"
    @"然而，没有任何一种互联网传输或电子存储方法是100%安全的。因此，尽管我们通过商业上可接受的方式来保护您的个人信息，但仍无法保证信息的绝对安全。\n"
    @"四、本公司会将个人信息保存多久\n"
    @"一般来说，本公司仅保留您的个人信息至履行收集目的所需的期限，同时将遵守适用法律规定的数据保留期限。\n"
    @"五、法律免责声明\n"
    @"在法律要求的情况下，以及本公司认为必须披露与您有关的信息来保护本公司的法定权益和/或遵守司法程序、法院指令或适用于本公司的移动App的法律程序时，我们有权透露您的个人信息。\n"
    @"如果本公司确定为了执行本公司的条款和条件或保护我们的经营，披露是合理必须的，则我们可披露与您有关的信息。\n"
    @"六、本隐私政策的更改\n"
    @"如果决定更改隐私政策，我们会在本政策中、本公司网站中以及我们认为适当的位置发布这些更改，以便您了解我们如何收集、使用您的个人信息，哪些人可以访问这些信息，以及在什么情况下我们会透露这些信息。\n"
    @"本公司保留随时修改本政策的权利，因此请经常查看。如对本政策作出重大更改，本公司会通过网站通知的形式告知。\n"
    @"七、隐私问题\n"
    @"如果你对本公司的隐私政策或数据处理有任何问题或顾虑，请通过4008-110-416 与本公司联系";
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.numberOfLines=0;
    label.textColor=[UIColor blackColor];
    label.font=[UIFont fontWithName:@"helvetica" size:11];
    [Scrollview addSubview:label];

    
}

@end
