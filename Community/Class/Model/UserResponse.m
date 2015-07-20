//
//  UserResponse.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "UserResponse.h"

@implementation GetVerifyCodeResponse

@end

@implementation UserRegisterResponse

@synthesize userId = __KEY_NAME_id;

@end

@implementation UserLoginResponse

@end

@implementation ChangePwdResponse

@end

@implementation UpdateProfileResponse

@end

@implementation GetProfileResponse

@end

@implementation GetCityResponse

@synthesize list = __ELE_TYPE_HotCity;

@end

@implementation GetCommunitysResponse

@synthesize list = __ELE_TYPE_Community;

@end

@implementation GetBuildingsResponse

@synthesize list = __ELE_TYPE_Building;

@end

@implementation GetUnitsResponse

@synthesize list = __ELE_TYPE_Unit;

@end

@implementation GetRoomsResponse

@synthesize list = __ELE_TYPE_Room;

@end

@implementation GetUserRoomsResponse

@synthesize list = __ELE_TYPE_UserRoom;

@end

@implementation BindRoomResponse

@end

@implementation AddRoomResponse

@end

@implementation DeleteRoomResponse

@end

@implementation AddUserParkingResponse

@end

@implementation DeleteUserParkingResponse

@end

@implementation GetBindParkingResponse

@synthesize list = __ELE_TYPE_ParkingInfo;

@end

@implementation GetCommunityInfoResponse

@end
