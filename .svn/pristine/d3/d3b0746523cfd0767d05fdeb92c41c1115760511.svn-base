//
//  HttpClientManager.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EzJsonParser.h"
#import "NSData+Base64.h"
#import "GTMHTTPFetcher.h"
#import "GTMMIMEDocument.h"
#import "HttpRequestGenerator.h"
#import "UserInfo.h"
#import "RoomInfo.h"
#import "CommunityInfo.h"
#import "UserResponse.h"
#import "WYFWResponse.h"
#import "ZZFWResponse.h"
#import "WeatherResponse.h"
#import "HomeRecommendResponse.h"
#import "CheckUpdateResponse.h"
#import "TSBXHistoryResponse.h"
#import "GetTaskFlowResponse.h"

#define RESPONSE_SUCCESS                   1
#define RESPONSE_BAD_REQUEST               0
#define RESPONSE_SERVER_QUERY_ERROR       -1
#define RESPONSE_ALREADY_EXIST            -2
#define RESPONSE_VERIFY_ERROR             -3
#define RESPONSE_TIMEOUT                  -4
#define RESPONSE_FORMAT_ERROR             -5
#define RESPONSE_WRONG_PASSWORD_OR_NAME   -6
#define RESPONSE_FILE_TRANSFER_ERROR      -7
#define RESPONSE_NOT_VERIFY               -8
#define RESPONSE_ALREADY_DONE             -9
#define RESPONSE_NOT_EXIST                -10
#define RESPONSE_FILE_SIZE_ERROR          -11
#define RESPONSE_TOO_MUCH                 -12
#define RESPONSE_PERMISSION_DENIED        -13
#define RESPONSE_FORCE_UPDATE             -14

#define RESPONSE_ERROR                    -100

@interface HttpClientManager : NSObject

+ (HttpClientManager *)sharedInstance;

//http认证
- (NSString *)authorizationHttpHeaderString;

//获取首页的推荐广告和最新通知
- (void)getHomeRecommendWithDict:(NSDictionary *)dict
                        complete:(void(^)(BOOL, int, NoticeInfo *))handler;

//-----------------------------------用户----------------------------------------
//检查更新
- (void)checkUpdateWithDict:(NSDictionary *)dict complete:(void(^)(BOOL, CheckUpdateResponse *))handler;
- (void)getnewHomeRecommendWithDict:(NSDictionary *)dict
                           complete:(void(^)(BOOL, int, NoticeInfo *))handler;
//注册时获取手机验证码
- (void)getVerifyCodeWithPhoneNumber:(NSString *)phone
                            complete:(void(^)(BOOL, int))handler;
//支付密码修改手机验证码
- (void)getZFVerifyCodeWithPhoneNumber:(NSString *)phone complete:(void (^)(BOOL, int))handler;
//获取团购列表
- (void)getTuanGouWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL, int, NSArray *))handler;
//用户注册
- (void)userRegisterWithDict:(NSDictionary *)dict
                    complete:(void(^)(BOOL, int, long long))handler;

//用户登录
- (void)userLoginWithDict:(NSDictionary *)dict
                 complete:(void(^)(BOOL, int, UserInfo *))handler;
- (void)YYrepairWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler;

//更新profile
- (void)updateProfileWithDict:(NSDictionary *)dict
                        image:(UIImage *)picture
                     complete:(void(^)(BOOL, int))handler;

//获取profile
- (void)getProfileWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL, int))handler;

//找回密码时获取手机验证码
- (void)forgetPasswordWithPhoneNumber:(NSString *)phone
                             complete:(void(^)(BOOL, int))handler;

//找回密码
- (void)changeForgetPasswordWithDict:(NSDictionary *)dict
                            complete:(void(^)(BOOL, int))handler;

//修改密码
- (void)changePasswordWithDict:(NSDictionary *)dict
                      complete:(void(^)(BOOL, int))handler;

//获得开通城市列表
- (void)getCitiesWithDict:(NSDictionary *)dict
                 complete:(void(^)(BOOL, int))handler;

//获得小区列表
- (void)getCommunitysWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL, int))handler;

