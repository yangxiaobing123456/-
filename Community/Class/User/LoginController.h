//
//  LoginController.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "GetVerifyCodeController.h"
#import "GetBackPasswordController.h"
#import "CommunityRootController.h"
#import "LoginView.h"
#import "HttpClientManager.h"
#import "GuideController.h"

@interface LoginController : CommunityViewController <LoginViewDelegate>
{
    LoginView *loginView;
    CommunityTableView  *tableView;
}

@end
