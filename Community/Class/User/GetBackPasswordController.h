//
//  GetBackPasswordController.h
//  Community
//
//  Created by SYZ on 13-11-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "GetPasswordView.h"
#import "HttpClientManager.h"

@interface GetBackPasswordController : CommunityViewController
{
    GetPasswordView *getPasswordView;
    CommunityTableView *tableView;
}

- (void)forgetPasswordWithPhoneNumber:(NSString *)phone;
- (void)changeForgetPasswordWithDict:(NSDictionary *)dict;

@end
