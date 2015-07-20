//
//  TSBX_TSController.m
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "TSBX_TSController.h"

#define LeftMargin         8
#define TopMargin          10
#define ViewWidth          304
#define Offset             44

@implementation TSBX_TSView

- (id)initWithFrame:(CGRect)frame controller:(CommunityViewController *)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y + Offset, self.bounds.size.width, self.bounds.size.height - Offset)];
        blurView.backgroundColor = BlurColor;
        [self addSubview:blurView];
        
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.pagingEnabled = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.contentInset = UIEdgeInsetsMake(Offset + TopMargin, 0.0f, 0.0f, 0.0f);
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        
        UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, 34.0f)];
        titleBgView.image = [UIImage imageNamed:@""];
        [scrollView addSubview:titleBgView];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
        iconView.image = [UIImage imageNamed:@""];
        [scrollView addSubview:iconView];
        
        UILabel *tsKindLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 44.0f, 100.0f, 20.0f)];
        tsKindLabel.text = @"选择投诉类型";
        tsKindLabel.textColor = [UIColor blackColor];
        tsKindLabel.backgroundColor = [UIColor clearColor];
        tsKindLabel.font = [UIFont systemFontOfSize:14.0f];
        [scrollView addSubview:tsKindLabel];
        
        UILabel *sqaqLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 74.0f, 70.0f, 20.0f)];
        sqaqLabel.text = @"社区安全";
        sqaqLabel.textColor = [UIColor blackColor];
        sqaqLabel.backgroundColor = [UIColor clearColor];
        sqaqLabel.font = [UIFont systemFontOfSize:16.0f];
        [scrollView addSubview:sqaqLabel];
        
        sqanSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 70.0f, 40.0f, 25.0f)];
        sqanSwitch.tag = 1;
        sqanSwitch.isRounded = YES;
        sqanSwitch.inactiveColor = [UIColor whiteColor];
        sqanSwitch.onColor = [UIColor orangeColor];
        [sqanSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:sqanSwitch];
        
        UILabel *sqbjLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 109.0f, 70.0f, 20.0f)];
        sqbjLabel.text = @"社区保洁";
        sqbjLabel.textColor = [UIColor blackColor];
        sqbjLabel.backgroundColor = [UIColor clearColor];
        sqbjLabel.font = [UIFont systemFontOfSize:16.0f];
        [scrollView addSubview:sqbjLabel];
        
        sqbjSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 105.0f, 40.0f, 25.0f)];
        sqbjSwitch.tag = 2;
        sqbjSwitch.isRounded = YES;
        sqbjSwitch.inactiveColor = [UIColor whiteColor];
        sqbjSwitch.onColor = [UIColor orangeColor];
        [sqbjSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:sqbjSwitch];
        
        UILabel *sqlhLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 144.0f, 70.0f, 20.0f)];
        sqlhLabel.text = @"社区绿化";
        sqlhLabel.textColor = [UIColor blackColor];
        sqlhLabel.backgroundColor = [UIColor clearColor];
        sqlhLabel.font = [UIFont systemFontOfSize:16.0f];
        [scrollView addSubview:sqlhLabel];
        
        sqlhSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 140.0f, 40.0f, 25.0f)];
        sqlhSwitch.tag = 3;
        sqlhSwitch.isRounded = YES;
        sqlhSwitch.inactiveColor = [UIColor whiteColor];
        sqlhSwitch.onColor = [UIColor orangeColor];
        [sqlhSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:sqlhSwitch];
        
        UILabel *sbssLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 179.0f, 70.0f, 20.0f)];
        sbssLabel.text = @"社区设施";
        sbssLabel.textColor = [UIColor blackColor];
        sbssLabel.backgroundColor = [UIColor clearColor];
        sbssLabel.font = [UIFont systemFontOfSize:16.0f];
        [scrollView addSubview:sbssLabel];
        
        sqssSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 174.0f, 40.0f, 25.0f)];
        sqssSwitch.tag = 4;
        sqssSwitch.isRounded = YES;
        sqssSwitch.inactiveColor = [UIColor whiteColor];
        sqssSwitch.onColor = [UIColor orangeColor];
        [sqssSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:sqssSwitch];
        
        UILabel *wyygLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 214.0f, 70.0f, 20.0f)];
        wyygLabel.text = @"物业员工";
        wyygLabel.textColor = [UIColor blackColor];
        wyygLabel.backgroundColor = [UIColor clearColor];
        wyygLabel.font = [UIFont systemFontOfSize:16.0f];
        [scrollView addSubview:wyygLabel];
        
        wyygSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 210.0f, 40.0f, 25.0f)];
        wyygSwitch.tag = 5;
        wyygSwitch.isRounded = YES;
        wyygSwitch.inactiveColor = [UIColor whiteColor];
        wyygSwitch.onColor = [UIColor orangeColor];
        [wyygSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:wyygSwitch];
        
        UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth - 284.0f) / 2, 245, 284.0f, 165.0f)];
        textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
        [scrollView addSubview:textViewBg];
        
        tsTextView = [[UITextView alloc] initWithFrame:CGRectMake((ViewWidth - 270.0f) / 2, 250.0f, 270.0f, 145.0f)];
        [tsTextView setBackgroundColor:[UIColor clearColor]];
        [tsTextView setTextColor:[UIColor blackColor]];
        tsTextView.returnKeyType = UIReturnKeyDefault;
        tsTextView.font = [UIFont fontWithName:@"Arial" size:16.0];
        [scrollView addSubview:tsTextView];
        
        UILabel *addPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 420.0f, 100.0f, 20.0f)];
        addPhotoLabel.text = @"选择现场照片";
        addPhotoLabel.textColor = [UIColor blackColor];
        addPhotoLabel.backgroundColor = [UIColor clearColor];
        addPhotoLabel.font = [UIFont systemFontOfSize:14.0f];
        [scrollView addSubview:addPhotoLabel];
        
        imageUploadView = [[MultiImageUploadView alloc] initWithFrame:CGRectMake(7.0f, 450.0f, 290.0f, 64.0f)];
        imageUploadView.backgroundColor=[UIColor whiteColor];
        imageUploadView.controller = controller;
        imageUploadView.type = 4;
        imageUploadView.delegate = self;
        [scrollView addSubview:imageUploadView];
        
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = CGRectMake((ViewWidth - 76.0f) / 2, 534.0f, 76.0f, 26.0f);
        [submitButton setTitle:@"确  定"
                      forState:UIControlStateNormal];
        [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [submitButton setTitleColor:[UIColor whiteColor]
                           forState:UIControlStateNormal];
        [submitButton setBackgroundImage:[UIImage imageNamed:@"icon01"]
                                forState:UIControlStateNormal];
        [submitButton setBackgroundImage:[UIImage imageNamed:@"icon10"]
                                forState:UIControlStateHighlighted];
        [submitButton addTarget:self
                         action:@selector(submitButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:submitButton];
        
        scrollView.contentSize = CGSizeMake(ViewWidth, 580.0f);
    }
    return self;
}

