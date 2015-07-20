//
//  CommunityHomeControl.m
//  Community
//
//  Created by SYZ on 14-3-6.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityHomeControl.h"

@implementation CommunityHomeControl

- (id)initWithPoint:(CGPoint)point sizeType:(HomeControlSizeType)type
{
    _sizeType = type;
    
    CGRect frame;
    switch (_sizeType) {
        case BIGSIZE:
            frame = CGRectMake(point.x, point.y, BigSize.width, BigSize.height);
            break;
            
        case MIDDLESIZE:
            frame = CGRectMake(point.x, point.y, MiddleSize.width, MiddleSize.height);
            break;
            
        case SMALLSIZE:
            frame = CGRectMake(point.x, point.y, SmallSize.width, SmallSize.height);
            break;
            
        default:
            break;
    }
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        [self setContentViewFrame];
    }
    return self;
}

- (void)setContentViewFrame
{
    switch (_sizeType) {
        case BIGSIZE:
            iconView.frame = CGRectMake(40.0f, 15.0f,self.frame.size.width - 80.0f, self.frame.size.width - 80.0f);
            titleLabel.frame = CGRectMake(38.0f, 100.0f, 100.0f, 28.0f);
            titleLabel.font = [UIFont systemFontOfSize:18.0f];
            break;
            
        case MIDDLESIZE:
            iconView.frame = CGRectMake(15.0f, (self.frame.size.height - 28.0f) / 2, 28.0f, 28.0f);
            titleLabel.frame = CGRectMake(58.0f, (self.frame.size.height - 28.0f) / 2, 100.0f, 28.0f);
            titleLabel.font = [UIFont systemFontOfSize:18.0f];
            break;
            
        case SMALLSIZE:
            iconView.frame = CGRectMake((self.frame.size.width - 28.0f) / 2, 15.0f, 28.0f, 28.0f);
            titleLabel.frame = CGRectMake(0.0f, 43.0f, self.frame.size.width, 20.0f);
            titleLabel.font = [UIFont systemFontOfSize:12.0f];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
            
        default:
            break;
    }
}

- (void)setImage:(UIImage *)iconImage title:(NSString *)title
{
    iconView.image = iconImage;
    titleLabel.text = title;
}

- (void)setNotice:(NoticeInfo *)notice
{
    _notice = notice;
    
    iconView.hidden = NO;
    [iconView setImage:[UIImage imageNamed:@"益社区_最新通知"]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(25.0f, 0.0f, self.frame.size.width-25.0f, self.frame.size.height);
    titleLabel.numberOfLines = 3;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    if (!_notice) {
        titleLabel.text = @"暂无最新通知";
        return;
    }
    
    titleLabel.text = notice.title;
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
