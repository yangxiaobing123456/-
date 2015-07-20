//
//  CheckImageView.m
//  Community
//
//  Created by SYZ on 14-4-25.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CheckImageView.h"
#import "AppDelegate.h"

@implementation CheckImageView

+ (CheckImageView *)sharedInstance
{
    static CheckImageView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CheckImageView alloc] initWithFrame:theAppDelegate.window.bounds];
        [theAppDelegate.window addSubview:sharedInstance];
    });
    
    return sharedInstance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
        imageView.center = theAppDelegate.window.center;
        [self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    self.hidden = NO;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         imageView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 320.0f);
                         imageView.center = self.center;
                         imageView.image = image;
                     }];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         imageView.frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
                         imageView.center = self.center;
                         imageView.image = nil;
                     } completion:^(BOOL finished) {
                         if (finished) {
                             self.hidden = YES;
                         }
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
