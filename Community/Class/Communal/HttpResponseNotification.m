//
//  HttpResponseNotification.m
//  Community
//
//  Created by SYZ on 13-12-4.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "HttpResponseNotification.h"

@implementation HttpResponseNotification

//获取验证码的http响应提示
+ (void)getVerifyCodeHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"验证码已发送到您的手机"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"输入有误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ALREADY_EXIST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"该手机已被注册"];
            break;
            
        case RESPONSE_NOT_EXIST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"用户不存在"];
            break;
            
        case RESPONSE_FORMAT_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"手机格式有误"];
            break;
            
        case RESPONSE_TOO_MUCH:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请求验证码时间过短"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取验证码失败,请重试"];
            break;
            
        default:
            break;
    }
}

//注册的http响应提示
+ (void)registerHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"注册成功"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"手机号长度有误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_VERIFY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"验证码错误"];
            break;
            
        case RESPONSE_ALREADY_EXIST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"该手机已被注册"];
            break;
            
        case RESPONSE_FORMAT_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"手机格式有误"];
            break;
            
        case RESPONSE_TIMEOUT:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"验证超时"];
            break;
            
        case RESPONSE_NOT_VERIFY:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"尚未验证手机"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"注册失败,请重试"];
            break;
            
        default:
            break;
    }
}

//登录的http响应提示
+ (void)loginHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"登录成功"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"手机号长度有误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_FORMAT_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"手机格式有误"];
            break;
            
        case RESPONSE_WRONG_PASSWORD_OR_NAME:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"手机号或密码错误"];
            break;
            
        case RESPONSE_NOT_EXIST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"用户不存在"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"登录失败,请重试"];
            break;
            
        default:
            break;
    }
}

//忘记密码的http响应提示
+ (void)changeForgetPasswordHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"修改密码成功"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"输入有误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_VERIFY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"验证码错误"];
            break;
            
        case RESPONSE_FORMAT_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"手机格式有误"];
            break;
            
        case RESPONSE_TIMEOUT:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"验证码超时"];
            break;
            
        case RESPONSE_NOT_VERIFY:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"尚未验证手机"];
            break;
            
        case RESPONSE_NOT_EXIST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"用户不存在"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"修改密码失败,请重试"];
            break;
            
        default:
            break;
    }
}

//修改密码的http响应提示
+ (void)changePasswordHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"修改密码成功"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"输入有误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_WRONG_PASSWORD_OR_NAME:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"密码错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"修改密码失败,请重试"];
            break;
            
        default:
            break;
    }
}

//完善信息的http响应提示
+ (void)updateUserInfoHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"完善个人信息成功"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"输入有误"];        
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"完善个人信息失败\n请重试"];
            break;
            
        case RESPONSE_TOO_MUCH:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"房间数达到上限"];
            break;
            
        default:
            break;
    }
}

//获得用户房间列表http响应提示
+ (void)getUserRoomsHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"输入有误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取失败,请重试"];
            break;
            
        default:
            break;
    }
}

//投诉报修的http响应提示
+ (void)TSBXHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"投诉/报修提交成功"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"图片尺寸超过限制"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"提交失败,请重试"];
            break;
            
        default:
            break;
    }
}

//获得任务的http响应提示
+ (void)getTaskHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"参数错误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取失败,请稍后重试"];
            break;
            
        default:
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            break;
    }
}

//评价任务的http响应提示
+ (void)commentTaskHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"感谢您的评价"];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"参数错误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"评价失败,请稍后重试"];
            break;
            
        default:
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            break;
    }
}

//获得任务详细流程的http响应提示
+ (void)getTaskFlowHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"参数错误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取失败,请稍后重试"];
            break;
            
        default:
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            break;
    }
}

//获取房间信息的http响应提示
+ (void)getRoomInfoHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"参数错误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_WRONG_PASSWORD_OR_NAME:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"密码错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取失败,请重试"];
            break;
            
        default:
            break;
    }
}

//上传图片的http响应提示
+ (void)uploadPictureHttpResponse:(int)responseCode
{
    switch (responseCode) {
        case RESPONSE_SUCCESS:
            [[CommunityIndicator sharedInstance] hideIndicator:YES];
            break;
            
        case RESPONSE_BAD_REQUEST:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"参数错误"];
            break;
            
        case RESPONSE_SERVER_QUERY_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"服务器错误"];
            break;
            
        case RESPONSE_ERROR:
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"上传失败,请重试"];
            break;
            
        default:
            break;
    }
}

@end
