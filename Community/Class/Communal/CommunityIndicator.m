//
//  CommunityIndicator.m
//  Community
//
//  Created by SYZ on 13-12-3.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityIndicator.h"
#import "AppDelegate.h"

@implementation CommunityIndicator

+ (CommunityIndicator *)sharedInstance
{
    static CommunityIndicator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CommunityIndicator alloc] initWithFrame:CGRectMake(0.0f, 64.0f, kContentWidth, kNavContentHeight)];
    });
    
    return sharedInstance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        indicatorLoading = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, IndicatorSize, IndicatorSize)];
        indicatorLoading.image = [UIImage imageNamed:@"indicator_loading"];
        indicatorLoading.center = CGPointMake(self.center.x, self.center.y - CeterOffset);
        [self addSubview:indicatorLoading];
        
        indicatorTextBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, NoteBgWidth, NoteBgHeight)];
        indicatorTextBg.image = [UIImage imageNamed:@"indicator_text_bg"];
        indicatorTextBg.center = CGPointMake(self.center.x, self.center.y - CeterOffset);
        [self addSubview:indicatorTextBg];
        
        noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 2.0f, NoteLabelWidth, 80.0f)];
        noteLabel.textColor = [UIColor colorWithHexValue:0xFF767477];
        noteLabel.backgroundColor = [UIColor clearColor];
        noteLabel.font = [UIFont systemFontOfSize:18.0f];
        noteLabel.textAlignment = NSTextAlignmentCenter;
        noteLabel.numberOfLines = 0;
        [indicatorTextBg addSubview:noteLabel];
    }
    return self;
}

- (void)startLoading
{
    [self hideIndicator:NO];
    
    [theAppDelegate.window addSubview:self];
    indicatorTextBg.hidden = YES;
    indicatorLoading.hidden = NO;
    indicatorLoading.alpha = 1.0f;
    self.userInteractionEnabled = YES;
    
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:MAXFLOAT];
    fullRotation.duration = MAXFLOAT * 0.1;
    fullRotation.removedOnCompletion = YES;
    
    [indicatorLoading.layer addAnimation:fullRotation forKey:@"rotation"];
}

- (void)showNoteWithTextManuallyHide:(NSString *)text
{
    [self hideIndicator:NO];
    self.userInteractionEnabled = YES;
    
    [theAppDelegate.window addSubview:self];
    indicatorLoading.hidden = YES;
    indicatorTextBg.hidden = NO;
    indicatorTextBg.alpha = 0.0f;
    noteLabel.text = text;
    
    [UIView animateWithDuration:Duration
                     animations:^{
        indicatorTextBg.alpha = 1.0f;
    }];
}

- (void)showNoteWithTextAutoHide:(NSString *)text
{
    [self hideIndicator:NO];
    self.userInteractionEnabled = NO;
    
    [theAppDelegate.window addSubview:self];
    indicatorLoading.hidden = YES;
    indicatorTextBg.hidden = NO;
    indicatorTextBg.alpha = 0.0f;
    noteLabel.text = text;
    
    [UIView animateWithDuration:Duration
                     animations:^{
                         indicatorTextBg.alpha = 1.0f;
                     }];
    
    [self performSelector:@selector(hideIndicator:) withObject:[NSNumber numberWithBool:YES] afterDelay:HideDelay];
}

- (void)hideIndicator:(BOOL)animation
{
    void (^viewBlock)(void) = ^{
        [indicatorLoading.layer removeAnimationForKey:@"rotation"];
        noteLabel.text = @"";
        [self removeFromSuperview];
    };
    
    if (animation) {
        if (!indicatorTextBg.hidden) {
            [indicatorLoading.layer removeAnimationForKey:@"rotation"];
            [UIView animateWithDuration:Duration
                             animations:^{
                                 indicatorTextBg.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     viewBlock();
                                 }
                             }];
        } else if (!indicatorLoading.hidden) {
            noteLabel.text = @"";
            [UIView animateWithDuration:Duration
                             animations:^{
                                 indicatorLoading.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 if (finished) {
                                     viewBlock();
                                 }
                             }];
        }
    } else {
        viewBlock();
    }
}

@end
