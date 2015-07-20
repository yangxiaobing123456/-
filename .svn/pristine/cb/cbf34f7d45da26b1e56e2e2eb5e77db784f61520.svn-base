//
//  GetBackPasswordController.m
//  Community
//
//  Created by SYZ on 13-11-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "GetBackPasswordController.h"

@interface GetBackPasswordController ()

@end

@implementation GetBackPasswordController

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
    
    self.title = @"找回密码";
    
    getPasswordView = [[GetPasswordView alloc] initWithFrame:[GetPasswordView getPasswordViewFrame]];
    [self.view addSubview:getPasswordView];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect
                                                    style:UITableViewStylePlain];
    tableView.bounces = NO;
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:getPasswordView];
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

- (void)forgetPasswordWithPhoneNumber:(NSString *)phone
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] forgetPasswordWithPhoneNumber:phone
                                                             complete:^(BOOL success, int result) {
        [HttpResponseNotification getVerifyCodeHttpResponse:result];
                                                                 
        if (success && result == RESPONSE_SUCCESS) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kResultGetVerifyCode object:@"SUCCESS"];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kResultGetVerifyCode object:@"FAIL"];
        }
    }];
}

- (void)changeForgetPasswordWithDict:(NSDictionary *)dict
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] changeForgetPasswordWithDict:dict
                                                            complete:^(BOOL success, int result) {
        if (success && result == RESPONSE_SUCCESS) {
            [HttpResponseNotification changeForgetPasswordHttpResponse:result];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [HttpResponseNotification changeForgetPasswordHttpResponse:result];                                                        
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
