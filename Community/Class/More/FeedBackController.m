//
//  FeedBackController.m
//  Community
//
//  Created by SYZ on 14-3-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "FeedBackController.h"
#import "MultiImageUploadView.h"

@interface FeedBackController ()<MultiImageUploadViewDelegate>
{
    MultiImageUploadView *imageUploadView;
}

@end

@implementation FeedBackController

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
	
    self.title = @"意见反馈";
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 304.0f, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    CGRect rect = CGRectMake(8.0f, -44.0f, 304.0f, kContentHeight);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.pagingEnabled = NO;
    scrollView.contentInset = UIEdgeInsetsMake(54.0f, 0.0f, 0.0f, 0.0f);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
    CommunityMoreHeaderView *headerView = [[CommunityMoreHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 304.0f, 130.0f)];
    [headerView setContent:@"请帮助我们完善我们的服务和功能，我们会认真考虑您的意见，将之融入社区服务当中。"];
    [scrollView addSubview:headerView];
    
    UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake((304.0f - 284.0f) / 2, 135, 284.0f, 165.0f)];
    textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
    [scrollView addSubview:textViewBg];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake((304.0f - 270.0f) / 2, 140.0f, 270.0f, 145.0f)];
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor grayColor];
    textView.returnKeyType = UIReturnKeyDefault;
    textView.font = [UIFont fontWithName:@"Arial" size:16.0];
    [scrollView addSubview:textView];
    
    imageUploadView = [[MultiImageUploadView alloc] initWithFrame:CGRectMake(15.0f, 315, 290.0f, 64.0f)];
    imageUploadView.backgroundColor=[UIColor whiteColor];
    imageUploadView.controller = self;
    imageUploadView.type = 4;
    imageUploadView.delegate = self;
    [self.view addSubview:imageUploadView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake((304.0f - 76.0f) / 2, 380.0f, 76.0f, 26.0f);
    [submitButton setTitle:@"确  定"
                  forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [submitButton setTitleColor:[UIColor whiteColor]
                       forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"button_green_highlighted_152W"]
                            forState:UIControlStateHighlighted];
    [submitButton addTarget:self
                     action:@selector(submitButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitButton];
    
    [scrollView setContentSize:CGSizeMake(304.0f, 370.0f)];
    
    [self customBackButton:self];
}
- (void)hideKeyboard
{
    [textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark Observer methods
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame;
    [[[((NSNotification *)notification) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    float keybordHeight = CGRectGetHeight(keyboardFrame);
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGRect frame = scrollView.frame;
                         frame.size.height = kContentHeight - keybordHeight;
                         scrollView.frame = frame;
                     }
                     completion:nil
     ];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGRect frame = scrollView.frame;
                         frame.size.height = kContentHeight;
                         scrollView.frame = frame;
                     }
                     completion:nil
     ];
}

- (void)submitButtonClick
{
    if ([textView.text isEmptyOrBlank] || textView.text == nil) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入您的意见"];
        return;
    }
    
    [[CommunityIndicator sharedInstance] startLoading];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:textView.text, @"content",
                          [NSNumber numberWithInt:1], @"loginFrom", nil];
    [[HttpClientManager sharedInstance] submitSuggestWithDict:dict complete:^(BOOL success) {
        if (success) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"您的意见已提交\n我们将尽快处理,谢谢"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"提交失败,请重试"];
        }
    }];
    
}

@end
