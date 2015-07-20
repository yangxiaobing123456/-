//
//  CommunityViewController.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

//Community所有controller都要继承于CommunityViewController,特殊除外

#import <UIKit/UIKit.h>

@interface CommunityViewController : UIViewController
{
    UIImageView *backgroundView;
}

// 自定义有返回按钮
- (void)customBackButton:(UIViewController*)controller;
- (void)goBackAction;
- (void)changBackgroundViewFrame;

@end
