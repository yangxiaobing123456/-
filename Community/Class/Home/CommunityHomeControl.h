//
//  CommunityHomeControl.h
//  Community
//
//  Created by SYZ on 14-3-6.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeInfo.h"

typedef enum
{
    BIGSIZE,
    MIDDLESIZE,
    SMALLSIZE,
} HomeControlSizeType;

#define BigSize     CGSizeMake(148.0f, 148.0f)
#define MiddleSize  CGSizeMake(148.0f, 70.0f)
#define SmallSize   CGSizeMake(70.0f, 70.0f)

@interface CommunityHomeControl : UIControl
{
    UIImageView *iconView;
    UILabel *titleLabel;
}

@property (nonatomic) HomeControlSizeType sizeType;
@property (nonatomic, strong) NoticeInfo *notice;

- (id)initWithPoint:(CGPoint)point sizeType:(HomeControlSizeType)type;
- (void)setImage:(UIImage *)iconImage title:(NSString *)title;

@end
