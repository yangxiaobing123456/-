//
//  HttpClientManager.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "HttpClientManager.h"

@implementation HttpClientManager

+ (HttpClientManager *)sharedInstance
{
    static HttpClientManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HttpClientManager alloc] init];
    });
    return sharedInstance;
}

//http认证
- (NSString *)authorizationHttpHeaderString
{
    return [NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
}
//获取首页的推荐广告和最新通知123
- (void)getnewHomeRecommendWithDict:(NSDictionary *)dict
                        complete:(void(^)(BOOL, int, NoticeInfo *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getMSYAdvertise]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            BOOL newAds = NO;
            HomeRecommendResponse *resp = [EzJsonParser deserializeFromJson:body asType:[HomeRecommendResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (AdInfo *info in resp.list) {
                    info.communityId = [AppSetting communityId];
                    info.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.picture];
                    NSLog(@"info.pictor===%@",info.picture);
                    [[CommunityDbManager sharedInstance] insertOrUpdateAd:info];
                    newAds = YES;
                }
                if (resp.notice) {
                    resp.notice.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, resp.notice.picture];
                }
                handler(newAds, RESPONSE_SUCCESS, resp.notice);
            } else {
                handler(newAds, resp.result, nil);
            }
        } else {
            handler(NO, RESPONSE_ERROR, nil);
        }
    }];
}

//获取首页的推荐广告和最新通知
- (void)getHomeRecommendWithDict:(NSDictionary *)dict
                        complete:(void(^)(BOOL, int, NoticeInfo *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetHomeRecommendURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            BOOL newAds = NO;
            HomeRecommendResponse *resp = [EzJsonParser deserializeFromJson:body asType:[HomeRecommendResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (AdInfo *info in resp.list) {
                    NSLog(@"adList===%@   %@   %@",info.picture,info.content,info.title);
                    info.communityId = [AppSetting communityId];
                    info.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, info.picture];
                    [[CommunityDbManager sharedInstance] insertOrUpdateAd:info];
                    newAds = YES;
                }
                if (resp.notice) {
                    resp.notice.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, resp.notice.picture];
                }
                handler(newAds, RESPONSE_SUCCESS, resp.notice);
            } else {
                handler(newAds, resp.result, nil);
            }
        } else {
            handler(NO, RESPONSE_ERROR, nil);
        }
    }];
}

//----------------------------------User----------------------------------------
//检查更新
- (void)checkUpdateWithDict:(NSDictionary *)dict complete:(void(^)(BOOL, CheckUpdateResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kCheckUpdateURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            CheckUpdateResponse *resp = [EzJsonParser deserializeFromJson:body asType:[CheckUpdateResponse class]];
            if (resp.result == RESPONSE_SUCCESS || resp.result == RESPONSE_FORCE_UPDATE) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}
//获取支付手机验证码
- (void)getZFVerifyCodeWithPhoneNumber:(NSString *)phone complete:(void (^)(BOOL, int))handler{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:phone forKey:@"telephone"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetVerifyCodeURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetVerifyCodeResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetVerifyCodeResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
            //            NSData *data = [[error userInfo] valueForKey:@"data"];
            //            NSString *errorDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //            DJLog(@"GTMHTTPFetcher Error:%d, %@", error.code, errorDataString);
        }
    }];

    
}
//

//获取手机验证码
- (void)getVerifyCodeWithPhoneNumber:(NSString *)phone complete:(void (^)(BOOL, int))handler
{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:phone forKey:@"telephone"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetVerifyCodeURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetVerifyCodeResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetVerifyCodeResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
//            NSData *data = [[error userInfo] valueForKey:@"data"];
//            NSString *errorDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            DJLog(@"GTMHTTPFetcher Error:%d, %@", error.code, errorDataString);
        }
    }];
}

//用户注册
- (void)userRegisterWithDict:(NSDictionary *)dict complete:(void(^)(BOOL, int, long long))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kUserRegisterURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            UserRegisterResponse *resp = [EzJsonParser deserializeFromJson:body asType:[UserRegisterResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS, resp.userId);
            } else {
                handler(NO, resp.result, ILLEGLE_USER_ID);
            }
        } else {
            handler(NO, RESPONSE_ERROR, ILLEGLE_USER_ID);
        }
    }];
}

