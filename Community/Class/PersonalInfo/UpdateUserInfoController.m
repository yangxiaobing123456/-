//
//  UpdateUserInfoController.m
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "UpdateUserInfoController.h"
#import "getQuViewController.h"

#define PickerViewHeight    216.0f

@interface UpdateUserInfoController ()

@end

@implementation UpdateUserInfoController
{
}

- (id)init
{
    self = [super init];
    if (self) {
        editProfile = [EditProfileModel new];
        editCommunity = [EditCommunityModel new];
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
    self.title = @"完善房间信息";
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 304.0f, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
 
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, -44.0f, kContentWidth, kContentHeight)];
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
//    
//    avatarControl = [[EllipseImageControl alloc] initWithFrame:CGRectMake(8.0f, 86.0f, 152.0f, 74.0f)];
//    [avatarControl setImage:[AppSetting avatarImage] text:@""];
//    [avatarControl addTarget:self action:@selector(changeAvatar) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:avatarControl];
    
//    EllipseImageControl *userBgControl = [[EllipseImageControl alloc] initWithFrame:CGRectMake(160.0f, 86.0f, 152.0f, 74.0f)];
//    [userBgControl setImage:[UIImage imageNamed:@"default_avatar"] text:@"点击更换背景图片"];
//    [userBgControl addTarget:self action:@selector(changeUserbg) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:userBgControl];
    
//    editProfileView = [[EditProfileView alloc] initWithFrame:CGRectMake(0.0f, 167.0f, kContentWidth, 227.0f)];
//    editProfileView.delegate = self;
//    [scrollView addSubview:editProfileView];
//    editProfileView.editProfile = editProfile;
//    [editProfileView reloadProfileData];
    
//    UILabel *communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(38.0f, 0.0f, 200.0f, 20.0f)];
//    communityLabel.textColor = [UIColor grayColor];
//    communityLabel.backgroundColor = [UIColor clearColor];
//    communityLabel.font = [UIFont systemFontOfSize:16.0f];
//    communityLabel.text = @"小区信息";
//    [scrollView addSubview:communityLabel];
    
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    [imageview setImage:[UIImage imageNamed:@"logo_132.png"]];
    [scrollView addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 260, 60)];
    label.numberOfLines=3;
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.font=[UIFont systemFontOfSize:12];
    [label setTextColor:[UIColor blackColor]];
    [label setText:@"益社区会严格保密用户提交的小区、楼号、房号等信息,请您放心填写.填写真实的楼号和房号能够让您的楼上楼下邻居找到您."];
    [scrollView addSubview:label];
    
    float h=30;
    editCommunityView = [[EditCommunityView alloc] initWithFrame:CGRectMake(0.0f, 30.0f+h, kContentWidth, 206.0f)];
    editCommunityView.delegate = self;
    [scrollView addSubview:editCommunityView];
    editCommunityView.editCommunity = editCommunity;
    [editCommunityView reloadCommunityData];
    for (int i=0; i<6; i++) {
        UIImageView *l=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30+40*i+h, 320, 0.5)];
        l.backgroundColor=[UIColor lightGrayColor];
        [scrollView addSubview:l];
        

        
       

    }
    for (int j=0; j<5; j++) {
        UIImageView *l1=[[UIImageView alloc]initWithFrame:CGRectMake(280, 45+40*j+h, 15, 15)];
        l1.image=[UIImage imageNamed:@"arrow"];
        [scrollView addSubview:l1];
    }
    float buttonW = 100.0f, buttonH = 32.0f;
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(35.0f, 328.0f, buttonW, buttonH);
    [logoutButton setTitle:@"注  销"
                  forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                       forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                            forState:UIControlStateHighlighted];
    [logoutButton addTarget:self
                     action:@selector(logoutAction)
           forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:logoutButton];
    
    CLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 277, 300, 20)];
    [CLabel setTextAlignment:NSTextAlignmentCenter];
    [CLabel setText:@""];
    [CLabel setTextColor:[UIColor grayColor]];
    [scrollView addSubview:CLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(185.0f, 328.0f, buttonW, buttonH);
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
    
    scrollView.contentSize = CGSizeMake(kContentWidth, 400.0f);
    
    pickerView = [[CommunityPickerView alloc] initWithFrame:CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight)];
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, kNavContentHeight, kContentWidth, PickerViewHeight)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *maxDate = [NSDate date];
    datePicker.maximumDate = maxDate;
    datePicker.date = maxDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    if (_hideBackButton) {
        self.navigationItem.hidesBackButton = YES;
        scrollView.contentSize = CGSizeMake(kContentWidth,400.0f);
    } else {
        [self customBackButton:self];
    }
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

