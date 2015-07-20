//
//  EditCommunityView.m
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "EditCommunityView.h"

@implementation EditCommunityModel

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

@end

@implementation SelectControl

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:backgroundView];
        
        content = [[UILabel alloc] initWithFrame:CGRectMake(13.0f, 7.0f, self.frame.size.width - 40.0f, 30.0f)];
        content.textColor = [UIColor colorWithHexValue:0xFF767477];
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:content];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    backgroundView.image = image;
}

- (void)setContent:(NSString *)text
{
    content.text = text;
}

@end

@implementation EditCommunityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTime:) name:@"refreshDanYuan" object:nil];
        
        float viewWidth = self.frame.size.width;
        float buttonW_1 = 257.0f, buttonW_2 = 122.0f, buttonH = 54.0f;
        float buttonX_1 = (viewWidth - buttonW_1) / 2, buttonX_2 = buttonX_1 + buttonW_2 + 13.0f;
        
        
        
        cityControl = [[SelectControl alloc] initWithFrame:CGRectMake(5, 0.0f, 310, buttonH)];
        cityControl.tag = CityTag;
//        [cityControl setImage:[UIImage imageNamed:@"select_button_244W"]];
        [cityControl addTarget:self
                        action:@selector(controlClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cityControl];
        
        communityControl = [[SelectControl alloc] initWithFrame:CGRectMake(5, 44.0f, 310, buttonH)];
        communityControl.tag = CommunityTag;
//        [communityControl setImage:[UIImage imageNamed:@"select_button_524W"]];
        [communityControl addTarget:self
                             action:@selector(controlClick:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:communityControl];
        
        buildingControl = [[SelectControl alloc] initWithFrame:CGRectMake(5, 84.0f, 310, buttonH)];
        buildingControl.tag = BuildingTag;
//        [buildingControl setImage:[UIImage imageNamed:@"select_button_244W"]];
        [buildingControl addTarget:self
                            action:@selector(controlClick:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buildingControl];
        
        unitControl = [[SelectControl alloc] initWithFrame:CGRectMake(5, 124.0f, 310, buttonH)];
        unitControl.tag = UnitTag;
//        [unitControl setImage:[UIImage imageNamed:@"select_button_244W"]];
        [unitControl addTarget:self
                        action:@selector(controlClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:unitControl];
        
        roomControl = [[SelectControl alloc] initWithFrame:CGRectMake(5, 124+44.0f, 310, buttonH)];
        roomControl.tag = RoomTag;
//        [roomControl setImage:[UIImage imageNamed:@"select_button_244W"]];
        [roomControl addTarget:self
                        action:@selector(controlClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:roomControl];
        
        communityLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 124+44.0f+44, 310, buttonH)];
        [self addSubview:communityLabel];
        
//        [self homedown];
    }
    return self;
}
-(void)changeTime:(NSNotification *)notice{
    NSLog(@"OK------");
    NSDictionary *dic=[notice userInfo];
    if (!dic||dic==nil) {
        return;
    }
//    [communityControl setContent:[dic objectForKey:@"name"]];
//    [communityControl setTag:[[dic objectForKey:@"id"] intValue]];
    
    
    
}
-(void)homedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting communityId]],@"communityId", nil];
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
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
           
        }
    }
    
}

- (void)controlClick:(UIControl *)sender
{
    [_delegate changeEditCommunityViewValue:sender.tag];
}

- (void)reloadCommunityData
{
    if (_editCommunity.city.cityId == 0) {
        [cityControl setContent:@"城市"];
    } else {
        [cityControl setContent:_editCommunity.city.name];
    }
    if (_editCommunity.community.communityId == 0) {
        [communityControl setContent:@"小区"];
    } else {
        [communityControl setContent:_editCommunity.community.name];
    }
    if (_editCommunity.building.buildingId == 0) {
        [buildingControl setContent:@"幢"];
    } else {
        [buildingControl setContent:_editCommunity.building.name];
    }
    if (_editCommunity.unit.unitId == 0) {
        [unitControl setContent:@"单元"];
    } else {
        [unitControl setContent:_editCommunity.unit.name];
    }
    if (_editCommunity.room.roomId == 0) {
        [roomControl setContent:@"房号"];
    } else {
        [roomControl setContent:_editCommunity.room.shortName];
    }
}

@end