//用户登录
- (void)userLoginWithDict:(NSDictionary *)dict complete:(void(^)(BOOL, int, UserInfo *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kUserLoginURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        NSLog(@"login ----登陆接口调用------");
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            UserLoginResponse *resp = [EzJsonParser deserializeFromJson:body asType:[UserLoginResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS, resp.info);
            } else {
                handler(NO, resp.result, nil);
            }
        } else {
            handler(NO, RESPONSE_ERROR, nil);
        }
    }];
}

//更新profile
- (void)updateProfileWithDict:(NSDictionary *)dict image:(UIImage *)picture complete:(void(^)(BOOL, int))handler
{
    GTMMIMEDocument *doc = [GTMMIMEDocument MIMEDocument];
    NSDictionary *headers = nil;
    NSData *body = nil;
    NSInputStream *stream = nil;
    NSString *boundary = nil;
    unsigned long long len = 0;
    
    //dict
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        headers = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"form-data; name=\"%@\"", key] forKey:@"Content-Disposition"];
        body = [value dataUsingEncoding:NSUTF8StringEncoding];
        [doc addPartWithHeaders:headers body:body];
    }
    
    //image
    if (picture) {
        headers = [NSDictionary dictionaryWithObjectsAndKeys:@"form-data; name=\"file\"; filename=\"picture.png\"", @"Content-Disposition", @"image/png", @"Content-Type", nil];
        body = UIImagePNGRepresentation(picture);
        [doc addPartWithHeaders:headers body:body];
    }
    
    [doc generateInputStream:&stream length:&len boundary:&boundary];
    
    if (stream) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kUpdateProfileURL]];
        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%llu", len] forHTTPHeaderField:@"Content-Length"];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher setPostStream:stream];
        [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                DJLog(@"GTMHTTPFetcher:%@", body);
                UpdateProfileResponse *resp = [EzJsonParser deserializeFromJson:body asType:[UpdateProfileResponse class]];
                if (resp.result == RESPONSE_SUCCESS) {
                    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
                    user.userName = [dict valueForKey:@"name"];
                    user.gender = [[dict valueForKey:@"gender"] integerValue];
                    user.birthday = [[dict valueForKey:@"birthday"] longLongValue];
                    user.updateTime = resp.updateTime;
                    user.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, resp.picture];
                    [[CommunityDbManager sharedInstance] insertOrUpdateUserInfo:user];
                    [AppSetting downloadAvatar];
                    handler(YES, RESPONSE_SUCCESS);
                } else {
                    handler(NO, resp.result);
                }
            } else {
                handler(NO, RESPONSE_ERROR);
            }
        }];
    }
}

//获取profile
- (void)getProfileWithDict:(NSDictionary *)dict complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetProfileURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetProfileResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetProfileResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                if (resp.info) {
                    UserInfo *user = resp.info;
                    user.picture = [NSString stringWithFormat:@"%@%@", kCommunityImageServer, user.picture];
                    [[CommunityDbManager sharedInstance] insertOrUpdateUserInfo:user];
                    [AppSetting saveCommunityId:user.communityId];
                    [AppSetting downloadAvatar];
                }
//                handler(YES, RESPONSE_SUCCESS);
            } else {
//                handler(NO, resp.result);
            }
        } else {
//            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//找回密码时获取手机验证码
- (void)forgetPasswordWithPhoneNumber:(NSString *)phone
                             complete:(void(^)(BOOL, int))handler
{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:phone forKey:@"telephone"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kForgetPwdURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetVerifyCodeResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetVerifyCodeResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//找回密码
- (void)changeForgetPasswordWithDict:(NSDictionary *)dict
                            complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kChangeForgetPwdURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            ChangePwdResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ChangePwdResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//修改密码
- (void)changePasswordWithDict:(NSDictionary *)dict
                      complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kChangePwdURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            ChangePwdResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ChangePwdResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//获得开通城市列表
- (void)getCitiesWithDict:(NSDictionary *)dict
                 complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetHotCitiesURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetCityResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetCityResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (int i = 0; i < resp.list.count; i++) {
                    HotCity *c = (HotCity *)[resp.list objectAtIndex:i];
                    [[CommunityDbManager sharedInstance] insertOrUpdateCity:c];
                }
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
            NSData *data = [[error userInfo] valueForKey:@"data"];
            NSString *errorDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DJLog(@"GTMHTTPFetcher Error:%@", errorDataString);
        }
    }];
}

