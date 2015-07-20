//
//  GetVerifyCodeController.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "GetVerifyCodeController.h"

@interface GetVerifyCodeController ()

@end

@implementation GetVerifyCodeController

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
    
    self.title = @"注册";
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kContentHeight);
    getVerifyCodeView = [[GetVerifyCodeView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, 330.0f)];
    getVerifyCodeView.delegate = self;
	
    tableView = [[CommunityTableView alloc] initWithFrame:rect
                                                    style:UITableViewStylePlain];
    [tableView setBounces:NO];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:getVerifyCodeView];
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [getVerifyCodeView stopTimer];
    
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

#pragma mark GetVerifyCodeViewDelegate methods
- (void)didGetVerifyCodeWithPhoneNumber:(NSString *)phone
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    [[HttpClientManager sharedInstance] getVerifyCodeWithPhoneNumber:phone
                                                            complete:^(BOOL success, int result) {
        [HttpResponseNotification getVerifyCodeHttpResponse:result];
                                                                
        if (success && result == RESPONSE_SUCCESS) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kResultGetVerifyCode object:@"SUCCESS"];
            ConfirmPasswordController *controller = [[ConfirmPasswordController alloc] initWithPhoneNumber:phone];
            [self.navigationController pushViewController:controller animated:YES];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kResultGetVerifyCode object:@"FAIL"];
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
