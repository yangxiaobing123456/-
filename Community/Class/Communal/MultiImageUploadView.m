//
//  MultiImageUploadView.m
//  Community
//
//  Created by SYZ on 14-7-30.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "MultiImageUploadView.h"
#import "CommunityViewController.h"
#import "ImageUtil.h"
#import "CheckImageView.h"

@implementation UploadImageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, 40.0f, 40.0f)];
        [self addSubview:imageView];
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(30.0f, 0.0f, 20.0f, 20.0f);
        [deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    imageView.image = image;
    imageView.alpha = 1.0f;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         imageView.alpha = 1.0f;
                     }
     ];
}

- (void)deleteImage:(UIButton *)sender
{
    id object = [self nextResponder];
    while (![object isKindOfClass:[MultiImageUploadView class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    if ([object isKindOfClass:[MultiImageUploadView class]]) {
        [((MultiImageUploadView*)object) deleteImage:sender.superview.tag];
    }
}

@end

@implementation MultiImageUploadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageArray = [NSMutableArray new];
        _URLArray = [NSMutableArray new];
        
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        UIImage *bgImage = [UIImage imageNamed:@"mutil_image_upload_bg"];
        bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)
                                          resizingMode:UIImageResizingModeStretch];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:self.bounds];
        bg.image = bgImage;
        bg.alpha = 0.6f;
        [self addSubview:bg];
        
        addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addImageButton.frame = CGRectMake(15.0f, 12.0f, 40.0f, 40.0f);
        [addImageButton setImage:[UIImage imageNamed:@"add_image"] forState:UIControlStateNormal];
        [addImageButton addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addImageButton];
    }
    return self;
}

- (void)reloadView
{
    void (^layoutBlock)(void);
    if (imageArray.count == 0) {
        layoutBlock = ^{
            control1.hidden = YES;
            addImageButton.frame = CGRectMake(15.0f, 12.0f, 40.0f, 40.0f);
        };
    } else if (imageArray.count == 1) {
        layoutBlock = ^{
            if (!control1) {
                control1 = [[UploadImageControl alloc] initWithFrame:CGRectMake(15.0f, 2.0f, 50.0f, 50.0f)];
                control1.tag = 1;
                [control1 addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:control1];
            }
            control1.hidden = NO;
            control2.hidden = YES;
            [self loadImage];
            addImageButton.frame = CGRectMake(70.0f, 12.0f, 40.0f, 40.0f);
        };
    } else if (imageArray.count == 2) {
        layoutBlock = ^{
            if (!control2) {
                control2 = [[UploadImageControl alloc] initWithFrame:CGRectMake(70.0f, 2.0f, 50.0f, 50.0f)];
                control2.tag = 2;
                [control2 addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:control2];
            }
            control2.hidden = NO;
            control3.hidden = YES;
            [self loadImage];
            addImageButton.frame = CGRectMake(125.0f, 12.0f, 40.0f, 40.0f);
        };
    } else if (imageArray.count == 3) {
        layoutBlock = ^{
            if (!control3) {
                control3 = [[UploadImageControl alloc] initWithFrame:CGRectMake(125.0f, 2.0f, 50.0f, 50.0f)];
                control3.tag = 3;
                [control3 addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:control3];
            }
            control3.hidden = NO;
            control4.hidden = YES;
            [self loadImage];
            addImageButton.frame = CGRectMake(180.0f, 12.0f, 40.0f, 40.0f);
        };
    } else if (imageArray.count == 4) {
        layoutBlock = ^{
            if (!control4) {
                control4 = [[UploadImageControl alloc] initWithFrame:CGRectMake(180.0f, 2.0f, 50.0f, 50.0f)];
                control4.tag = 4;
                [control4 addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:control4];
            }
            control4.hidden = NO;
            control5.hidden = YES;
            [self loadImage];
            addImageButton.hidden = NO;
            addImageButton.frame = CGRectMake(235.0f, 12.0f, 40.0f, 40.0f);
        };
    } else if (imageArray.count == 5) {
        layoutBlock = ^{
            if (!control5) {
                control5 = [[UploadImageControl alloc] initWithFrame:CGRectMake(235.0f, 2.0f, 50.0f, 50.0f)];
                control5.tag = 5;
                [control5 addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:control5];
            }
            control5.hidden = NO;
            control6.hidden = YES;
            [self loadImage];
            addImageButton.hidden = NO;
            addImageButton.frame = CGRectMake(15.0f, 64.0f, 40.0f, 40.0f);

        };
    }else if (imageArray.count == 6) {
        layoutBlock = ^{
            if (!control6) {
                control6 = [[UploadImageControl alloc] initWithFrame:CGRectMake(15.0f, 66.0f, 50.0f, 50.0f)];
                control6.tag = 6;
                [control6 addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:control6];
            }
            control6.hidden = NO;
            [self loadImage];
            addImageButton.frame = CGRectMake(70.0f, 64.0f, 40.0f, 40.0f);

            addImageButton.hidden = YES;
        };
    }
    [UIView animateWithDuration:0.3f
                     animations:layoutBlock
                     completion:^(BOOL finished) {
                     }
     ];
}