//获得小区列表
- (void)getCommunitysWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetCommunitysURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetCommunitysResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetCommunitysResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (int i = 0; i < resp.list.count; i++) {
                    Community *c = (Community *)[resp.list objectAtIndex:i];
                    [[CommunityDbManager sharedInstance] insertOrUpdateCommunity:c];
                }
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
            NSData *data = [[error userInfo] valueForKey:@"data"];
            NSString *errorDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DJLog(@"GTMHTTPFetcher Error:%@", errorDataString);
        }
    }];
}

//获得幢列表
- (void)getBuildingsWithDict:(NSDictionary *)dict
                    complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetBuildingsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetBuildingsResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetBuildingsResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (int i = 0; i < resp.list.count; i++) {
                    Building *b = (Building *)[resp.list objectAtIndex:i];
                    [[CommunityDbManager sharedInstance] insertOrUpdateBuilding:b];
                }
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//获得单元列表
- (void)getUnitsWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetUnitsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetUnitsResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetUnitsResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (int i = 0; i < resp.list.count; i++) {
                    Unit *u = (Unit *)[resp.list objectAtIndex:i];
                    [[CommunityDbManager sharedInstance] insertOrUpdateUnit:u];
                }
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//获得房间列表
- (void)getRoomsWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetRoomsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetRoomsResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetRoomsResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (int i = 0; i < resp.list.count; i++) {
                    Room *r = (Room *)[resp.list objectAtIndex:i];
                    [[CommunityDbManager sharedInstance] insertOrUpdateRoom:r];
                }
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//获得用户房间列表
- (void)getUserRoomsWithDict:(NSDictionary *)dict
                    complete:(void(^)(BOOL, int, NSArray *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetUserRoomsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetUserRoomsResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetUserRoomsResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS, resp.list);
            } else {
                handler(NO, resp.result, nil);
            }
        } else {
            handler(NO, RESPONSE_ERROR, nil);
        }
    }];
}
//获得团购商品列表
- (void)getTuanGouWithDict:(NSDictionary *)dict
                    complete:(void(^)(BOOL, int, NSArray *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetUserRoomsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetUserRoomsResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetUserRoomsResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS, resp.list);
            } else {
                handler(NO, resp.result, nil);
            }
        } else {
            handler(NO, RESPONSE_ERROR, nil);
        }
    }];
}



//绑定房间
- (void)bindRoomWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kBindRoomURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            BindRoomResponse *resp = [EzJsonParser deserializeFromJson:body asType:[BindRoomResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//添加房间
- (void)addRoomWithDict:(NSDictionary *)dict
               complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kAddRoomsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            AddRoomResponse *resp = [EzJsonParser deserializeFromJson:body asType:[AddRoomResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//删除房间
- (void)deleteRoomWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kDeleteRoomsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DeleteRoomResponse *resp = [EzJsonParser deserializeFromJson:body asType:[DeleteRoomResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//获得小区信息
- (void)getCommunityInfoWithCommunityId:(long long)communityId
                               complete:(void(^)(BOOL))handler
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLongLong:communityId], @"id", [NSNumber numberWithInt:0], @"updateTime", nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetCommunityInfoURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetCommunityInfoResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetCommunityInfoResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                [[CommunityDbManager sharedInstance] insertOrUpdateCommunity:resp.info];
                handler(YES);
            } else {
                handler(NO);
            }
        } else {
            handler(NO);
        }
    }];
}

//意见反馈
- (void)submitSuggestWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kSuggestURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            CommunityBaseResponse *resp = [EzJsonParser deserializeFromJson:body asType:[CommunityBaseResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES);
            } else {
                handler(NO);
            }
        } else {
            handler(NO);
        }
    }];
}

