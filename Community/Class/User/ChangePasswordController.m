//
//  ChangePasswordController.m
//  Community
//
//  Created by SYZ on 14-1-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "ChangePasswordController.h"

@interface ChangePasswordController ()

@end

@implementation ChangePasswordController

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
	
    self.title = @"修改密码";
    
    changePasswordView = [[ChangePasswordView alloc] initWithFrame:[ChangePasswordView changePasswordViewFrame]];
    [self.view addSubview:changePasswordView];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect
                                                    style:UITableViewStylePlain];
    tableView.bounces = NO;
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:changePasswordView];
    [self.view addSubview:tableView];
	
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

- (void)changePasswordWithNewpwd:(NSString *)newPwd
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    NSDictionary *changeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [AppSetting userPassword], @"oldPassword",
                                newPwd, @"newPassword", nil];
    
    [[HttpClientManager sharedInstance] changePasswordWithDict:changeDict
                                                      complete:^(BOOL success, int result) {
                                                          [HttpResponseNotification changePasswordHttpResponse:result];
                                                          if (success && result == RESPONSE_SUCCESS) {
                                                              [AppSetting savePassowrd:newPwd];
                                                              [self.navigationController popViewControllerAnimated:YES];
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
                         frame.size.height -= keyboardHeight;
                         tableView.frame = frame;
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
