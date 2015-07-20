//
//  CommunityInfo.h
//  Community
//
//  Created by SYZ on 13-12-5.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCity : NSObject

@property long long cityId;
@property long long updateTime;
@property (nonatomic, strong) NSString *name;
@property int type;

@end

@interface Community : NSObject

@property long long communityId;
@property long long cityId;
@property long long updateTime;
@property long long createTime;
@property (nonatomic, strong) NSString *name;
@property int type;
@property double lon;
@property double lat;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *telephone;

@end

@interface Building : NSObject

@property long long buildingId;
@property long long communityId;
@property long long updateTime;
@property (nonatomic, strong) NSString *name;
@property int type;

@end

@interface Unit : NSObject

@property long long unitId;
@property long long buildingId;
@property long long updateTime;
@property (nonatomic, strong) NSString *name;
@property int type;

@end

@interface Room : NSObject

@property long long roomId;
@property long long unitId;
@property long long updateTime;
@property (nonatomic, strong) NSString *shortName;
@property int type;

@end

@interface UserRoom : NSObject

@property long long roomId;
@property (nonatomic, strong) NSString *roomName;
@property long long communityId;
@property (nonatomic, strong) NSString *communityName;
@property long long updateTime;
@property int type;

@end