//----------------------------------Wuye----------------------------------------
//投诉
- (void)complainWithDict:(NSDictionary *)dict
                   image:(UIImage *)picture
                complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler
{
    GTMMIMEDocument *doc = [GTMMIMEDocument MIMEDocument];
    NSDictionary *headers = nil;
    NSData *body = nil;
    NSInputStream *stream = nil;
    NSString *boundary = nil;
    unsigned long long len = 0;
    
    //dict
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        headers = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"form-data; name=\"%@\"", key] forKey:@"Content-Disposition"];
        body = [value dataUsingEncoding:NSUTF8StringEncoding];
        [doc addPartWithHeaders:headers body:body];
    }
    
    //image
    if (picture) {
        headers = [NSDictionary dictionaryWithObjectsAndKeys:@"form-data; name=\"picture\"; filename=\"picture.png\"", @"Content-Disposition", @"image/png", @"Content-Type", nil];
        body = UIImagePNGRepresentation(picture);
        
        [doc addPartWithHeaders:headers body:body];
    }
    
    [doc generateInputStream:&stream length:&len boundary:&boundary];
    
    if (stream) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kComplainURL]];
        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%llu", len] forHTTPHeaderField:@"Content-Length"];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher setPostStream:stream];
        [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                ComplainAndRepairResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ComplainAndRepairResponse class]];
                if (resp.result == RESPONSE_SUCCESS) {
                    handler(YES, resp);
                } else {
                    handler(NO, resp);
                }
            } else {
                handler(NO, nil);
            }
        }];
    }
}

//报修
- (void)repairWithDict:(NSDictionary *)dict
                 image:(UIImage *)picture
              complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler
{
    GTMMIMEDocument *doc = [GTMMIMEDocument MIMEDocument];
    NSDictionary *headers = nil;
    NSData *body = nil;
    NSInputStream *stream = nil;
    NSString *boundary = nil;
    unsigned long long len = 0;
    
    //dict
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        headers = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"form-data; name=\"%@\"", key] forKey:@"Content-Disposition"];
        body = [value dataUsingEncoding:NSUTF8StringEncoding];
        [doc addPartWithHeaders:headers body:body];
    }
    
    //image
    if (picture) {
        headers = [NSDictionary dictionaryWithObjectsAndKeys:@"form-data; name=\"picture\"; filename=\"picture.png\"", @"Content-Disposition", @"image/png", @"Content-Type", nil];
        body = UIImagePNGRepresentation(picture);
        
        [doc addPartWithHeaders:headers body:body];
    }
    
    [doc generateInputStream:&stream length:&len boundary:&boundary];
    
    if (stream) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kRepairURL]];
        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%llu", len] forHTTPHeaderField:@"Content-Length"];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher setPostStream:stream];
        [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                ComplainAndRepairResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ComplainAndRepairResponse class]];
                if (resp.result == RESPONSE_SUCCESS) {
                    handler(YES, resp);
                } else {
                    handler(NO, resp);
                }
            } else {
                handler(NO, nil);
            }
        }];
    }
}

//多图分享
- (void)shareWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ShareActivity]];
    
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            ComplainAndRepairResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ComplainAndRepairResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}


//多图投诉
- (void)complainWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kMultiImageComplainURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            ComplainAndRepairResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ComplainAndRepairResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

//多图报修
- (void)repairWithDict:(NSDictionary *)dict
              complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kMultiImageRepairURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            ComplainAndRepairResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ComplainAndRepairResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}
- (void)YYrepairWithDict:(NSDictionary *)dict
              complete:(void(^)(BOOL, ComplainAndRepairResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:multigraphAppointRepairURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            ComplainAndRepairResponse *resp = [EzJsonParser deserializeFromJson:body asType:[ComplainAndRepairResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}


//投诉报修历史记录
- (void)tsbxHistoryWithDict:(NSDictionary *)dict
                   complete:(void(^)(int result))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kTSBXHistoryURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            TSBXHistoryResponse *resp = [EzJsonParser deserializeFromJson:body asType:[TSBXHistoryResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                for (int i = 0; i < resp.list.count; i++) {
                    TaskInfo *task = (TaskInfo *)[resp.list objectAtIndex:i];
                    [[CommunityDbManager sharedInstance] insertOrUpdateTask:task];
                }
            }
            handler(resp.result);
        } else {
            handler(RESPONSE_ERROR);
        }
    }];
}