- (void)logoutAction
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您确定要注销账户吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

//提交输入的信息
- (void)submitUserInfo
{
    [self addRoom];
//    NSString *name = [editProfileView getProfileName];
//    if (name == nil || [name isEmptyOrBlank]) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请输入姓名"];
//        return;
//    }
//    if ([name characterLength] > 16) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"姓名长度超过限制"];
//        return;
//    }
//    if (editCommunity.room.roomId == 0) {
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先完善物业信息"];
//        return;
//    }
////    以上为各种限制条件
//    
//    [editProfileView hideKeyboard];
//    [self hidePickerWithAnimation:YES];
//    
//    [[CommunityIndicator sharedInstance] startLoading];
//    long long birthday = 0;
//    if (editProfile.birthday != nil) {
//        birthday = (long long)[datePicker.date timeIntervalSince1970] * 1000;
//    }
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                          name, @"name",
//                          [NSString stringWithFormat:@"%d", [editProfile.gender isEqualToString:@"男"] ? 1 : 0], @"gender",
//                          [NSString stringWithFormat:@"%lld", birthday], @"birthday", nil];
//    
//    [self updateProfileWithDict:dict];
}

//更新profile分3步, 第一步提交用户信息, 第二步添加房间, 第三步绑定房间
//更新profile
- (void)updateProfileWithDict:(NSDictionary *)dict
{
    [[HttpClientManager sharedInstance] updateProfileWithDict:dict
                                                        image:avatar
                                                     complete:^(BOOL success, int result) {
                                                         if (success && result == RESPONSE_SUCCESS) {
                                                             [self addRoom];
                                                         } else {
                                                             [HttpResponseNotification updateUserInfoHttpResponse:result];
                                                         }
                                                     }];
}

- (void)addRoom
{
    [[HttpClientManager sharedInstance] addRoomWithDict:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%lld", editCommunity.room.roomId] forKey:@"id"]
                                               complete:^(BOOL success, int result) {
                                                   if (success && result == RESPONSE_SUCCESS) {
                                                       [self bindRoom];
                                                   } else {
                                                       [HttpResponseNotification updateUserInfoHttpResponse:result];
                                                   }
    }];
}

//绑定房间
- (void)bindRoom
{
    [[HttpClientManager sharedInstance] bindRoomWithDict:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%lld", editCommunity.room.roomId] forKey:@"id"]
                                                complete:^(BOOL success, int result) {
                                                    [HttpResponseNotification updateUserInfoHttpResponse:result];
                                                    if (success && result == RESPONSE_SUCCESS) {
                                                        UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
                                                        user.communityId = editCommunity.community.communityId;
                                                        user.communityName = editCommunity.community.name;
                                                        user.roomId = editCommunity.room.roomId;
                                                        user.roomName = [NSString stringWithFormat:@"%@%@%@%@",
                                                                         editCommunity.community.name,
                                                                         editCommunity.building.name,
                                                                         editCommunity.unit.name,
                                                                         editCommunity.room.shortName];
                                                        [[CommunityDbManager sharedInstance] insertOrUpdateUserInfo:user];
                                                        [AppSetting saveCommunityId:editCommunity.community.communityId];
                                                        [self changCommnunityNotificate];
                                                        if ([_delegate performSelector:@selector(popViewController:) withObject:nil]) {
                                                            [_delegate popViewController:self];
                                                        } else {
                                                            CommunityRootController *rootController = [CommunityRootController new];
                                                            //                                                            UpdateUserInfoController *rootController = [UpdateUserInfoController new];
                                                            [self presentViewController:rootController animated:YES completion:nil];
                                                        
                                                        
//                                                            [self.navigationController popViewControllerAnimated:YES];
                                                        }
                                                    }
                                                }];
}

- (void)changCommnunityNotificate
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeCommunity object:nil];
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
    } else if (editButtonTag == BirthdayTag) {
        [self showDatePickerView];
        [scrollView setContentOffset:CGPointMake(0.0f, 100.0f + offset) animated:YES];
    }
}

