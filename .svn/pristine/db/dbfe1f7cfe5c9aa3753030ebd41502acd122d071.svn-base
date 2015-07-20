//
//  selectPwdViewController.m
//  Community
//
//  Created by HuaMen on 14-10-10.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "selectPwdViewController.h"
#import "ChangePasswordController.h"
#import "ZFPWDViewController.h"

@interface selectPwdViewController ()

@end

@implementation selectPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 310.0f) / 2, 10.0f, 310.0f, 39.0f)];
//    bg.image=[UIImage imageNamed:@"more_cell_bg"];
    bg.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bg];
    
    UIButton *loginbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [loginbtn setTitle:@"登录密码" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginbtn setBackgroundColor:[UIColor clearColor]];
    [loginbtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [loginbtn setFrame:bg.frame];
    [self.view addSubview:loginbtn];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake((320 - 310.0f) / 2, 49.0f, 310.0f, 0.5f)];
    image.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:image];
    
    
    UIImageView *bg1 = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 310.0f) / 2, 10.0f+39+0.5, 310.0f, 39.0f)];
//    bg1.image=[UIImage imageNamed:@"more_cell_bg"];
    bg1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bg1];
    
    UIButton *loginbtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [loginbtn1 setTitle:@"支付密码" forState:UIControlStateNormal];
    [loginbtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginbtn1 setBackgroundColor:[UIColor clearColor]];
    [loginbtn1 addTarget:self action:@selector(changZFPWD) forControlEvents:UIControlEventTouchUpInside];
    [loginbtn1 setFrame:CGRectMake((320 - 310.0f) / 2, 10.0f+39+0.5, 310.0f, 39.0f)];
    [self.view addSubview:loginbtn1];
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake((320 - 310.0f) / 2, 10.0f+39+39+0.5, 310.0f,0.5f)];
    image1.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:image1];

    
}
-(void)changePwd{
    
    ChangePasswordController *controller = [ChangePasswordController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
-(void)changZFPWD{
    ZFPWDViewController *controller = [ZFPWDViewController new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
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