//任务详细流程
- (void)getTaskFlowWith:(NSDictionary *)dict
               complete:(void(^)(int result, NSArray *array))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kTaskFlowURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetTaskFlowResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetTaskFlowResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(RESPONSE_SUCCESS, resp.list);
            } else {
                handler(resp.result, nil);
            }
        } else {
            handler(RESPONSE_ERROR, nil);
        }
    }];
}

//任务评价
- (void)commentTaskWith:(NSDictionary *)dict
               complete:(void(^)(int result))handler
{
    GTMMIMEDocument *doc = [GTMMIMEDocument MIMEDocument];
    NSDictionary *headers = nil;
    NSData *body = nil;
    NSInputStream *stream = nil;
    NSString *boundary = nil;
    unsigned long long len = 0;
    
    //dict
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        headers = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"form-data; name=\"%@\"", key] forKey:@"Content-Disposition"];
        body = [value dataUsingEncoding:NSUTF8StringEncoding];
        [doc addPartWithHeaders:headers body:body];
    }
    
    [doc generateInputStream:&stream length:&len boundary:&boundary];
    
    if (stream) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kTaskCommentURL]];
        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%llu", len] forHTTPHeaderField:@"Content-Length"];
    
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher setPostStream:stream];
        [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                CommunityBaseResponse *resp = [EzJsonParser deserializeFromJson:body asType:[CommunityBaseResponse class]];
                handler(resp.result);
            } else {
                handler(RESPONSE_ERROR);
                NSData *data = [[error userInfo] valueForKey:@"data"];
                NSString *errorDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                DJLog(@"GTMHTTPFetcher Error:%d, %@", error.code, errorDataString);
            }
        }];
    }
}

//获取通知
- (void)getNoticesWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL, GetNoticesResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetNoticesURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetNoticesResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetNoticesResponse class]];
            NSLog(@"请求返回Str----%@",body);
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

//获取财务报告
- (void)getFinanceReportWithDict:(NSDictionary *)dict
                        complete:(void(^)(BOOL, GetFinanceReportResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetFinanceReportURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetFinanceReportResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetFinanceReportResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

//获取工作报告
- (void)getWorkReportWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL, GetWorkReportResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetWorkReportURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetWorkReportResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetWorkReportResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

//获取黄页
- (void)getYellowPagesWithDict:(NSDictionary *)dict
                      complete:(void(^)(BOOL, GetYellowPagesResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kYellowPagesURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetYellowPagesResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetYellowPagesResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

//获取房间信息
- (void)getRoomInfoWithDict:(NSDictionary *)dict
                   complete:(void(^)(BOOL, GetRoomInfoResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetRoomInfoURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetRoomInfoResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetRoomInfoResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

//获取小区里所有停车位
- (void)getParkingsWithDict:(NSDictionary *)dict
                   complete:(void(^)(BOOL, int, NSArray *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetParkingsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetParkingInfoResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetParkingInfoResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS, resp.list);
            } else {
                handler(NO, resp.result, nil);
            }
        } else {
            handler(NO, RESPONSE_ERROR, nil);
        }
    }];
}

//获取用户在小区里停车位
- (void)getBindParkingsWithDict:(NSDictionary *)dict
                       complete:(void(^)(BOOL, int, NSArray *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetBindParkingsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetBindParkingResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetBindParkingResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS, resp.list);
            } else {
                handler(NO, resp.result, nil);
            }
        } else {
            handler(NO, RESPONSE_ERROR, nil);
        }
    }];
}

