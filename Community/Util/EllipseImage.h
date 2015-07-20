//
//  EllipseImage.h
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EllipseImage : NSObject

+ (UIImage *)ellipseImage:(UIImage *)image
                withInset:(CGFloat)inset;

+ (UIImage *)ellipseImage:(UIImage *)image
                withInset:(CGFloat)inset
          withBorderWidth:(CGFloat)width
          withBorderColor:(UIColor*)color;

@end
