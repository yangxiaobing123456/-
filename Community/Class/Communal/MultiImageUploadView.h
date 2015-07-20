//
//  MultiImageUploadView.h
//  Community
//
//  Created by SYZ on 14-7-30.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UploadImageCount    5

@class CommunityViewController;

@protocol MultiImageUploadViewDelegate <NSObject>

@optional
- (void)hideKeyboard;

@end

@interface UploadImageControl : UIControl
{
    UIImageView *imageView;
    UIButton *deleteButton;
}

@property(nonatomic, strong) UIImage *image;

@end

@interface MultiImageUploadView : UIView <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
    UIButton *addImageButton;
    UploadImageControl *control1;
    UploadImageControl *control2;
    UploadImageControl *control3;
    UploadImageControl *control4;
    UploadImageControl *control5;
    //修改
    UploadImageControl *control6;

    NSMutableArray *imageArray;
}

@property (nonatomic, weak) id<MultiImageUploadViewDelegate> delegate;
@property (nonatomic, strong) CommunityViewController *controller;
@property (nonatomic, strong) NSMutableArray *URLArray;
@property (nonatomic) int type;

- (void)reloadView;
- (void)deleteImage:(int)tag;

@end
