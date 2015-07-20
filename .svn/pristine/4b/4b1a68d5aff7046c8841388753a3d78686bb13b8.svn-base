//
//  TSBX_TSController.h
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "HttpClientManager.h"
#import "SevenSwitch.h"
#import "ImageUtil.h"
#import "MultiImageUploadView.h"

@interface TSBX_TSView : UIView <MultiImageUploadViewDelegate>
{
    UIScrollView *scrollView;
    
    SevenSwitch *sqanSwitch;
    SevenSwitch *sqbjSwitch;
    SevenSwitch *sqlhSwitch;
    SevenSwitch *sqssSwitch;
    SevenSwitch *wyygSwitch;
    
    UITextView *tsTextView;
    MultiImageUploadView *imageUploadView;
}

- (id)initWithFrame:(CGRect)frame controller:(CommunityViewController *)controller;
// 键盘弹出和消失时重新设置scrllview的frame
- (void)setScrollViewFrame;

@end

@interface TSBX_TSController : CommunityViewController
{
    TSBX_TSView *tsView;
}

- (void)submitComplainDict:(NSDictionary *)dict;

@end