//获得幢列表
- (void)getBuildingsWithDict:(NSDictionary *)dict
                    complete:(void(^)(BOOL, int))handler;

//获得单元列表
- (void)getUnitsWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, int))handler;

//获得房间列表
- (void)getRoomsWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, int))handler;

//获得用户房间列表
- (void)getUserRoomsWithDict:(NSDictionary *)dict
                    complete:(void(^)(BOOL, int, NSArray *))handler;

//绑定房间
- (void)bindRoomWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, int))handler;

//添加房间
- (void)addRoomWithDict:(NSDictionary *)dict
               complete:(void(^)(BOOL, int))handler;

//删除房间
- (void)deleteRoomWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL, int))handler;

//获得小区信息
- (void)getCommunityInfoWithCommunityId:(long long)communityId
                               complete:(void(^)(BOOL))handler;

//意见反馈
- (void)submitSuggestWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL))handler;

//-----------------------------------物业----------------------------------------
//投诉
- (void)complainWithDict:(NSDictionary *)dict
                   image:(UIImage *)picture
                complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler;

//报修
- (void)repairWithDict:(NSDictionary *)dict
                 image:(UIImage *)picture
              complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler;
//多图分享 毛毛
- (void)shareWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler;


//多图投诉
- (void)complainWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler;

//多图报修
- (void)repairWithDict:(NSDictionary *)dict
              complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler;

//投诉报修历史记录
- (void)tsbxHistoryWithDict:(NSDictionary *)dict
                   complete:(void(^)(int result))handler;

//任务详细流程
- (void)getTaskFlowWith:(NSDictionary *)dict
               complete:(void(^)(int result, NSArray *array))handler;

//任务评价
- (void)commentTaskWith:(NSDictionary *)dict
               complete:(void(^)(int result))handler;

//获取通知
- (void)getNoticesWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL, GetNoticesResponse *))handler;

//获取财务报告
- (void)getFinanceReportWithDict:(NSDictionary *)dict
                        complete:(void(^)(BOOL, GetFinanceReportResponse *))handler;

//获取工作报告
- (void)getWorkReportWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL, GetWorkReportResponse *))handler;

//获取黄页
- (void)getYellowPagesWithDict:(NSDictionary *)dict
                      complete:(void(^)(BOOL, GetYellowPagesResponse *))handler;

//获取房间信息
- (void)getRoomInfoWithDict:(NSDictionary *)dict
                   complete:(void(^)(BOOL, GetRoomInfoResponse *))handler;

//获取小区里所有停车位
- (void)getParkingsWithDict:(NSDictionary *)dict
                   complete:(void(^)(BOOL, int, NSArray *))handler;

//获取用户在绑定房间的停车位
- (void)getBindParkingsWithDict:(NSDictionary *)dict
                       complete:(void(^)(BOOL, int, NSArray *))handler;

//增加用户在小区里停车位
- (void)addUserParkingsWithDict:(NSDictionary *)dict
                       complete:(void(^)(BOOL, int))handler;

//删除用户在小区里停车位
- (void)deleteUserParkingsWithDict:(NSDictionary *)dict
                       complete:(void(^)(BOOL, int))handler;

//上传图片
- (void)uploadPicturesWithType:(int)type
                       picture:(UIImage *)picture
                      complete:(void(^)(BOOL, int, NSString *))handler;

//-----------------------------------增值服务------------------------------------
//周边优惠
- (void)getShopsWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, GetShopsResponse *))handler;

//社区活动
- (void)getActivitiesWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL, GetActivitiesResponse *))handler;

//-----------------------------------实时天气------------------------------------
- (void)getIntimeWeather:(NSString *)cityId
                complete:(void(^)(NSString *))handler;

//-----------------------------------支付相关------------------------------------
//生成支付单号
- (void)getOrderNumberWithDict:(NSDictionary *)dict
                      complete:(void(^)(BOOL, GetOrderNumberResponse *))handler;

//获取支付结果
- (void)getPayResultWithDict:(NSDictionary *)dict
                    complete:(void(^)(BOOL, int result))handler;

//获取支付记录
- (void)getPayLogsWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL, GetPayLogsResponse *))handler;

@end
