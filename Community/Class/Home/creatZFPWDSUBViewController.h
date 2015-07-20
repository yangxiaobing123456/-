//
//  creatZFPWDSUBViewController.h
//  Community
//
//  Created by HuaMen on 14-10-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface creatZFPWDSUBViewController : CommunityViewController<UITextFieldDelegate>
{
    UIScrollView *scrollView;
    UITextField *verifyCodeField;
    UITextField *passwordField;
    UITextField *repeatPwdField;
    UIButton *confirmButton;
}


@end
