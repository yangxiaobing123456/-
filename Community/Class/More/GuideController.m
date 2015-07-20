//
//  GuideController.m
//  Community
//
//  Created by SYZ on 14-3-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "GuideController.h"

#define GuideImageCount     3

@implementation GuideController

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
	
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, kScreenHeight)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [scrollView setContentSize:CGSizeMake(GuideImageCount * scrollView.frame.size.width, scrollView.frame.size.height)];
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    [scrollView addGestureRecognizer:gesture];
    //开机默认图
    
    NSString *imageName = iPhone5 ? @"guide_iphone5-" : @"guide_iphone4-";
    for (int i = 1; i <= GuideImageCount; i++) {
        UIImageView *guideImage = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * (i - 1), 0.0f, scrollView.frame.size.width, scrollView.frame.size.height)];
        guideImage.tag = i;
        guideImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d", imageName, i]];
        [scrollView addSubview:guideImage];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)gestureRecognizer:(UITapGestureRecognizer *)tapGesture
{
    if(scrollView.contentOffset.x == (GuideImageCount - 1) * scrollView.frame.size.width) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end
