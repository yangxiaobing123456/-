//
//  TSBX_BXController.m
//  Community
//
//  Created by SYZ on 13-11-28.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "TSBX_BXController.h"
#import "RBCustomDatePickerView.h"
#import "timePickerViewController.h"

#define LeftMargin         8
#define TopMargin          10
#define Offset             44
#define ViewWidth          304

@implementation TSBX_BXView

- (id)initWithFrame:(CGRect)frame controller:(CommunityViewController *)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTime:) name:@"selectTime" object:nil];
        UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y + Offset, self.bounds.size.width, self.bounds.size.height - Offset)];
        blurView.backgroundColor = BlurColor;
        [self addSubview:blurView];
        
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.pagingEnabled = NO;
        scrollView.contentInset = UIEdgeInsetsMake(Offset + TopMargin, 0.0f, 0.0f, 0.0f);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        
//        UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ViewWidth, 34.0f)];
//        titleBgView.image = [UIImage imageNamed:@"bg_green_68H"];
//        [scrollView addSubview:titleBgView];
//        
//        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 28.0f, 28.0f)];
//        iconView.image = [UIImage imageNamed:@"iphone_05.png"];
//        [scrollView addSubview:iconView];
        
        UILabel *tsKindLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 44.0f, 100.0f, 20.0f)];
        tsKindLabel.text = @"选择报修类型";
        tsKindLabel.textColor = [UIColor blackColor];
        tsKindLabel.backgroundColor = [UIColor clearColor];
        tsKindLabel.font = [UIFont systemFontOfSize:14.0f];
        [scrollView addSubview:tsKindLabel];
        
        UILabel *grbxLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 74.0f, 70.0f, 20.0f)];
        grbxLabel.text = @"个人报修";
        grbxLabel.textColor = [UIColor blackColor];
        grbxLabel.backgroundColor = [UIColor clearColor];
        grbxLabel.font = [UIFont systemFontOfSize:16.0f];
        [scrollView addSubview:grbxLabel];
        
        grbxSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 70.0f, 40.0f, 25.0f)];
        grbxSwitch.tag = 1;
        grbxSwitch.isRounded = YES;
        grbxSwitch.inactiveColor = [UIColor whiteColor];
        grbxSwitch.onColor = [UIColor orangeColor];
        [grbxSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:grbxSwitch];
        
        UILabel *ggbxLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 109.0f, 70.0f, 20.0f)];
        ggbxLabel.text = @"公共报修";
        ggbxLabel.textColor = [UIColor blackColor];
        ggbxLabel.backgroundColor = [UIColor clearColor];
        ggbxLabel.font = [UIFont systemFontOfSize:16.0f];
        [scrollView addSubview:ggbxLabel];
        
        ggbxSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(110.0f, 105.0f, 40.0f, 25.0f)];
        ggbxSwitch.tag = 2;
        ggbxSwitch.isRounded = YES;
        ggbxSwitch.inactiveColor = [UIColor whiteColor];
        ggbxSwitch.onColor = [UIColor orangeColor];
        [ggbxSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:ggbxSwitch];
        
        UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth - 284.0f) / 2, 140, 284.0f, 165.0f)];
        textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
        [scrollView addSubview:textViewBg];
        
        bxTextView = [[UITextView alloc] initWithFrame:CGRectMake((ViewWidth - 270.0f) / 2, 145.0f, 270.0f, 145.0f)];
        bxTextView.backgroundColor = [UIColor clearColor];
        bxTextView.textColor = [UIColor grayColor];
        bxTextView.returnKeyType = UIReturnKeyDefault;
        bxTextView.font = [UIFont fontWithName:@"Arial" size:16.0];
        [scrollView addSubview:bxTextView];
        
        UILabel *addPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 315.0f, 100.0f, 20.0f)];
        addPhotoLabel.text = @"选择现场照片";
        addPhotoLabel.textColor = [UIColor blackColor];
        addPhotoLabel.backgroundColor = [UIColor clearColor];
        addPhotoLabel.font = [UIFont systemFontOfSize:14.0f];
        [scrollView addSubview:addPhotoLabel];
        
        imageUploadView = [[MultiImageUploadView alloc] initWithFrame:CGRectMake(7.0f, 345.0f, 290.0f, 64.0f)];
        imageUploadView.controller = controller;
        imageUploadView.type = 3;
        imageUploadView.delegate = self;
        [scrollView addSubview:imageUploadView];
        
        UILabel *materialLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 430.0f, 150.0f, 20.0f)];
        materialLabel.text = @"是否需要提供维修材料";
        materialLabel.textColor = [UIColor blackColor];
        materialLabel.backgroundColor = [UIColor clearColor];
        materialLabel.font = [UIFont systemFontOfSize:14.0f];
        [scrollView addSubview:materialLabel];
        
        materialSwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(170.0f, 426.0f, 40.0f, 25.0f)];
        materialSwitch.tag = 3;
        materialSwitch.isRounded = YES;
        materialSwitch.inactiveColor = [UIColor whiteColor];
        materialSwitch.onColor = [UIColor orangeColor];
        [materialSwitch addTarget:self action:@selector(isMaterial) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:materialSwitch];
        
        bxfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 451.0f, 270.0f, 20)];
        bxfield.backgroundColor = [UIColor clearColor];
        bxfield.textColor = [UIColor grayColor];
        bxfield.placeholder=@"请填入您需要什么材料";
        bxfield.returnKeyType = UIReturnKeyDefault;
        bxfield.font = [UIFont fontWithName:@"Arial" size:14.0];
        [bxfield setHidden:YES];
        [scrollView addSubview:bxfield];

        
        
        seg = [[UISegmentedControl alloc] init];
        seg.frame = CGRectMake(0, 0, 300, 30);
        [seg insertSegmentWithTitle:@"立即报修" atIndex:0 animated:YES];
        [seg insertSegmentWithTitle:@"预约报修" atIndex:1 animated:YES];
        [seg setSelectedSegmentIndex:0];
        [seg setTintColor:[UIColor orangeColor]];
        [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:seg];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,485.0f, 150.0f, 20.0f)];
        timeLabel.text = @"选择预约时间";
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:14.0f];
        [scrollView addSubview:timeLabel];
        [timeLabel setHidden:YES];
        
        timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        timeBtn.frame = CGRectMake(140, 480.0f, 160.0f, 26.0f);
        [timeBtn setTitle:@"预约时间"
                      forState:UIControlStateNormal];
        [timeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [timeBtn setTitleColor:[UIColor whiteColor]
                           forState:UIControlStateNormal];
        [timeBtn setBackgroundColor:[UIColor lightGrayColor]];
        
        [timeBtn addTarget:self
                         action:@selector(btnClick)
               forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:timeBtn];
        [timeBtn setHidden:YES];
        
 
        
        submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = CGRectMake((ViewWidth - 76.0f) / 2, 480.0f, 76.0f, 26.0f);
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
        [scrollView addSubview:submitButton];
        
        
        scrollView.contentSize = CGSizeMake(ViewWidth, 800.0f);
    }
    return self;
}
-(void)isMaterial{
    if ([materialSwitch isOn]) {
        [bxfield setHidden:NO];
        
    }else{
        [bxfield setHidden:YES];
        
    }
}
-(void)btnClick{
//    RBCustomDatePickerView *pickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    pickerView.backgroundColor=[UIColor whiteColor];
//    [self addSubview:pickerView];
    id object = [self nextResponder];
    while (![object isKindOfClass:[TSBX_BXController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    if ([object isKindOfClass:[TSBX_BXController class]]) {
        [((TSBX_BXController*)object) selecTime];
    }


    
}
-(void)segChange:(UISegmentedControl *)segm{
    NSInteger index=segm.selectedSegmentIndex;
    switch (index) {
        case 0:
            [timeBtn setHidden:YES];
            [timeLabel setHidden:YES];
            scrollView.contentSize = CGSizeMake(ViewWidth, 516);
            [submitButton setFrame:CGRectMake((ViewWidth - 76.0f) / 2, 470.0f, 76.0f, 26.0f)];

            break;
        case 1:
            [timeBtn setHidden:NO];
            [timeLabel setHidden:NO];
            [submitButton setFrame:CGRectMake((ViewWidth - 76.0f) / 2, 470.0f+50, 76.0f, 26.0f)];
            scrollView.contentSize = CGSizeMake(ViewWidth, 700);
            
            break;
            
        default:
            break;
    }
}
-(void)changeTime:(NSNotification *)notice{
    NSLog(@"OK------");
    NSDictionary *dic=[notice userInfo];
    if (!dic||dic==nil) {
        return;
    }
    NSLog(@"%@",dic);
    [timeBtn setTitle:[dic objectForKey:@"nowTime"] forState:UIControlStateNormal];

}
// 键盘弹出和消失时重新设置scrllview的frame
- (void)setScrollViewFrame
{
    scrollView.frame = self.bounds;
}

- (void)switchChanged:(SevenSwitch *)sender
{
    if (sender.tag == 1 || sender.tag == 2) {
        // 如果某个switch的状态是on,则要将其他switch的状态改为off
        if (sender.isOn) {
            for (int i = 1; i <= 2; i++) {
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
}

- (void)submitButtonClick
{
    [bxTextView resignFirstResponder];
    int repairType = 0;
    for (int i = 1; i <= 2; i++) {
        SevenSwitch *view = (SevenSwitch *)[self viewWithTag:i];
        if (view.isOn) {
            repairType = i;
        }
    }
    
    if (repairType == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"选择报修的类型"];
        return;
    }
    
    NSString *bxString = [bxTextView.text trim];
    if ([bxString isEmptyOrBlank] || bxString == nil) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入要报修的内容"];
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
    if (seg.selectedSegmentIndex==0) {
        NSDictionary *repairDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                                    bxString, @"content",
                                    pictureURL, @"picture",
                                    [NSString stringWithFormat:@"%d", repairType], @"repairType",
                                    [NSString stringWithFormat:@"%d", materialSwitch.isOn ? 1 : 0], @"needMaterial",
                                    nil];
        
        id object = [self nextResponder];
        while (![object isKindOfClass:[TSBX_BXController class]] &&
               object != nil) {
            object = [object nextResponder];
        }
        if ([object isKindOfClass:[TSBX_BXController class]]) {
            [((TSBX_BXController*)object) submitRepairDict:repairDict];
        }

    }if (seg.selectedSegmentIndex==1) {
        if ([timeBtn.titleLabel.text isEqualToString:@"预约时间"]) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请选择预约时间"];
        }else{
            NSDictionary *repairDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"communityId",
                                        bxString, @"content",
                                        pictureURL, @"picture",timeBtn.titleLabel.text,@"appointTime",
                                        [NSString stringWithFormat:@"%d", repairType], @"repairType",
                                        [NSString stringWithFormat:@"%d", materialSwitch.isOn ? 1 : 0], @"needMaterial",
                                        nil];
            
            id object = [self nextResponder];
            while (![object isKindOfClass:[TSBX_BXController class]] &&
                   object != nil) {
                object = [object nextResponder];
            }
            if ([object isKindOfClass:[TSBX_BXController class]]) {
                [((TSBX_BXController*)object) submitYYrepairDict:repairDict];
            }

            
        }
    }
    
}

#pragma mark MultiImageUploadViewDelegate
- (void)hideKeyboard
{
    [bxTextView resignFirstResponder];
}

@end

@implementation TSBX_BXController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    bxView = [[TSBX_BXView alloc] initWithFrame:CGRectMake(LeftMargin, -Offset, ViewWidth, kNavContentHeight + Offset) controller:self];
    [self.view addSubview:bxView];
    
    [self customBackButton:self];
    self.title = @"报修";
    
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
-(void)selecTime{
    timePickerViewController *pv=[[timePickerViewController alloc]init];
    [self.navigationController pushViewController:pv animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//这里要修改
- (void)submitRepairDict:(NSDictionary *)dict
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] repairWithDict:dict
                                              complete:^(BOOL success, ComplainAndRepairResponse *resp) {
                                                  if (success && resp.result == RESPONSE_SUCCESS) {
                                                      [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:[NSString stringWithFormat:@"报修成功\n报修编号:%@", resp.no]];
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
-(void)submitYYrepairDict:(NSDictionary *)dict{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] YYrepairWithDict:dict
                                              complete:^(BOOL success, ComplainAndRepairResponse *resp) {
                                                  if (success && resp.result == RESPONSE_SUCCESS) {
                                                      [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:[NSString stringWithFormat:@"预约报修成功\n报修编号:%@", resp.no]];
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
                         CGRect frame = bxView.frame;
                         frame.size.height = kNavContentHeight + Offset - keybordHeight;
                         bxView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [bxView setScrollViewFrame];
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
                         CGRect frame = bxView.frame;
                         frame.size.height = kNavContentHeight + Offset;
                         bxView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [bxView setScrollViewFrame];
                         }
                     }
     ];
}

@end
