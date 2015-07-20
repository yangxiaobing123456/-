//
//  ActivityInfo.h
//  Community
//
//  Created by SYZ on 14-1-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityInfo : NSObject

@property long long activityId;
@property (nonatomic, strong) NSString *strId;
@property long long communityId;
@property long long updateTime;
@property long long createTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *content;
@property int type;
@property (nonatomic, strong) NSString *picture;

@end