//增加用户在小区里停车位
- (void)addUserParkingsWithDict:(NSDictionary *)dict
                       complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kAddUserParkingURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            AddUserParkingResponse *resp = [EzJsonParser deserializeFromJson:body asType:[AddUserParkingResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//删除用户在小区里停车位
- (void)deleteUserParkingsWithDict:(NSDictionary *)dict
                          complete:(void(^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kDeleteUserParkingURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DeleteUserParkingResponse *resp = [EzJsonParser deserializeFromJson:body asType:[DeleteUserParkingResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, RESPONSE_SUCCESS);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

//PICTURE_TYPE_PORTRAIT = 2;
//PICTURE_TYPE_REPAIR = 3;
//PICTURE_TYPE_COMPLAIN = 4;
//PICTURE_TYPE_NOTICE = 5;
//PICTURE_TYPE_SHOP = 6;
//PICTURE_TYPE_ADVERTISEMENT = 7;
//上传图片
- (void)uploadPicturesWithType:(int)type
                       picture:(UIImage *)picture
                      complete:(void(^)(BOOL, int, NSString *))handler
{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    
    GTMMIMEDocument *doc = [GTMMIMEDocument MIMEDocument];
    NSDictionary *headers = nil;
    NSData *body = nil;
    NSInputStream *stream = nil;
    NSString *boundary = nil;
    unsigned long long len = 0;
    
    //dict
    for (NSString *key in [dict allKeys]) {
        id value = [dict objectForKey:key];
        headers = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"form-data; name=\"%@\"", key] forKey:@"Content-Disposition"];
        body = [value dataUsingEncoding:NSUTF8StringEncoding];
        [doc addPartWithHeaders:headers body:body];
    }
    
    //image
    if (picture) {
        headers = [NSDictionary dictionaryWithObjectsAndKeys:@"form-data; name=\"picture\"; filename=\"picture.png\"", @"Content-Disposition", @"image/png", @"Content-Type", nil];
        body = UIImagePNGRepresentation(picture);
        
        [doc addPartWithHeaders:headers body:body];
    }
    
    [doc generateInputStream:&stream length:&len boundary:&boundary];
    
    if (stream) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kUploadPicturesURL]];
        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%llu", len] forHTTPHeaderField:@"Content-Length"];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher setPostStream:stream];
        [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
            if (!error) {
                NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                UploadPicturesResponse *resp = [EzJsonParser deserializeFromJson:body asType:[UploadPicturesResponse class]];
                if (resp.result == RESPONSE_SUCCESS) {
                    handler(YES, RESPONSE_SUCCESS, resp.picture);
                } else {
                    handler(YES, resp.result, nil);
                }
            } else {
                handler(NO, RESPONSE_ERROR, nil);
            }
        }];
    }
}

//-----------------------------------增值服务----------------------------------------
//周边优惠
- (void)getShopsWithDict:(NSDictionary *)dict
                complete:(void(^)(BOOL, GetShopsResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetShopsURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    
    
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetShopsResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetShopsResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

//社区活动
- (void)getActivitiesWithDict:(NSDictionary *)dict
                     complete:(void(^)(BOOL, GetActivitiesResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetActivitiesURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetActivitiesResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetActivitiesResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}
//-----------------------------------团购-----------------------------------


//-----------------------------------实时天气------------------------------------
- (void)getIntimeWeather:(NSString *)cityId complete:(void (^)(NSString *))handler
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@.html", kIntimeWeatherURL, cityId];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            IntimeWeatherResponse *resp = [EzJsonParser deserializeFromJson:body asType:[IntimeWeatherResponse class]];
            IntimeWeatherInfo *info = resp.weatherinfo;
            handler(info.temp);
        } else {
            handler(nil);
        }
    }];
}

//-----------------------------------支付相关------------------------------------
- (void)getOrderNumberWithDict:(NSDictionary *)dict
                      complete:(void(^)(BOOL, GetOrderNumberResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetOrderNumberURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetOrderNumberResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetOrderNumberResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

- (void)getPayResultWithDict:(NSDictionary *)dict complete:(void (^)(BOOL, int))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetPayResultURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetPayResultResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetPayResultResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp.result);
            } else {
                handler(NO, resp.result);
            }
        } else {
            handler(NO, RESPONSE_ERROR);
        }
    }];
}

- (void)getPayLogsWithDict:(NSDictionary *)dict
                  complete:(void(^)(BOOL ,GetPayLogsResponse *))handler
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGetPayLogURL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setPostData:[dict JSONData]];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        if (!error) {
            NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            GetPayLogsResponse *resp = [EzJsonParser deserializeFromJson:body asType:[GetPayLogsResponse class]];
            if (resp.result == RESPONSE_SUCCESS) {
                handler(YES, resp);
            } else {
                handler(NO, resp);
            }
        } else {
            handler(NO, nil);
        }
    }];
}

@end
