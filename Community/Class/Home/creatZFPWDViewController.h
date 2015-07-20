//
//  creatZFPWDViewController.h
//  Community
//
//  Created by HuaMen on 14-10-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface creatZFPWDViewController : CommunityViewController<UITextFieldDelegate>{
    UITextField *phoneField;
    UIButton *getVerifyCodeButton;
    UIScrollView *scrollView;
    
    NSTimer *timer;
    int time;
}

@end
