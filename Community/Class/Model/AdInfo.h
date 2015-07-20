//
//  AdInfo.h
//  Community
//
//  Created by SYZ on 14-3-6.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdInfo : NSObject

@property long long adId;
@property long long cityId;
@property long long communityId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *picture;
@property int type;
@property long long updateTime;

@end