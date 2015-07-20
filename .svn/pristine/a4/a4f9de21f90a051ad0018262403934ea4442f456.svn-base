//
//  timePickerViewController.m
//  Community
//
//  Created by HuaMen on 14-12-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "timePickerViewController.h"
#import "RBCustomDatePickerView.h"

@interface timePickerViewController ()
{
    NSUserDefaults *defaults;
}

@end

@implementation timePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[NSUserDefaults standardUserDefaults];
    RBCustomDatePickerView *pickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    pickerView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:pickerView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake((320 - 76.0f) / 2, 380.0f, 76.0f, 26.0f);
    [submitButton setTitle:@"确  定"
                  forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [submitButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateHighlighted];
    [submitButton addTarget:self
                     action:@selector(submitButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];

    
}
-(void)submitButtonClick{
    NSLog(@"%@",[defaults objectForKey:@"YYtime"]);
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"YYtime"],@"nowTime", nil];
    NSNotification *notice=[NSNotification notificationWithName:@"selectTime" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    [self.navigationController popViewControllerAnimated:YES];
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
