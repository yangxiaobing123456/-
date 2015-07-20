//
//  WYFWResponse.h
//  Community
//
//  Created by SYZ on 13-11-29.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityBaseResponse.h"
#import "NoticeInfo.h"
#import "YellowPageInfo.h"
#import "RoomInfo.h"
#import "PayLogInfo.h"
#import "ParkingInfo.h"

//投诉报修的请求返回
@interface ComplainAndRepairResponse : CommunityBaseResponse

@property long long complainAndRepairId;
@property long long updateTime;
@property (nonatomic, strong) NSString *no;
@property (nonatomic, strong) NSString *picture;

@end

@interface GetNoticesResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface GetFinanceReportResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface GetWorkReportResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface GetYellowPagesResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface GetRoomInfoResponse : CommunityBaseResponse

@property (nonatomic, strong) RoomInfo *info;

@end

@interface GetParkingInfoResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface GetUserParkingInfoResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface GetOrderNumberResponse : CommunityBaseResponse

@property long long no;
@property (nonatomic, strong) NSString *tradeNumber;

@end

@interface GetPayResultResponse : CommunityBaseResponse

@end

@interface GetPayLogsResponse : CommunityBaseResponse

@property int all;
@property (nonatomic, strong) NSArray *list;

@end

@interface UploadPicturesResponse : CommunityBaseResponse

@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *thumbnail;

@end