//
//  AppSetting.m
//  Community
//
//  Created by SYZ on 13-12-3.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting

+ (long long)userId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults stringForKey:USER_ID];
    if (userId == nil) {
        return ILLEGLE_USER_ID;
    }
    return [userId longLongValue];
}

+ (void)saveUserId:(long long)userId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%lld", userId] forKey:USER_ID];
    [userDefaults synchronize];
}
+ (NSString *)deviceToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:DEVICE_TOKEN];
}

+ (void)saveDeviceToken:(NSString *)token
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:DEVICE_TOKEN];
    [userDefaults synchronize];
}
+ (NSString *)userPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:USER_PASSWORD];
}

+ (void)savePassowrd:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:USER_PASSWORD];
    [userDefaults synchronize];
}

+ (long long)communityId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *communityId = [userDefaults stringForKey:COMMUNITY_ID];
    if (communityId == nil) {
        return ILLEGLE_COMMUNITY_ID;
    }
    return [communityId longLongValue];
}

+ (void)saveCommunityId:(long long)communityId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%lld", communityId] forKey:COMMUNITY_ID];
    [userDefaults synchronize];
}

+ (NSString *)locationCity
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:CITY_NAME];
}

+ (void)saveLoactionCity:(NSString *)city
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:city forKey:CITY_NAME];
    [userDefaults synchronize];
}

+ (NSString *)appVersion
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:APP_VERSION];
}

+ (void)saveAppVersion:(NSString *)version
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:APP_VERSION];
    [userDefaults synchronize];
}

+ (BOOL)alertAppCheckUpdate
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:CHECK_UPDATE];
}

+ (void)saveAppCheckUpdate:(BOOL)check
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:check forKey:CHECK_UPDATE];
    [userDefaults synchronize];
}

+ (long long)newestNoticeId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *noticeId = [userDefaults stringForKey:NEWEST_NOTICE_ID];
    if (noticeId == nil) {
        return ILLEGLE_NOTICE_ID;
    }
    return [noticeId longLongValue];
}

+ (void)saveNewestNoticeId:(long long)noticeId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%lld", noticeId] forKey:NEWEST_NOTICE_ID];
    [userDefaults synchronize];
}

+ (BOOL)newestNoticeChecked
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:NEWEST_NOTICE_CHECKED];
}

+ (void)saveNewestNoticeChecked:(BOOL)check
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:check forKey:NEWEST_NOTICE_CHECKED];
    [userDefaults synchronize];
}

+ (void)deleteUserId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_ID];
    [userDefaults synchronize];
}

+ (void)deletePassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_PASSWORD];
    [userDefaults synchronize];
}

+ (void)deleteCommunityId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:COMMUNITY_ID];
    [userDefaults synchronize];
}

+ (void)userLogout
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_ID];
    [userDefaults removeObjectForKey:USER_PASSWORD];
    [userDefaults removeObjectForKey:COMMUNITY_ID];
    [userDefaults removeObjectForKey:CHECK_UPDATE];
    [userDefaults removeObjectForKey:NEWEST_NOTICE_ID];
    [userDefaults removeObjectForKey:NEWEST_NOTICE_CHECKED];
    [userDefaults synchronize];
    
    //清除支付记录
    [[CommunityDbManager sharedInstance] deletePayLogs];
    //清除车位记录
    [[CommunityDbManager sharedInstance] deleteParkingInfos];
    //清楚投诉报修记录
    [[CommunityDbManager sharedInstance] deleteTasks];
    //删除头像
    [FileUtil deleteFileAtPath:[PathUtil pathOfAvatar]];
}

+ (long long)alipayOrderNumber
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *order = [userDefaults stringForKey:ALIPAY_ORDER_NUMBER];
    if (order == nil) {
        return ILLEGLE_ORDER_NUMBER;
    }
    return [order longLongValue];
}

+ (void)saveAlipayOrderNumber:(long long)order
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%lld", order] forKey:ALIPAY_ORDER_NUMBER];
    [userDefaults synchronize];
}

+ (void)deleteAlipayOrderNumber
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:ALIPAY_ORDER_NUMBER];
    [userDefaults synchronize];
}

+ (void)downloadAvatar
{
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    if ([user.picture isEqualToString:kCommunityImageServer]) {
        return;
    }
    NSString *imgPath = [PathUtil pathOfAvatar];
    ImageDownloadingTask *task = [ImageDownloadingTask new];
    [task setImageUrl:user.picture];
    [task setUserData:user];
    [task setTargetFilePath:imgPath];
    [task setCompletionHandler:^(BOOL succeeded, ImageDownloadingTask *idt) {
        if(succeeded && idt != nil && [idt.userData isEqual:user]){
            [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadAvatar object:nil];
        }
    }];
    [[ImageDownloader sharedInstance] download:task];
}

+ (UIImage *)avatarImage
{
    NSString *imgPath = [PathUtil pathOfAvatar];
    NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
    NSFileManager* fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:imgPath]) {
        return [UIImage imageWithData:imgData];
    }
    return [UIImage imageNamed:@"default_avatar"];
}

+ (void)cleanCache
{
    [FileUtil deleteContentsOfDir:[PathUtil rootPathOfImageDir] without:@"avatar"];
}
//存入NSUserDefaults
+(void)savrInfo:(NSString *)key andValue:(NSString *)valve
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:valve forKey:key];
    [userDefaults synchronize];

}
//取出NSUserDefaults
+(NSString *)getInfoValue:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:key];

}
@end
