//
//  LoadMoreCell.m
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "LoadMoreCell.h"

@implementation LoadMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSString *title = @"正在加载...";
        UIFont *font = [UIFont systemFontOfSize:12];
        float height = CGRectGetHeight(self.contentView.bounds);
        CGSize titleSize = [title sizeWithFont:font];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, titleSize.width, titleSize.height)];
        titleLabel.text = title;
        titleLabel.center = self.contentView.center;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = font;
        [self.contentView addSubview:titleLabel];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGRect rect = CGRectMake(titleLabel.frame.origin.x - 30.0f, (height - 20.0f) / 2, 20.0f, 20.0f);
        _activityView.frame = rect;
        [self.contentView addSubview:_activityView];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)startActivityView
{
    [_activityView startAnimating];
}

@end
