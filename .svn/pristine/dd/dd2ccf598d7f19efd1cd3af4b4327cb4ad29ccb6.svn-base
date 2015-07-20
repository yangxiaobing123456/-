//
//  AnimatedView.m
//  Community
//
//  Created by HuaMen on 14-12-8.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "AnimatedView.h"

@implementation AnimatedView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray * array = [[NSMutableArray alloc] init];
        int i = 0;
        while (i++ < 8) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%.2d.jpg", i]]];
        }
         
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
        imageView.tag = 1;
        [imageView setAnimationImages:array];
        //添加动画图片
        
        [imageView setImage:[UIImage imageNamed:@"01.jpg"]];
        //    imageView.image = [UIImage imageNamed:@"01.jpg"];
        //设置imageView的图片
        
        imageView.animationDuration = 0.1;
        //两秒钟，切换8张图片一次
        imageView.animationRepeatCount = 0;
        //重复5次
        
        [imageView startAnimating];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