// 键盘弹出和消失时重新设置scrllview的frame
- (void)setScrollViewFrame
{
    scrollView.frame = self.bounds;
}

- (void)switchChanged:(SevenSwitch *)sender
{
    // 如果某个switch的状态是on,则要将其他switch的状态改为off
    if (sender.isOn) {
        for (int i = 1; i <= 5; i++) {
            if (i == sender.tag) {
                continue;
            }
            SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
            if (view.isOn) {
                [view setOn:NO animated:YES];
            }
        }
    }
}

- (void)submitButtonClick
{
    [tsTextView resignFirstResponder];
    
    int complainType = 0;
    for (int i = 1; i <= 5; i++) {
        SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
        if (view.isOn) {
            complainType = i;
        }
    }
    
    if (complainType == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"选择投诉的类型"];
        return;
    }
    
    NSString *tsString = [tsTextView.text trim];
    if ([tsString isEmptyOrBlank] || tsString == nil) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入要投诉的内容"];
        return;
    }
    
    NSString *pictureURL = @"";
    if (imageUploadView.URLArray.count > 0) {
        for (int i = 0; i < imageUploadView.URLArray.count; i ++) {
            pictureURL = [pictureURL stringByAppendingString:imageUploadView.URLArray[i]];
            if (i != imageUploadView.URLArray.count - 1) {
                pictureURL = [pictureURL stringByAppendingString:@"#"];
            }
        }
    }
    NSLog(@"----%@", pictureURL);
    
    NSDictionary *complainDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                                  pictureURL, @"picture",
                                  tsString, @"content",
                                  [NSString stringWithFormat:@"%d", complainType], @"complainType", nil];
    NSLog(@"-----%@",complainDict);
    id object = [self nextResponder];
    while (![object isKindOfClass:[TSBX_TSController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    if ([object isKindOfClass:[TSBX_TSController class]]) {
        [((TSBX_TSController*)object) submitComplainDict:complainDict];
    }
}

#pragma mark MultiImageUploadViewDelegate
- (void)hideKeyboard
{
    [tsTextView resignFirstResponder];
}

@end

@implementation TSBX_TSController

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
	
    self.title = @"投诉";
    
    tsView = [[TSBX_TSView alloc] initWithFrame:CGRectMake(LeftMargin, -Offset, ViewWidth, kNavContentHeight + Offset) controller:self];
    [self.view addSubview:tsView];
    
    
    [self customBackButton:self];
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

//修改
- (void)submitComplainDict:(NSDictionary *)dict
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] complainWithDict:dict
                                                complete:^(BOOL success, ComplainAndRepairResponse *resp) {
        if (success && resp.result == RESPONSE_SUCCESS) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:[NSString stringWithFormat:@"投诉成功，投诉编号:\n%@", resp.no]];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            if (resp.result) {
                [HttpResponseNotification TSBXHttpResponse:resp.result];
            } else {
                [HttpResponseNotification TSBXHttpResponse:RESPONSE_ERROR];
            }
        }
    }];
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
                         CGRect frame = tsView.frame;
                         frame.size.height = kNavContentHeight + Offset - keybordHeight;
                         tsView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [tsView setScrollViewFrame];
                         }
                     }
     ];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGRect frame = tsView.frame;
                         frame.size.height = kNavContentHeight + Offset;
                         tsView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [tsView setScrollViewFrame];
                         }
                     }
     ];
}

@end
