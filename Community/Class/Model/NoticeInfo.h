//
//  NoticeInfo.h
//  Community
//
//  Created by SYZ on 13-11-29.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeInfo : NSObject

@property long long noticeId;
@property long long communityId;
@property long long updateTime;
@property long long createTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *content;
@property int noticeType;
@property int type;
@property (nonatomic, strong) NSString *picture;

@end

@interface FinanceReportInfo : NSObject

@property long long reportId;
@property (nonatomic, strong) NSString *strId;
@property long long communityId;
@property (nonatomic, strong) NSString *title;
@property long long updateTime;
@property long long createTime;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *outcome;
@property (nonatomic, strong) NSString *publishTime;
@property int type;

@property (nonatomic, strong) NSArray *incomeArray;
@property (nonatomic, strong) NSArray *outcomeArray;

@end

@interface WorkReportInfo : NSObject

@property long long reportId;
@property long long communityId;
@property long long updateTime;
@property long long createTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *html;
@property int type;

@end