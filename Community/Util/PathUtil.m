//
//  PathUtil.m
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "PathUtil.h"
#import "FileUtil.h"

#define Image @"image"

static NSString* DOCPATH = nil;

@implementation PathUtil

+ (void)ensureLocalDirsPresent
{
    NSFileManager* fm = [NSFileManager defaultManager];
    
    NSString* dir0 = [[self documentsPath] stringByAppendingPathComponent:Image];
    
    [fm createDirectoryAtPath:dir0 withIntermediateDirectories:NO attributes:nil error:nil];
    
    //DO NOT BACKUP
    [FileUtil addSkipBackupAttributeForPath:[self documentsPath]];  //保险起见，把documents根目录也设为DO NOT BACKUP
    [FileUtil addSkipBackupAttributeForPath:dir0];
}

+ (NSString *)surfDbFilePath
{
    return [[self documentsPath] stringByAppendingPathComponent:@"Community.sqlite"];
}

+ (NSString *)documentsPath
{
    if(!DOCPATH) {
        DOCPATH = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    return DOCPATH;
}

+ (NSString *)pathOfResourceNamed:(NSString *)name
{
    return [[NSBundle mainBundle] pathForResource:[[name lastPathComponent] stringByDeletingPathExtension] ofType:[name pathExtension]];
}

+ (NSString *)pathOfResourceNamed:(NSString *)name inBundleDir:(NSString *)dir
{
    return [[NSBundle mainBundle] pathForResource:[[name lastPathComponent] stringByDeletingPathExtension] ofType:[name pathExtension] inDirectory:dir];
}

+ (NSString*)rootPathOfImageDir
{
    return [[self documentsPath] stringByAppendingPathComponent:Image];
}

+ (NSString *)pathOfImage:(NSString *)imageName
{
    return [[self rootPathOfImageDir] stringByAppendingPathComponent:imageName];
}

+ (NSString *)pathOfAvatar
{
    return [[self rootPathOfImageDir] stringByAppendingPathComponent:@"avatar"];
}

@end
