//
//  CommunityMoreHeaderView.m
//  Community
//
//  Created by SYZ on 14-3-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityMoreHeaderView.h"

@implementation CommunityMoreHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topBgView = [[UIImageView alloc] initWithFrame:CGRectMake(266.0f-60+50, 0.0f, 47.0, 47.0f)];
        topBgView.image = [UIImage imageNamed:@"logo_000001"];
        [self addSubview:topBgView];
        
        headerContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 266.0f-50, frame.size.height)];
        headerContentLabel.textColor = [UIColor blackColor];
        headerContentLabel.backgroundColor = [UIColor clearColor];
        headerContentLabel.font = [UIFont systemFontOfSize:14.0f];
        headerContentLabel.numberOfLines = 0;
        [self addSubview:headerContentLabel];
        
        
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    headerContentLabel.text = content;
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
