//
//  CommunityIndicator.h
//  Community
//
//  Created by SYZ on 13-12-3.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IndicatorSize       64.0f
#define CeterOffset         150.0f
#define NoteBgWidth         230.0f
#define NoteBgHeight        88.0f
#define NoteLabelWidth      210.0f
#define Duration            0.3f
#define HideDelay           2.5f

@interface CommunityIndicator : UIView
{
    UIView *backgroundView;
    UIImageView *indicatorTextBg;
    UIImageView *indicatorLoading;
    UILabel *noteLabel;
}

+ (CommunityIndicator *)sharedInstance;

- (void)startLoading;
- (void)showNoteWithTextManuallyHide:(NSString *)text;
- (void)showNoteWithTextAutoHide:(NSString *)text;

- (void)hideIndicator:(BOOL)animation;

@end
