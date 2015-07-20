//
//  CommunityTableView.m
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

// 设置TableView的偏移量
#import "CommunityTableView.h"

@implementation CommunityTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    newFrame = CGRectMake(frame.origin.x, frame.origin.y - OFFSET, frame.size.width, frame.size.height);
    self = [super initWithFrame:newFrame style:style];
    
    if (self) {
        self.contentInset = UIEdgeInsetsMake(OFFSET + TopMargin, 0.0f, 0.0f, 0.0f);
        self.scrollIndicatorInsets = UIEdgeInsetsMake(OFFSET + TopMargin, 0.0f, 0.0f, 0.0f);
    }
    return self;
}

- (CGRect)tableViewFrame
{
    return newFrame;
}

@end
