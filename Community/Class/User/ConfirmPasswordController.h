//
//  ConfirmPasswordController.h
//  Community
//
//  Created by SYZ on 13-11-18.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityRootController.h"
#import "RegisterView.h"
#import "HttpClientManager.h"

@interface ConfirmPasswordController : CommunityViewController <ConfirmPasswordViewDelegate>
{
    NSString *phoneNumber;
    
    ConfirmPasswordView *confirmPasswordView;
    CommunityTableView  *tableView;
}

- (id)initWithPhoneNumber:(NSString *)phone;

@end
