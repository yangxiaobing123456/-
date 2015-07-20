//
//  TaskInfo.h
//  Community
//
//  Created by SYZ on 14-4-18.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TYPE_NEW               1
#define TYPE_ASSIGNED          2
#define TYPE_PREPROCESS        3
#define TYPE_PROCESSING        4
#define TYPE_PROCESSED         5
#define TYPE_VISITED           6
#define TYPE_VISITED2          7
#define TYPE_FINISHED          8

#define TASK_COMPLAIN          1
#define TASK_REPAIR            2
#define TASK_PROCESS           1
#define TASK_SUPERVISE         2

@interface TaskInfo : NSObject

@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *communityId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic) long long createTime;
@property (nonatomic) long long updateTime;
@property (nonatomic) long long asignTime;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) int complainRepairType;                   //个人报修或者公关报修
@property (nonatomic) int type;                                 //type有8种情况
@property (nonatomic, strong) NSString *processorName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userTelephone;
@property (nonatomic, strong) NSString *processorTelephone;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSString *processorId;
@property (nonatomic) int star;
@property (nonatomic, strong) NSString *communityName;
@property (nonatomic) int needMaterial;
@property (nonatomic) int level;
@property (nonatomic, strong) NSString *roomFullName;
@property (nonatomic) int isComplain;                           //1表示投诉; 2表示报修

@property (nonatomic) int processOrSupervise;                   //本地属性: 1表示处理的任务; 2表示监督的任务
@property (nonatomic) int isRead;                               //本地属性: 0表示未读; 1表示已读;

@end
