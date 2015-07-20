//
//  TaskEvaluateController.h
//  Community
//
//  Created by SYZ on 14-5-16.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityViewController.h"
#import "RatingView.h"
#import "SevenSwitch.h"

@protocol TaskEvaluateControllerDelegate;

@interface TaskEvaluateView : UIView <RatingViewDelegate>
{
    UIScrollView *scrollView;
    SevenSwitch *intimeSwitch;
    SevenSwitch *attitudeSwitch;
    SevenSwitch *needMaterialSwitch;
    SevenSwitch *paySwitch;
    SevenSwitch *invoicedSwitch;
    UILabel *satisfactionLabel;
    RatingView *rateView;
    UITextView *contentView;
}

@property (nonatomic, strong) NSString *taskId;

@end

@interface TaskEvaluateController : CommunityViewController
{
    UIScrollView *scrollView;
    TaskEvaluateView *evaluateView;
}

@property (nonatomic, weak) id<TaskEvaluateControllerDelegate> delegate;
@property (nonatomic, strong) NSString *taskId;

- (void)submitCommentDict:(NSDictionary *)dict;

@end

@protocol TaskEvaluateControllerDelegate <NSObject>

- (void)successEvaluate:(TaskEvaluateController *)controller;

@end
