//
//  ZZFWResponse.h
//  Community
//
//  Created by SYZ on 13-12-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityBaseResponse.h"
#import "ShopInfo.h"
#import "ActivityInfo.h"

@interface GetShopsResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface GetActivitiesResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end
