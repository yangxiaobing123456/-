//
//  TSBXAndWYJFViewControl.m
//  Community
//
//  Created by SYZ on 13-12-20.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "TSBXAndWYJFViewControl.h"

@implementation TSBXAndWYJFViewControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 56.0f, 56.0f)];
        [self addSubview:imageView];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.userInteractionEnabled = NO;
        button.frame = CGRectMake(0.0f, 86.0f, 76.0f, 26.0f);
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [button setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                          forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"icon10"]
                          forState:UIControlStateHighlighted];
        [self addSubview:button];
    }
    return self;
}

- (void)setImage:(UIImage *)image title:(NSString *)title
{
    imageView.image = image;
    [button setTitle:title forState:UIControlStateNormal];
}

@end
