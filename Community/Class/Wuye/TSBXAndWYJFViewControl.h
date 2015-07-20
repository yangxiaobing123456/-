//
//  TSBXAndWYJFViewControl.h
//  Community
//
//  Created by SYZ on 13-12-20.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSBXAndWYJFViewControl : UIControl
{
    UIImageView *imageView;
    UIButton *button;
}

- (void)setImage:(UIImage *)image title:(NSString *)title;

@end
