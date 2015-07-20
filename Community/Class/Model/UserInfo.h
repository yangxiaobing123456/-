//
//  UserInfo.h
//  Community
//
//  Created by SYZ on 13-11-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property long long userId;
@property int gender;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *nickName;
@property long long createTime;
@property long long birthday;
@property long long updateTime;
@property (nonatomic, strong) NSString *picture;
@property long long communityId;
@property (nonatomic, strong) NSString *communityName;
@property long long roomId;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *telephone;
@property double roomDiscount;
@property double parkingDiscount;
@property int isFee;



//本地属性
@property (nonatomic, strong) NSString *password;

@end
