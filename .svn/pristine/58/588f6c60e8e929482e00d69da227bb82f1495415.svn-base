//
//  communityNewTableViewCell.m
//  Community
//
//  Created by HuaMen on 14-11-24.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "communityNewTableViewCell.h"
#define LeftMargin           8
#define TableViewWidth       304
#define MoreCellHeight       45

static UIImage *bgImage = nil;
static UIImage *arrowImage = nil;
@implementation communityNewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"more_cell_bg"];
        }
        if (!arrowImage) {
            arrowImage = [UIImage imageNamed:@"more_cell_arrow_bg"];
        }
    }
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake((TableViewWidth - 266.0f) / 2, 0.0f, 266.0f, 39.0f)];
    [self.contentView addSubview:bgView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 120.0f, 40.0f)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:titleLabel];
    
    return self;
}

- (void)setTitle:(NSString *)title bgWithArrow:(BOOL)arrow
{
    titleLabel.text = title;
    if (arrow) {
        bgView.image = arrowImage;
    } else {
        bgView.image = bgImage;
    }
}

@end

