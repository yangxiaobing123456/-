//
//  ConfirmPasswordController.m
//  Community
//
//  Created by SYZ on 13-11-18.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "ConfirmPasswordController.h"
#import "UpdateUserInfoController.h"

@interface ConfirmPasswordController ()

@end

@implementation ConfirmPasswordController

- (id)initWithPhoneNumber:(NSString *)phone
{
    self = [super init];
    if (self) {
        phoneNumber = phone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"注册";
    //11
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kContentHeight);
    confirmPasswordView = [[ConfirmPasswordView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, 485.0f)];
    confirmPasswordView.delegate = self;
    
    tableView = [[CommunityTableView alloc] initWithFrame:rect
                                                    style:UITableViewStylePlain];
    tableView.bounces = NO;
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [tableView setTableHeaderView:confirmPasswordView];
//11  
    UIScrollView *myScrollViews = [[UIScrollView alloc] initWithFrame:self.view.frame];
    myScrollViews.contentSize = CGSizeMake(320, 600);
    [myScrollViews addSubview:confirmPasswordView];
    [self.view addSubview:myScrollViews];

    
//    [self.view addSubview:tableView];
    
    [self customBackButton:self];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ConfirmPasswordViewDelegate methods
- (void)didRegisterWithPassword:(NSString *)password verifyCode:(NSString*)code phone:(NSString *)phone invite_name:(NSString *)invite_name invite_number:(NSString *)invite_number
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    //from: 1 表示iphone用户; 2 表示android用户;3 表示web用户
    NSDictionary *registerDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [password stringFromSHA256], @"password",
                                  phone, @"telephone",
                                  code, @"verifyCode",
                                  invite_name, @"invite_name",
                                  invite_number, @"invite_number",
                                  [NSNumber numberWithInt:1], @"version",
                                  [NSNumber numberWithInt:1], @"from",
                                  @"", @"token", nil];
    
    [[HttpClientManager sharedInstance] userRegisterWithDict:registerDict
                                                    complete:^(BOOL success, int result, long long userId) {
        if (success && result == RESPONSE_SUCCESS) {
            UserInfo *info = [UserInfo new];
            info.userId = userId;
            info.password = [password stringFromSHA256];
            
            if ([[CommunityDbManager sharedInstance] insertOrUpdateUserInfo:info]) {
                [HttpResponseNotification registerHttpResponse:result];
                [AppSetting saveUserId:userId];
                [AppSetting savePassowrd:[password stringFromSHA256]];
//                CommunityRootController *rootController = [CommunityRootController new];
                UpdateUserInfoController *rootController = [UpdateUserInfoController new];
//                [self presentViewController:rootController animated:YES completion:nil];
                [self.navigationController pushViewController:rootController animated:YES];
            }
        } else {
            [HttpResponseNotification registerHttpResponse:result];
        }
    }];
}

#pragma mark Observer methods
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame;
    [[[((NSNotification *)notification) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    float keyboardHeight = CGRectGetHeight(keyboardFrame);
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGRect frame = tableView.frame;
//                         frame.size.height -= keyboardHeight;
                         frame.size.height = frame.size.height - keyboardHeight + 80;
                         tableView.frame = frame;
                         if (!iPhone5) {
                             tableView.contentOffset = CGPointMake(0.0f, 80.0f);
                         }
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
                         tableView.frame = [tableView tableViewFrame];
                     }
                     completion:nil
     ];
}

@end
