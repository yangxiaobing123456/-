//
//  UpdateCommunityController.m
//  Community
//
//  Created by SYZ on 13-12-12.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "UpdateCommunityController.h"
#import "getQuViewController.h"

@interface UpdateCommunityController ()

@end

@implementation UpdateCommunityController

- (id)init
{
    self = [super init];
    if (self) {
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
	
    self.title = @"添加小区";
    
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
    
    userBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, 10.0f, 304.0f, 66.0f)];
    userBackgroundView.image = [UIImage imageNamed:@"bg2"];
    [scrollView addSubview:userBackgroundView];
    
    editCommunityView = [[EditCommunityView alloc] initWithFrame:CGRectMake(0.0f, 86.0f, kContentWidth, 206.0f)];
    editCommunityView.delegate = self;
    [scrollView addSubview:editCommunityView];
    editCommunityView.editCommunity = editCommunity;
    [editCommunityView reloadCommunityData];
    
    for (int i=0; i<5; i++) {
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 126+40*i, 320, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [scrollView addSubview:line];
        
        UIImageView *l1=[[UIImageView alloc]initWithFrame:CGRectMake(280, 98+40*i, 20, 20)];
        l1.image=[UIImage imageNamed:@"arrow"];
        [scrollView addSubview:l1];
    }
    label=[[UILabel alloc]initWithFrame:CGRectMake(10, 307, 300, 20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@""];
    [label setTextColor:[UIColor grayColor]];
    [scrollView addSubview:label];

    
    float buttonW = 100.0f, buttonH = 32.0f;
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmButton.layer.cornerRadius = 5;
    confirmButton.frame = CGRectMake((kContentWidth - buttonW) / 2 + 10, 337.0f, buttonW-20, buttonH);
    [confirmButton setTitle:@"确  定"
                   forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                        forState:UIControlStateNormal];
//    [confirmButton setBackgroundImage:[UIImage imageNamed:@"button_normal_200W"]
//                             forState:UIControlStateNormal];
//    [confirmButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
//                             forState:UIControlStateHighlighted];
    [confirmButton addTarget:self
                      action:@selector(submitCommunity)
            forControlEvents:UIControlEventTouchUpInside];
    confirmButton.backgroundColor = RGBA(255, 165, 0, 0.9);
    [scrollView addSubview:confirmButton];
    
    scrollView.contentSize = CGSizeMake(kContentWidth, 370.0f);
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提交输入的信息
- (void)submitCommunity
{
    if (editCommunity.room.roomId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先完善物业信息"];
        return;
    }
    //以上为各种限制条件
    [[HttpClientManager sharedInstance] addRoomWithDict:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%lld", editCommunity.room.roomId] forKey:@"id"]
                                               complete:^(BOOL success, int result) {
                                                   if (success && result == RESPONSE_SUCCESS) {
                                                       [self.navigationController popViewControllerAnimated:YES];
                                                   } else {
                                                       [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络错误,请重试"];
                                                   }
                                               }];
}

#pragma mark EditCommunityViewDelegate methods
- (void)changeEditCommunityViewValue:(int)tag
{
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

//获取城市
- (void)getCities
{
    if (!city) {
        city = [HotCity new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.tag = CityTag;
    [self.navigationController pushViewController:controller animated:YES];
}

//获取社区
- (void)getCommunitys
{
    if (city.cityId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先选择城市"];
        return;
    }

    if (!community) {
        community = [Community new];
    }
//    SelectOptionController *controller = [SelectOptionController new];
//    controller.delegate = self;
//    controller.parentId = city.cityId;
//    controller.tag = CommunityTag;
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
        return;
    }
    
    if (!building) {
        building = [Building new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.parentId = community.communityId;
    controller.tag = BuildingTag;
    [self.navigationController pushViewController:controller animated:YES];
}

//获取单元
- (void)getUnits
{
    if (building.buildingId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先选择幢"];
        return;
    }
    
    if (!unit) {
        unit = [Unit new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.parentId = building.buildingId;
    controller.tag = UnitTag;
    [self.navigationController pushViewController:controller animated:YES];
}

//获取房间
- (void)getRooms
{
    if (unit.unitId == 0) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请先选择单元"];
        return;
    }
    
    if (!room) {
        room = [Room new];
    }
    SelectOptionController *controller = [SelectOptionController new];
    controller.delegate = self;
    controller.parentId = unit.unitId;
    controller.tag = RoomTag;
    [self.navigationController pushViewController:controller animated:YES];
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
            [label setText:[dic objectForKey:@"companyName"]];
            
        }
    }
    
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

@end
