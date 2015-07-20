//
//  UpdateProfileController.m
//  Community
//
//  Created by SYZ on 13-11-20.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "UpdateProfileController.h"

#define PickerViewHeight    216.0f
@interface UpdateProfileController ()

@end

@implementation UpdateProfileController

- (id)init
{
    self = [super init];
    if (self) {
        editProfile = [EditProfileModel new];
        if (iPhone5) {
            offset = 0.0f;
        } else {
            offset = 88.0f;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"修改个人信息";
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 304.0f, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, -124.0f, kContentWidth, kContentHeight+80)];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.contentInset = UIEdgeInsetsMake(44.0f, 0.0f, 0.0f, 0.0f);
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    
//    userBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, 10.0f, 304.0f, 66.0f)];
//    userBackgroundView.image = [UIImage imageNamed:@"bg2"];
//    [scrollView addSubview:userBackgroundView];
    UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 111.0f, 120.0f, 20.0f)];
    imageLabel.textColor = [UIColor grayColor];
    imageLabel.backgroundColor = [UIColor clearColor];
    imageLabel.font = [UIFont systemFontOfSize:16.0f];
    imageLabel.text = @"头像";
    [scrollView addSubview:imageLabel];
//    for (int i=0; i<4; i++) {
//        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 156+50*i, 320, 0.5)];
//        [scrollView addSubview:line];
//        line.backgroundColor=[UIColor grayColor];
//    }
    
    avatarControl = [[EllipseImageControl alloc] initWithFrame:CGRectMake(200.0f, 86.0f, 102.0f, 74.0f)];
    [avatarControl setImage:[AppSetting avatarImage] text:@""];
    [avatarControl addTarget:self action:@selector(changeAvatar) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:avatarControl];
    
//    EllipseImageControl *userBgControl = [[EllipseImageControl alloc] initWithFrame:CGRectMake(160.0f, 86.0f, 152.0f, 74.0f)];
//    [userBgControl setImage:[UIImage imageNamed:@"default_avatar"] text:@"点击更换背景图片"];
//    [userBgControl addTarget:self action:@selector(changeUserbg) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:userBgControl];
    
    editProfileView = [[EditProfileView alloc] initWithFrame:CGRectMake(0.0f, 167.0f, kContentWidth, 227.0f)];
    editProfileView.delegate = self;
    editProfileView.nameField.delegate = self;
    editProfileView.nameField.tag=100;
    [scrollView addSubview:editProfileView];
    editProfileView.editProfile = editProfile;
    
    float buttonW = 100.0f, buttonH = 32.0f;
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake((kContentWidth - buttonW) / 2, 330.0f, buttonW, buttonH);
    [confirmButton setTitle:@"确  定"
                   forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                        forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                             forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                             forState:UIControlStateHighlighted];
    [confirmButton addTarget:self
                      action:@selector(submitUserInfo)
            forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:confirmButton];
    
    scrollView.contentSize = CGSizeMake(kContentWidth, 460.0f);
    
    pickerView = [[CommunityPickerView alloc] initWithFrame:CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight)];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *maxDate = [NSDate date];
    datePicker.maximumDate = maxDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    [self customBackButton:self];
    
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    UserInfo *info = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:info.birthday / 1000];
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [df stringFromDate:date];
    
    datePicker.date = date;
    editProfile.name = info.userName;
    editProfile.gender = info.gender == 1 ? @"男" : @"女";
    editProfile.birthday = dateString;
    [editProfileView reloadProfileData];
}

//修改头像
- (void)changeAvatar
{
    [editProfileView hideKeyboard];
    [self hidePickerWithAnimation:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择现场照片"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选择", nil];
    [actionSheet showInView:self.tabBarController.view];
}

//修改背景
- (void)changeUserbg
{
    [editProfileView hideKeyboard];
    [self hidePickerWithAnimation:YES];
}

//提交输入的信息
- (void)submitUserInfo
{
    NSString *name = [editProfileView getProfileName];
    if (name == nil || [name isEmptyOrBlank]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入昵称"];
        return;
    }
    if ([name characterLength] > 5) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"姓名长度超过限制"];
        return;
    }
    //以上为各种限制条件
    
    [editProfileView hideKeyboard];
    [self hidePickerWithAnimation:YES];
    
    [[CommunityIndicator sharedInstance] startLoading];
    long long birthday = 0;
    if (editProfile.birthday != nil) {
        birthday = (long long)[datePicker.date timeIntervalSince1970] * 1000;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          name, @"name",
                          [NSString stringWithFormat:@"%d", [editProfile.gender isEqualToString:@"男"] ? 1 : 0], @"gender",
                          [NSString stringWithFormat:@"%lld", birthday], @"birthday", nil];
    NSDictionary *noticeDict=[NSDictionary dictionaryWithObjectsAndKeys:
                              name, @"name",
                              editProfile.gender, @"gender",
                              editProfile.birthday, @"birthday", nil];
    NSNotification *notice=[NSNotification notificationWithName:@"profileName" object:nil userInfo:noticeDict];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    [self updateProfileWithDict:dict];
}

