//
//  AppDelegate.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityCoreDataManager.h"
#import "CommunitySplashController.h"

// 全局AppDelegate
#define theAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CommunitySplashController *splashController;
//@property (strong, nonatomic) CommunityCoreDataManager *coreDataManager;

@end
