//
//  YinSiViewController.h
//  Housekeeper
//
//  Created by HuaMen on 14-9-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface YinSiViewController : CommunityViewController
{
    UIScrollView *Scrollview;
    UISwitch *AgreeSwitch;
    UIButton *nextTepBtn;
    UILabel *AgreeLabel;
    UIButton *gouBtn;
    BOOL agree;
}

@end
