//
//  TaskFlowInfo.h
//  Community
//
//  Created by SYZ on 14-4-25.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityBaseResponse.h"

@interface TaskFlowInfo : NSObject

@property (nonatomic, strong) NSString *taskFlowId;
@property (nonatomic, strong) NSString *complainId;
@property (nonatomic) long long createTime;
@property (nonatomic) long long updateTime;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) int type;
@property (nonatomic, strong) NSString *processorName;
@property (nonatomic, strong) NSString *processorTelephone;
@property (nonatomic, strong) NSString *processorId;

@end
