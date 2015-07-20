//
//  LoginView.h
//  Community
//
//  Created by SYZ on 13-11-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EnterPartViewY    180.0

@protocol LoginViewDelegate <NSObject>

- (void)didGetBackPassword;
- (void)didUserRegister;
- (void)didLoginWithPhoneNumber:(NSString *)phone password:(NSString *)password;

@end

@interface LoginView : UIView <UITextFieldDelegate>
{
    UITextField *phoneField;
    UITextField *passwordField;
}

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end