- (void)addImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择现场照片"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选择", nil];
    [actionSheet showInView:_controller.tabBarController.view];
}

- (void)deleteImage:(int)tag
{
    [imageArray removeObjectAtIndex:tag - 1];
    [_URLArray removeObjectAtIndex:tag - 1];
    UploadImageControl *control = (UploadImageControl *)[self viewWithTag:tag];
    control.image = nil;
    [self reloadView];
}

- (void)checkImage:(UploadImageControl *)sender
{
    UIImage *image = [imageArray objectAtIndex:sender.tag - 1];
    [[CheckImageView sharedInstance] setImage:image];
}

- (void)loadImage
{
    for (int i = 1; i <= imageArray.count; i++) {
        UploadImageControl *control = (UploadImageControl *)[self viewWithTag:i];
        control.image = imageArray[i - 1];
    }
}

#pragma mark UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        [self cameraOrAlbum:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1) {
        [self cameraOrAlbum:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

- (void)cameraOrAlbum:(UIImagePickerControllerSourceType)type
{
    if([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = type;
        imagePickerController.allowsEditing = YES;
        //[imagePickerController.navigationBar setTintColor:[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:244.0f/255 alpha:1.0]];
        [_controller.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate methods
- (void)imagePickerController:(UIImagePickerController *)picker
		didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo
{
    //拍照后将原图保存到图库中
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    //allowsEditing之后的图宽高不大于640或者320
    DJLog(@"************%.f*************%.f",image.size.width,image.size.height);
    UIImage *scaleImage = [ImageUtil imageWithImage:image
                    scaledToSizeWithSameAspectRatio:CGSizeMake(320.0f, 320.0f)
                                    backgroundColor:nil];
    NSData *imageData = UIImageJPEGRepresentation(scaleImage, 0.00001);
    scaleImage = [UIImage imageWithData:imageData];
    [self uploadPicture:scaleImage controller:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadPicture:(UIImage *)image controller:(UIImagePickerController *)picker
{
    [[CommunityIndicator sharedInstance] startLoading];
    NSLog(@"type==%d",_type);
    [[HttpClientManager sharedInstance] uploadPicturesWithType:_type
                                                       picture:image
                                                      complete:^(BOOL success, int result, NSString *URL) {
                                                          [HttpResponseNotification uploadPictureHttpResponse:result];
                                                          if (success && result == RESPONSE_SUCCESS) {
                                                              [imageArray addObject:image];
                                                              [_URLArray addObject:URL];
                                                              [self reloadView];
                                                          }
                                                          [picker dismissViewControllerAnimated:YES completion:nil];
                                                      }
     ];
}

@end
