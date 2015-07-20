//
//  ZFPWDViewController.h
//  Community
//
//  Created by HuaMen on 14-10-10.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface ZFPWDViewController : CommunityViewController<UITextFieldDelegate>
{
    UITextField *oldPasswordField;
    UITextField *newPasswordField;
    UITextField *repeatPwdField;
    UIButton *confirmButton;
    UIScrollView *scrollView;
}

@end
