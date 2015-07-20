//
//  communityNewTableViewCell.h
//  Community
//
//  Created by HuaMen on 14-11-24.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communityNewTableViewCell : UITableViewCell
{
    UIImageView *bgView;
    UILabel *titleLabel;
}

- (void)setTitle:(NSString *)title bgWithArrow:(BOOL)arrow;

@end
