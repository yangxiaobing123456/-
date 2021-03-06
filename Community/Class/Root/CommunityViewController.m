//
//  CommunityViewController.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()

@end

@implementation CommunityViewController

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
    
    //iOS7之前从NavigationBar底部开始计算y值的,现在却是从StatusBar开始计算y值
    //下面代码是解决这个问题的
    //如果没有NavigationBar,y值还是从StatusBar开始计算
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight)];
    if (iPhone5) {
//        backgroundView.image = [UIImage imageNamed:@"background_1096"];
//                backgroundView.image = [UIImage imageNamed:@"背景"];
//        backgroundView.backgroundColor=[UIColor colorWithHexString:@"#e7e7e7"];
        backgroundView.backgroundColor=[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
//        backgroundView.backgroundColor=[UIColor darkGrayColor];
    } else {
//        backgroundView.image = [UIImage imageNamed:@"background_920"];
//                backgroundView.image = [UIImage imageNamed:@"背景"];
//        backgroundView.backgroundColor=[UIColor colorWithHexString:@"#e7e7e7"];
    backgroundView.backgroundColor=[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
    }
    [self.view addSubview:backgroundView];
}

// 自定义有返回按钮
- (void)customBackButton:(UIViewController *)controller
{
    DJLog(@"%@ index of stack:%d", NSStringFromClass([controller class]),
          [self.navigationController.viewControllers indexOfObject:controller]);
    
    //controller在stack中的位置是0的情况下不创建返回按钮
    if ([self.navigationController.viewControllers indexOfObject:controller] == 0) {
        return;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iOS7) {
        button.frame = CGRectMake(0.0f, 0.0f, 12.0f, 20.0f);
    } else {
        button.frame = CGRectMake(0.0f, 0.0f, 22.0f, 20.0f);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f)];
    }
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBackAction)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)goBackAction
{
    //以防万一,返回时隐藏指示器
    [[CommunityIndicator sharedInstance] hideIndicator:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//当navigatioBar隐藏时要改变背景的frame
- (void)changBackgroundViewFrame
{
    backgroundView.frame = CGRectMake(0.0f, iOS7 ? 20.0f : 0.0f, kContentWidth, kContentHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
