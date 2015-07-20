//
//  CommunityDbManager.h
//  Community
//
//  Created by SYZ on 13-11-28.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "CommunityInfo.h"
#import "NoticeInfo.h"
#import "ShopInfo.h"
#import "ActivityInfo.h"
#import "YellowPageInfo.h"
#import "PayLogInfo.h"
#import "ParkingInfo.h"
#import "ChinaCityInfo.h"
#import "AdInfo.h"
#import "TaskInfo.h"

@class FMDatabase;

@protocol CommunityDbManagerInitProtocol <NSObject>

@required
//db数据重置后的回调
-(void)dbHasBeenRecoveredFromCurruption;
//db将要被升级
-(void)dbWillBeUpgraded;
//db升级完成，error为0表示成功，非0表示升级失败
-(void)dbUpgradedWithError:(int)error;

@end

@interface CommunityDbManager : NSObject <NSXMLParserDelegate>
{
@private
    __weak id<CommunityDbManagerInitProtocol> initDelegate_;
    __strong FMDatabase* fmdb_;
}

//access the singleton CommunityDbManager instance
+ (CommunityDbManager *)sharedInstance;

- (void)initDbWithDelegate:(id<CommunityDbManagerInitProtocol>)delegate;

//增加用户
- (BOOL)insertOrUpdateUserInfo:(UserInfo *)info;
//增加城市
- (BOOL)insertOrUpdateCity:(HotCity *)info;
//增加社区
- (BOOL)insertOrUpdateCommunity:(Community *)info;
//增加幢
- (BOOL)insertOrUpdateBuilding:(Building *)info;
//增加单元
- (BOOL)insertOrUpdateUnit:(Unit *)info;
//增加房间
- (BOOL)insertOrUpdateRoom:(Room *)info;
//增加用户房间
- (BOOL)insertOrUpdateUserRoom:(UserRoom *)info;
//增加通知
- (BOOL)insertOrUpdateNotice:(NoticeInfo *)info;
//增加财务报告
- (BOOL)insertOrUpdateFinanceReport:(FinanceReportInfo *)info;
//增加工作报告
- (BOOL)insertOrUpdateWorkReport:(WorkReportInfo *)info;
//增加黄页
- (BOOL)insertOrUpdateYellowPage:(YellowPageInfo *)info;
//增加周边优惠
- (BOOL)insertOrUpdateShop:(ShopInfo *)info;
//增加社区活动
- (BOOL)insertOrUpdateActivity:(ActivityInfo *)info;
//增加缴费记录
- (BOOL)insertOrUpdatePayLog:(PayLogInfo *)info;
//增加中国城市记录
- (BOOL)insertOrUpdateChinaCity:(ChinaCityInfo *)info;
//增加广告信息
- (BOOL)insertOrUpdateAd:(AdInfo *)info;
//增加车位信息
- (BOOL)insertOrUpdateParking:(ParkingInfo *)info;
//增加任务信息
- (BOOL)insertOrUpdateTask:(TaskInfo *)info;

//获取用户信息
- (UserInfo *)queryUserInfo:(long long)userId;
//查询是否有城市信息
- (BOOL)queryCity:(long long)cityId;
//查询是否有社区信息
- (BOOL)queryCommunity:(long long)communityId;
//查询是否有幢信息
- (BOOL)queryBuilding:(long long)buildingId;
//查询是否有单元信息
- (BOOL)queryUnit:(long long)unitId;
//查询是否有房间信息
- (BOOL)queryRoom:(long long)roomId;
//查询是否有通知信息
- (BOOL)queryNotice:(long long)noticeId;
//查询是否有财务报告信息
- (BOOL)queryFinanceReport:(long long)reportId;
//查询是否有工作报告信息
- (BOOL)queryWorkReport:(long long)reportId;
//查询是否有黄页信息
- (BOOL)queryYellowPage:(long long)noticeId;
//查询是否有商户信息
- (BOOL)queryShop:(long long)shopId;
//查询是否有社区活动
- (BOOL)queryActivity:(long long)activityId;
//查询是否有缴费记录
- (BOOL)queryPayLog:(long long)payId;
//查询是否有广告记录
- (BOOL)queryAd:(long long)adId;
//查询是否有车位记录
- (BOOL)queryParking:(long long)parkingId;
//查询是否有任务记录
- (BOOL)queryTask:(NSString *)taskId;

//获取城市
- (NSArray *)queryCities;
//获取社区
- (NSArray *)queryCommunitys:(long long)cityId;
//获取社区new
- (NSArray *)queryCommunitysNew:(long long)cityId;
//获取幢
- (NSArray *)queryBuildings:(long long)communityId;
//获取单元
- (NSArray *)queryUnits:(long long)buildingId;
//获取房间
- (NSArray *)queryRooms:(long long)unitId;
//获取用户房间
- (NSArray *)queryUserRooms:(long long)userId;
//获取通知
- (NSArray *)queryNotices:(long long)communityId;
//获取财务报告
- (NSArray *)queryFinanceReports:(long long)communityId;
//获取工作报告
- (NSArray *)queryWorkReports:(long long)communityId;
//获取黄页
- (NSArray *)queryYellowPages:(long long)communityId pageType:(int)pageType;
//获取商户
- (NSArray *)queryShops:(long long)communityId type:(int)type;
//获取社区活动
- (NSArray *)queryActivities:(long long)communityId;
//获取缴费记录
- (NSArray *)queryPayLogs;
//获取广告记录
- (NSArray *)queryAds:(long long)communityId type:(int)type;
//获取车位记录
- (NSArray *)queryParkings:(long long)communityId;
//获取车位记录
- (NSArray *)queryTasks;

//获取社区的电话号码
- (NSString *)queryTelephone:(long long)communityId;
//查询中国城市
- (ChinaCityInfo *)queryChinaCity:(NSString *)cityId;

//获取社区信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryCitiesUpdateTimeMax:(BOOL)max;
- (long long)queryCommunitysUpdateTimeMax:(BOOL)max cityId:(long long)cityId;
- (long long)queryBuildingsUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryUnitsUpdateTimeMax:(BOOL)max buildingId:(long long)buildingId;
- (long long)queryRoomsUpdateTimeMax:(BOOL)max unitId:(long long)unitId;
- (long long)queryUserRoomsUpdateTimeMax:(BOOL)max userId:(long long)userId;
- (long long)queryNoticesUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryFinanceReportsUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryWorkReportsUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryYellowPagesUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryShopsUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryActivitiesUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryPayLogsUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryAdsUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryParkingsUpdateTimeMax:(BOOL)max communityId:(long long)communityId;
- (long long)queryTasksUpdateTimeMax:(BOOL)max;

- (BOOL)deleteNotices:(long long)updateTime;
- (BOOL)deleteFinanceReports:(long long)updateTime;
- (BOOL)deleteWorkReports:(long long)updateTime;
- (BOOL)deleteYellowPages:(long long)updateTime;
- (BOOL)deleteShops:(long long)updateTime;
- (BOOL)deleteActivities:(long long)updateTime;
- (BOOL)deletePayLogs;
- (BOOL)deleteParkingInfos;
- (BOOL)deleteTasks;

//删除用户信息
- (BOOL)deleteUserInfo:(long long)userId;

- (void)parseChinaCity;

@end
