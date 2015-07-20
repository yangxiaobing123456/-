//
//  LoadMoreCell.h
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

//加载更多Cell
@interface LoadMoreCell : UITableViewCell
{
    UIColor *_titleColor;
    UIActivityIndicatorView *_activityView;
}

//隐藏风火轮
- (void)startActivityView;

@end
