//
//  PathUtil.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathUtil : NSObject

+ (void)ensureLocalDirsPresent;

//数据库文件路径
+ (NSString *)surfDbFilePath;

//document文件夹路径
+ (NSString *)documentsPath;

//获取main bundle根目录中名称为@name的资源的路径
+ (NSString *)pathOfResourceNamed:(NSString *)name;

//获取main bundle下指定目录中名称为@name的资源的路径
+ (NSString *)pathOfResourceNamed:(NSString *)name inBundleDir:(NSString*)dir;

//图片文件夹路径
+ (NSString *)rootPathOfImageDir;

//图片路径
+ (NSString *)pathOfImage:(NSString *)imageName;

//头像图片路径
+ (NSString *)pathOfAvatar;

@end