#pragma mark EditCommunityViewDelegate methods
- (void)changeEditCommunityViewValue:(int)tag
{
    [editProfileView hideKeyboard];
    [self hidePickerWithAnimation:YES];
    
    switch (tag) {
        case ProvinceTag:
            
            break;
            
        case CityTag:
            [self getCities];
            break;
            
        case CommunityTag:
            [self getCommunitys];
            break;
            
        case BuildingTag:
            [self getBuildings];
            break;
            
        case UnitTag:
            [self getUnits];
            break;
            
        case RoomTag:
            [self getRooms];
            break;
            
        default:
            break;
    }
}

#pragma mark CommunityPickerViewDelegate methods
- (void)pickerViewSelected:(id)object row:(int)row
{
    switch (editButtonTag) {
        case GenderTag:
            editProfile.gender = object;
            [editProfileView reloadProfileData];
            break;
        default:
            break;
    }
}
-(void)homedown:(Community *)c{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",c.communityId],@"id", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:findCompany];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
    }
    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    //    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络不给力啊"];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str====%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            [CLabel setText:[dic objectForKey:@"companyName"]];
            
        }
    }
    
}


//获取城市
- (void)getCities
{
    if (!city) {
        city = [HotCity new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.tag = CityTag;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

//获取社区
- (void)getCommunitys
{
    if (city.cityId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先选择城市"];
        [self hidePickerWithAnimation:YES];
        return;
    }
    if (!community) {
        community = [Community new];
    }
//    SelectOptionController *controller = [SelectOptionController new];
//    controller.delegate = self;
//    controller.parentId = city.cityId;
//    controller.tag = CommunityTag;
//    controller.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:controller animated:YES];
    
    getQuViewController *controller = [getQuViewController new];
    controller.delegate = self;
    controller.parentId = city.cityId;
    controller.tag = CommunityTag;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    

}

//获取幢
- (void)getBuildings
{
    if (community.communityId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先选择社区"];
        [self hidePickerWithAnimation:YES];
        return;
    }
    
    if (!building) {
        building = [Building new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.parentId = community.communityId;
    controller.tag = BuildingTag;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

//获取单元
- (void)getUnits
{
    if (building.buildingId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先选择幢"];
        [self hidePickerWithAnimation:YES];
        return;
    }
    
    if (!unit) {
        unit = [Unit new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.parentId = building.buildingId;
    controller.tag = UnitTag;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

//获取房间
- (void)getRooms
{
    if (unit.unitId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先选择单元"];
        [self hidePickerWithAnimation:YES];
        return;
    }
    
    if (!room) {
        room = [Room new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.parentId = unit.unitId;
    controller.tag = RoomTag;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark SelectOptionControllerDelegate methods
- (void)selectCity:(HotCity *)c
{
    if (city.cityId != c.cityId) {
        city.cityId = 0;
        [self cleanSelected];
        city = c;
        editCommunity.city = city;
        [editCommunityView reloadCommunityData];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectCommunity:(Community *)c
{
    if (community.communityId != c.communityId) {
        community.communityId = 0;
        [self cleanSelected];
        community = c;
        editCommunity.community = community;
        [editCommunityView reloadCommunityData];
    }
    [self homedown:c];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectBuilding:(Building *)b
{
    if (building.buildingId != b.buildingId) {
        building.buildingId = 0;
        [self cleanSelected];
        building = b;
        editCommunity.building = building;
        [editCommunityView reloadCommunityData];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectUnit:(Unit *)u
{
    if (unit.unitId != u.unitId) {
        unit.unitId = 0;
        [self cleanSelected];
        unit = u;
        editCommunity.unit = unit;
        [editCommunityView reloadCommunityData];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectRoom:(Room *)r
{
    if (room.roomId != r.roomId) {
        room.roomId = 0;
        [self cleanSelected];
        room = r;
        editCommunity.room = room;
        [editCommunityView reloadCommunityData];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//父option改变后,清空子option
- (void)cleanSelected
{
    if (city.cityId == 0) {
        community.communityId = 0;
    }
    if (community.communityId == 0) {
        building.buildingId = 0;
    }
    if (building.buildingId == 0) {
        unit.unitId = 0;
    }
    if (unit.unitId == 0) {
        room.roomId = 0;
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

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [AppSetting userLogout];
        //进入这个页面的两种情况,注销后使用不同的情况退出
        if (_hideBackButton) {
            self.tabBarController.selectedIndex = 2;
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLogout object:nil];
    }
}

@end