//更新profile
- (void)updateProfileWithDict:(NSDictionary *)dict
{
    [[HttpClientManager sharedInstance] updateProfileWithDict:dict
                                                        image:avatar
                                                     complete:^(BOOL success, int result) {
                                                         [HttpResponseNotification updateUserInfoHttpResponse:result];
                                                         if (success && result == RESPONSE_SUCCESS) {
                                                             [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"个人信息更新成功"];
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                             if (avatar) {
                                                                 [AppSetting downloadAvatar];
                                                             }
                                                             
                                                             
                                                         } else {
                                                             [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"更新失败,请重试"];
                                                         }
                                                     }];
}

//显示pickerview
- (void)showPickerView
{
    if (pickerView.frame.origin.y == kNavContentHeight - PickerViewHeight) {
        return;
    }
    
    if (datePicker.frame.origin.y == kNavContentHeight - PickerViewHeight) {
        datePicker.frame = CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight);
    }
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         pickerView.frame = CGRectMake(0.0f, kNavContentHeight - PickerViewHeight, kContentWidth, PickerViewHeight);
                         scrollView.frame = CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight - PickerViewHeight);
                     }
                     completion:nil];
}

//显示datepickerview
- (void)showDatePickerView
{
    if (datePicker.frame.origin.y == kNavContentHeight - PickerViewHeight) {
        return;
    }
    
    if (pickerView.frame.origin.y == kNavContentHeight - PickerViewHeight) {
        pickerView.frame = CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight);
    }
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         datePicker.frame = CGRectMake(0.0f, kNavContentHeight - PickerViewHeight, kContentWidth, PickerViewHeight);
                         scrollView.frame = CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight - PickerViewHeight);
                     }
                     completion:nil];
}

//隐藏datepickerview
- (void)hidePickerWithAnimation:(BOOL)animate
{
    void (^layout)(void) = ^{
        pickerView.frame = CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight);
        datePicker.frame = CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight);
        scrollView.frame = CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight);
    };
    if (animate) {
        [UIView animateWithDuration:0.3f
                         animations:^{
                             layout();
                         }
                         completion:nil];
    } else {
        layout();
    }
}
#pragma mark--- textFieldDelegate    效果不好 需要优化
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{

    if(textField.tag==100){
        if(range.location >4){
            return NO;
        }
    }
    return YES;
}
#pragma mark datePicker value change methods
- (void)datePickerValueChanged:(id)sender
{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [df stringFromDate:datePicker.date];
    editProfile.birthday = dateString;
    [editProfileView reloadProfileData];
}

#pragma mark Observer methods
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self hidePickerWithAnimation:NO];
    
    CGRect keyboardFrame;
    [[[((NSNotification *)notification) userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    float keyboardHeight = CGRectGetHeight(keyboardFrame);
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         scrollView.frame = CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight - keyboardHeight);
                         [scrollView setContentOffset:CGPointMake(0.0f, offset) animated:YES];
                     }
                     completion:nil
     ];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         scrollView.frame = CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight);
                     }
                     completion:nil
     ];
}

#pragma mark EditProfileViewDelegate methods
- (void)changeEditProfileViewValue:(int)tag
{
    editButtonTag = tag;
    
    editProfile.name = [editProfileView getProfileName];
    [editProfileView hideKeyboard];
    pickerView.pickerArray = nil;
    
    if (editButtonTag == GenderTag) {
        pickerView.pickerArray = [NSArray arrayWithObjects:@"男", @"女", nil];
        [scrollView setContentOffset:CGPointMake(0.0f, 50.0f + offset) animated:YES];
        [self showPickerView];
        [pickerView pickerViewdidSelectRow:[editProfile.gender isEqualToString:@"男"] ? 0 : 1];
    } else if (tag == BirthdayTag) {
        [self showDatePickerView];
        [scrollView setContentOffset:CGPointMake(0.0f, 100.0f + offset) animated:YES];
    }
}

#pragma mark CommunityPickerViewDelegate methods
- (void)pickerViewSelected:(id)object row:(int)row
{
    if (editButtonTag == GenderTag) {
        editProfile.gender = object;
        [editProfileView reloadProfileData];
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
        [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
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
    avatar = [ImageUtil imageWithImage:image
       scaledToSizeWithSameAspectRatio:CGSizeMake(320.0f, 320.0f)
                       backgroundColor:nil];
    
    NSData *imageData = UIImageJPEGRepresentation(avatar, 0.00001);
    avatar = [UIImage imageWithData:imageData];
	[picker dismissViewControllerAnimated:YES completion:nil];
    
    [avatarControl setImage:avatar text:@"点击更换头像图片"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}

@end
