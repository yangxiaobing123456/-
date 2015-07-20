//
//  EllipseImageControl.m
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "EllipseImageControl.h"

#define Diameter   54.0f

@implementation EllipseImageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - Diameter) / 2, 0.0f, Diameter, Diameter)];
        [self addSubview:imageView];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, Diameter, self.frame.size.width, 20.0f)];
        textLabel.textColor = [UIColor grayColor];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:textLabel];
    }
    return self;
}

- (void)setImage:(UIImage *)image text:(NSString *)text
{
    textLabel.text = text;
//    imageView.image = [EllipseImage ellipseImage:image
//                                       withInset:0.0f
//                                 withBorderWidth:5.0f
//                                 withBorderColor:[UIColor whiteColor]];
    imageView.image=image;
}

@end
