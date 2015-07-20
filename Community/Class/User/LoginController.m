//
//  LoginController.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "LoginController.h"
#import "NSData+Base64.h"
#import "YinSiViewController.h"

@interface LoginController ()

@end

@implementation LoginController

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
	
    self.title = @"登录";
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kNavContentHeight - TopMargin);
    loginView = [[LoginView alloc] initWithFrame:rect];
    loginView.backgroundColor = [UIColor clearColor];
    loginView.delegate = self;
    
    tableView = [[CommunityTableView alloc] initWithFrame:CGRectMake(0.0f, kContentHeight - EnterPartViewY, kContentWidth, kContentHeight)
                                                    style:UITableViewStylePlain];
    tableView.bounces = NO;
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:loginView];
    [self.view addSubview:tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iOS7) {
        button.frame = CGRectMake(0.0f, 0.0f, 12.0f, 20.0f);
    } else {
        button.frame = CGRectMake(0.0f, 0.0f, 22.0f, 20.0f);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f)];
    }
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissAction)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)dismissAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showLoginViewWithAnimate];
    
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

- (void)showLoginViewWithAnimate
{
    [UIView animateWithDuration:0.5f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         tableView.frame = CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight);
                     }
                     completion:nil];
}

#pragma mark LoginViewDelegate methods
- (void)didGetBackPassword
{
    GetBackPasswordController *controller = [[GetBackPasswordController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didUserRegister
{
    YinSiViewController *controller = [[YinSiViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
//    GetVerifyCodeController *controller = [[GetVerifyCodeController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didLoginWithPhoneNumber:(NSString *)phone password:(NSString *)password
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:phone forKey:@"phoneMHP"];
    
    [[CommunityIndicator sharedInstance] startLoading];
    
    NSDictionary *loginDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [password stringFromSHA256], @"password",
                               phone, @"telephone",
                               [NSNumber numberWithInt:1], @"from",
                               [AppSetting deviceToken] == nil ? @"12345" : [AppSetting deviceToken], @"token", nil];
    NSLog(@"%@",loginDict);
    [[HttpClientManager sharedInstance] userLoginWithDict:loginDict
                                                 complete:^(BOOL success, int result, UserInfo *info) {
        if (success && result == RESPONSE_SUCCESS) {
            info.password = [password stringFromSHA256];
            NSString *url = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.picture];
            info.picture = url;
            if ([[CommunityDbManager sharedInstance] insertOrUpdateUserInfo:info]) {
                [HttpResponseNotification loginHttpResponse:result];
                [AppSetting saveUserId:info.userId];
                [AppSetting savePassowrd:info.password];
                [AppSetting saveCommunityId:info.communityId];
                [AppSetting downloadAvatar];
                CommunityRootController *rootController = [CommunityRootController new];
                [self presentViewController:rootController animated:YES completion:nil];
            }
        } else {
            [HttpResponseNotification loginHttpResponse:result];
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
                             tableView.contentOffset = CGPointMake(0.0f, 106.0f);
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
                         tableView.frame = CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight);
                     }
                     completion:nil
     ];
}

@end
