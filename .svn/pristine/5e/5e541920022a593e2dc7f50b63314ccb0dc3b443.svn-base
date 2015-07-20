//
//  TSBX_BXController.h
//  Community
//
//  Created by SYZ on 13-11-28.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "HttpClientManager.h"
#import "SevenSwitch.h"
#import "ImageUtil.h"
#import "MultiImageUploadView.h"

@interface TSBX_BXView : UIView <MultiImageUploadViewDelegate>
{
    UIScrollView *scrollView;
    
    SevenSwitch *grbxSwitch;
    SevenSwitch *ggbxSwitch;
    SevenSwitch *materialSwitch;
    UIButton *submitButton;
    
    UISegmentedControl *seg;
    
    UITextView *bxTextView;
    MultiImageUploadView *imageUploadView;
    UITextField *bxfield;
    
    UIButton *timeBtn;
    UILabel *timeLabel;
}

- (id)initWithFrame:(CGRect)frame controller:(CommunityViewController *)controller;
// 键盘弹出和消失时重新设置scrllview的frame
- (void)setScrollViewFrame;

@end

@interface TSBX_BXController : CommunityViewController
{
    TSBX_BXView *bxView;
}
-(void)selecTime;

- (void)submitRepairDict:(NSDictionary *)dict;
-(void)submitYYrepairDict:(NSDictionary *)dict;

@end
