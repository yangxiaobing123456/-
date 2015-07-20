//
//  TaskImageControl.m
//  Community
//
//  Created by SYZ on 14-4-25.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "TaskImageControl.h"
#import "ImageDownloader.h"
#import "ImageUtil.h"

@implementation TaskImageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [ImageUtil imageCenterWithImage:[UIImage imageNamed:@"default_loading"]
                                               targetSize:CGSizeMake(frame.size.width, frame.size.height)
                                          backgroundColor:[UIColor colorWithHexValue:0xFFDBDCDC]];
        [self addSubview:imageView];
    }
    return self;
}

- (void)downLoadImage:(NSString *)url
{
    if ([url isEmptyOrBlank]) {
        return;
    }
    NSString *imgPath = [PathUtil pathOfImage:[NSString stringWithFormat:@"%lu", (unsigned long)[url hash]]];
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imgPath]) { // 图片文件不存在
        ImageDownloadingTask *task = [ImageDownloadingTask new];
        [task setImageUrl:[NSString stringWithFormat:@"%@%@", kCommunityImageServer, url]];
        [task setUserData:url];
        [task setTargetFilePath:imgPath];
        [task setCompletionHandler:^(BOOL succeeded, ImageDownloadingTask *idt) {
            if(succeeded && idt != nil && [idt.userData isEqual:url]){
                UIImage *tempImg = [UIImage imageWithData:[idt resultImageData]];
                [imageView setImage:tempImg];
            }
        }];
        [[ImageDownloader sharedInstance] download:task];
    } else { //图片存在
        NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
        [imageView setImage:[UIImage imageWithData:imgData]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
