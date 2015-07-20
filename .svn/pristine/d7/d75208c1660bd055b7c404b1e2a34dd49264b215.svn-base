//
//  UserResponse.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityBaseResponse.h"

@class UserInfo;
@class CommunityInfo;

//获取验证码的请求返回
@interface GetVerifyCodeResponse : CommunityBaseResponse

@end

//用户注册的请求返回
@interface UserRegisterResponse : CommunityBaseResponse

@property long long userId;

@end

//用户登录的请求返回
@interface UserLoginResponse : CommunityBaseResponse

@property (nonatomic, strong) UserInfo *info;

@end

//修改密码的请求返回
@interface ChangePwdResponse : CommunityBaseResponse

@end

//更新profile的请求返回
@interface UpdateProfileResponse : CommunityBaseResponse

@property long long updateTime;
@property (nonatomic, strong) NSString *picture;

@end

//获得profile的请求返回
@interface GetProfileResponse : CommunityBaseResponse

@property (nonatomic, strong) UserInfo *info;

@end

//获得开通城市的请求返回
@interface GetCityResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

//获得小区的请求返回
@interface GetCommunitysResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

//获得幢的请求返回
@interface GetBuildingsResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;;

@end

//获得楼单元的请求返回
@interface GetUnitsResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

//获得房间的请求返回
@interface GetRoomsResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;  

@end

//获得个人房间的请求返回
@interface GetUserRoomsResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

//绑定房间的请求返回
@interface BindRoomResponse : CommunityBaseResponse

@end

//添加房间的请求返回
@interface AddRoomResponse : CommunityBaseResponse

@end

//删除房间的请求返回
@interface DeleteRoomResponse : CommunityBaseResponse

@end

//添加停车位的请求返回
@interface AddUserParkingResponse : CommunityBaseResponse

@end

//删除停车位的请求返回
@interface DeleteUserParkingResponse : CommunityBaseResponse

@end

//获得绑定房间的停车位请求返回
@interface GetBindParkingResponse : CommunityBaseResponse

@property (nonatomic, strong) NSArray *list;

@end

//获得小区信息的请求返回
@interface GetCommunityInfoResponse : CommunityBaseResponse

@property (nonatomic, strong) Community *info;

@end

