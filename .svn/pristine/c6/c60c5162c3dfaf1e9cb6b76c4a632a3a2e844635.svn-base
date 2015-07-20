//
//  ActivityEmptyViewController.m
//  Community
//
//  Created by HuaMen on 15-3-13.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "ActivityEmptyViewController.h"

@interface ActivityEmptyViewController ()

@end

@implementation ActivityEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"社区活动";
    
    [self addBarButtonItem];
    
    UIImageView *noticeImage=[[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 120, 120)];
    noticeImage.image=[UIImage imageNamed:@"二胡卵子1"];
    [self.view addSubview:noticeImage];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(100, 275, 120, 20)];
    [l setText:@"请去别处逛逛"];
    [l setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:l];
    
//    UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10.0f, 310, 80)];
//    [headImage setImage:[UIImage imageNamed:@"2益社区团购_03(1).png"]];
//    [self.view addSubview:headImage];

    UISegmentedControl *seg = [[UISegmentedControl alloc] init];
    //隐藏圆角
    seg.frame = CGRectMake(-4, -1, 328, 44);
    [seg insertSegmentWithTitle:@"小区活动" atIndex:0 animated:YES];
    [seg insertSegmentWithTitle:@"业主活动" atIndex:1 animated:YES];
    
    [seg setSelectedSegmentIndex:1];
    [seg setTintColor:[UIColor orangeColor]];
//    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    //隐藏黄线
    UILabel *lineLabely = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 320, 1)];
    lineLabely.backgroundColor = RGBA(231, 231, 231, 1);
    [self.view addSubview:lineLabely];

    
}


#pragma mark-  BarButtonItem
- (void)addBarButtonItem
{
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    leftBarBtn.frame=CGRectMake(0, 0, 12, 20);
    leftBarBtn.tag = 101;
    [leftBarBtn addTarget:self action:@selector(rightBarBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)rightBarBtnSelect:(UIButton *)btn
{
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
