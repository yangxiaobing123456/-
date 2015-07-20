//
//  TaskEvaluateController.m
//  Community
//
//  Created by SYZ on 14-5-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "TaskEvaluateController.h"

#define ViewWidth       304.0f
#define LeftMargin      8.0f
#define addHeatch       100.0f

@implementation TaskEvaluateView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        UILabel *sqaqLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f, 70.0f, 20.0f)];
        sqaqLabel.text = @"是否事先沟通";
        sqaqLabel.textColor = [UIColor whiteColor];
        sqaqLabel.backgroundColor = [UIColor clearColor];
        sqaqLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:sqaqLabel];
        
        intimeSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 20.0f, 40.0f, 25.0f)];
        intimeSwitch.tag = 1;
        intimeSwitch.isRounded = YES;
        intimeSwitch.inactiveColor = [UIColor whiteColor];
        intimeSwitch.onColor = [UIColor colorWithHexValue:0xFF86C433];
        [intimeSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:intimeSwitch];

        
        
        
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 20.0f, 90.0f, 20.0f)];
        statusLabel.text = @"服务满意度:";
        statusLabel.textColor = [UIColor whiteColor];
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:statusLabel];
        
        satisfactionLabel = [[UILabel alloc] initWithFrame:CGRectMake(110.0f, 20.0f, 90.0f, 20.0f)];
        satisfactionLabel.textColor = [UIColor whiteColor];
        satisfactionLabel.backgroundColor = [UIColor clearColor];
        satisfactionLabel.font = [UIFont systemFontOfSize:16.0f];
        satisfactionLabel.text = @"满意";
        [self addSubview:satisfactionLabel];
        
        rateView = [[RatingView alloc] initWithFrame:CGRectMake(110.0f, 50.0f, 0.0f, 0.0f)];
        [rateView setImagesDeselected:@"unselect_star.png" partlySelected:nil fullSelected:@"select_star.png" andDelegate:self];
        [rateView displayRating:5.0f];
        [self addSubview:rateView];
        
        UILabel *suggestionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 85.0f, 90.0f, 20.0f)];
        suggestionLabel.text = @"意见或建议:";
        suggestionLabel.textColor = [UIColor whiteColor];
        suggestionLabel.backgroundColor = [UIColor clearColor];
        suggestionLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:suggestionLabel];
        
        UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake((kContentWidth - 290.0f) / 2, 110.0f, 290.0f, 165.0f)];
        textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
        [self addSubview:textViewBg];
        
        contentView = [[UITextView alloc] initWithFrame:CGRectMake((kContentWidth - 276.0f) / 2, 115.0f, 276.0f, 145.0f)];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.textColor = [UIColor whiteColor];
        contentView.returnKeyType = UIReturnKeyDefault;
        contentView.font = [UIFont fontWithName:@"Arial" size:16.0f];
        [self addSubview:contentView];
        
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = CGRectMake((kContentWidth - 100.0f) / 2, 300.0f, 100.0f, 32.0f);
        [submitButton setTitle:@"确  定"
                      forState:UIControlStateNormal];
        [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [submitButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                           forState:UIControlStateNormal];
        [submitButton setBackgroundImage:[UIImage imageNamed:@"button_normal_200W"]
                                forState:UIControlStateNormal];
        [submitButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                                forState:UIControlStateHighlighted];
        [submitButton addTarget:self
                         action:@selector(submitButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submitButton];
    }
    
    return self;
}
-(void)switchChanged:(UISwitch *)sw{
    
}
- (void)submitButtonClick
{
    [contentView resignFirstResponder];
    
    if ([contentView.text isEmptyOrBlank] || contentView.text == nil) {
        contentView.text = @"";
    }
    NSDictionary *commentDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 _taskId, @"id",
                                 contentView.text, @"content",
                                 [NSString stringWithFormat:@"%d", (int)rateView.rating], @"star",
                                 nil];
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[TaskEvaluateController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    if ([object isKindOfClass:[TaskEvaluateController class]]) {
        [((TaskEvaluateController*)object) submitCommentDict:commentDict];
    }
}

#pragma mark RatingViewDelegate method
- (void)ratingChanged:(float)newRating
{
    switch ((int)newRating) {
        case 1:
            satisfactionLabel.text = @"非常不满意";
            break;
            
        case 2:
            satisfactionLabel.text = @"不满意";
            break;
            
        case 3:
            satisfactionLabel.text = @"一般";
            break;
            
        case 4:
            satisfactionLabel.text = @"较满意";
            break;
            
        case 5:
            satisfactionLabel.text = @"满意";
            break;
            
        default:
            break;
    }
}

@end

@implementation TaskEvaluateController

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"请评价我们的服务";
    [self customBackButton:self];

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
    
    evaluateView = [[TaskEvaluateView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, 350.0f)];
    evaluateView.taskId = _taskId;
    evaluateView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:evaluateView];
    
    scrollView.contentSize = CGSizeMake(kContentWidth, 700.0f);
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

- (void)submitCommentDict:(NSDictionary *)dict
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] commentTaskWith:dict complete:^(int result) {
        [HttpResponseNotification commentTaskHttpResponse:result];
        if (result == RESPONSE_SUCCESS) {
            [_delegate successEvaluate:self];
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
                         scrollView.frame = CGRectMake(0.0f, -kNavigationBarPortraitHeight, kContentWidth, kContentHeight - keybordHeight);
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
                         scrollView.frame = CGRectMake(0.0f, -kNavigationBarPortraitHeight, kContentWidth, kContentHeight);
                     }
                     completion:nil
     ];
}

@end
