//
//  CommunityDbManager.m
//  Community
//
//  Created by SYZ on 13-11-28.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityDbManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "PathUtil.h"
#import "FileUtil.h"

/*
 //sqlite FAQ:
 //http://www.sqlite.org/faq.html
 //
 //sqlite built-in Datatypes
 //http://www.sqlite.org/datatype3.html
 //  TEXT-->
 CHARACTER(20)
 VARCHAR(255)
 VARYING CHARACTER(255)
 NCHAR(55)
 NATIVE CHARACTER(70)
 NVARCHAR(100)
 TEXT
 CLOB
 //  NUMERIC-->
 NUMERIC
 DECIMAL(10,5)
 BOOLEAN
 DATE
 DATETIME
 //  INTEGER-->
 INT
 INTEGER
 TINYINT
 SMALLINT
 MEDIUMINT
 BIGINT
 UNSIGNED BIG INT
 INT2
 INT8
 //  REAL-->
 REAL
 DOUBLE
 DOUBLE PRECISION
 FLOAT
 //  NONE-->
 BLOB
 */

//数据库版本表名
#define VersionTableName       "VersionTable"
//用户信息表名
#define UserTableName          "UserTable"
//我的物业信息表名
#define MyCommunityTableName   "MyCommunityTable"
//城市信息表名
#define CityTableName          "CityTable"
//社区信息表名
#define CommunityTableName     "CommunityTable"
//幢信息表名
#define BuildingTableName      "BuildingTable"
//单元信息表名
#define UnitTableName          "UnitTable"
//房间信息表名
#define RoomTableName          "RoomTable"
//通知信息表名
#define NoticeTableName        "NoticeTable"
//财务报告信息表名
#define FinanceReportTableName "FinanceReportTable"
//工作报告信息表名
#define WorkReportTableName    "WorkReportTable"
//黄页信息表名
#define YellowPageTableName    "YellowPageTable"
//商户信息表名
#define ShopTableName          "ShopTable"
//社区活动信息表名
#define ActivityTableName      "ActivityTable"
//缴费记录信息表名
#define PayLogTableName        "PayLogTable"
//全国城市表
#define ChinaCityTableName     "ChinaCityTable"
//广告信息表
#define AdTableName            "AdTable"
//车位信息表
#define ParkingTableName       "ParkingTable"
//任务信息表名
#define TaskTableName          "TaskTable"


@implementation NSString (SqlEscape)

- (NSString*)escapeStringForSql
{
    return [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

@end

@implementation CommunityDbManager (private)

//初始化surfdb，确保db可用
- (void)initDb
{
    NSString *expectedDbFilePath = [PathUtil surfDbFilePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:expectedDbFilePath error:nil];
    if([fm fileExistsAtPath:expectedDbFilePath]
       && [FileUtil fileSizeAtPath:expectedDbFilePath] > 0) {
        //db文件存在，尝试用fmdb打开
        fmdb_ = [FMDatabase databaseWithPath:expectedDbFilePath];
        if([fmdb_ open]) {
            //检测是否需要更新数据库
            [self updateDbIfNecessary];
        } else {
            //TODO
            //数据库文件损坏？被篡改？
            //直接删除
            [[NSFileManager defaultManager] removeItemAtPath:expectedDbFilePath error:nil];
            
            [fmdb_ open];
            [self createTables];
            
            [initDelegate_ dbHasBeenRecoveredFromCurruption];
        }
    } else {
        //直接创建新数据库
        fmdb_ = [FMDatabase databaseWithPath:expectedDbFilePath];
        
        //增加Do Not Backup属性
        [FileUtil addSkipBackupAttributeForPath:expectedDbFilePath];
        
        [fmdb_ open];
        
        //建表
        [self createTables];
    }
}

//检测db是否是最新版
//如果是旧版，需要执行更新操作
-(void)updateDbIfNecessary
{
    //打开VersionTable，查看数据库版本，作相应的更新操作
    FMResultSet* result = [fmdb_ executeQuery:@"SELECT db_version FROM VersionTable"];
    if(result != nil && [result next]) {
        int dbVersion = [result intForColumnIndex:0];
        
        //TODO
        if(dbVersion == 0) {
            //1.0.4版本修改了工作报告表
            //----删除开始----
            [fmdb_ closeOpenResultSets];
            [fmdb_ executeUpdate:@"DROP TABLE IF EXISTS "WorkReportTableName""];
            [fmdb_ open];
            //----删除结束----
            [fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "WorkReportTableName" (\
             report_id INT DEFAULT 0,\
             community_id INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             title TEXT DEFAULT NULL,\
             publish_time TEXT DEFAULT NULL,\
             html TEXT DEFAULT NULL,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"];
            
            //db version升级到1
            [fmdb_ executeUpdate:@"UPDATE VersionTable SET db_version = 1"];
        }
    }
}

-(void)createTables
{
    do {
        [fmdb_ beginTransaction];
        
        //VersionTable
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "VersionTableName" (\
             db_version integer DEFAULT 0,\
             server_cate_version integer DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL)"])
            break;
        //当前db_version版本为0
        //server_cate_version:
        //  服务端的分类列表版本。现在分类列表每次都是全量下发，没有对分类列表进行版本管理。为防止日后出现版本管理，特预留此字段。目前未使用，固定为0
        if(![fmdb_ executeUpdate:@"INSERT INTO "VersionTableName"(db_version,server_cate_version) VALUES(1,0)"])
            break;
        
        //UserTable
        //用户信息表，设计为支持多用户
        //password需要加密后存入数据库!!!
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "UserTableName" (\
             user_id INT PRIMARY KEY DEFAULT 0,\
             password TEXT DEFAULT NULL,\
             gender INT DEFAULT 0,\
             user_name TEXT DEFAULT NULL,\
             nick_name TEXT DEFAULT NULL,\
             birthday INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             picture_url TEXT DEFAULT NULL,\
             community_id INT DEFAULT 0,\
             community_name TEXT DEFAULT NULL,\
             room_id INT DEFAULT 0,\
             room_name TEXT DEFAULT NULL,\
             telephone TEXT DEFAULT NULL,\
             room_discount INT DEFAULT 0,\
             parking_discount INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        //MyCommunityTable
        //我的物业信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "MyCommunityTableName" (\
             province TEXT DEFAULT NULL,\
             city TEXT DEFAULT NULL,\
             community_id INT DEFAULT 0,\
             community_name TEXT DEFAULT NULL,\
             room_id INT DEFAULT 0,\
             room_name TEXT DEFAULT NULL,\
             user_id INT DEFAULT NULL,\
             update_time INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "CityTableName" (\
             city_id INT DEFAULT 0,\
             city_name TEXT DEFAULT NULL,\
             update_time INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "CommunityTableName" (\
             community_id INT DEFAULT 0,\
             community_name TEXT DEFAULT NULL,\
             city_id INT DEFAULT 0,\
             lon DOUBLE DEFAULT 0,\
             lat DOUBLE DEFAULT 0,\
             address TEXT DEFAULT NULL,\
             update_time INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             telephone TEXT DEFAULT NULL,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "BuildingTableName" (\
             building_id INT DEFAULT 0,\
             building_name TEXT DEFAULT NULL,\
             community_id INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "UnitTableName" (\
             unit_id INT DEFAULT 0,\
             unit_name TEXT DEFAULT NULL,\
             building_id INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "RoomTableName" (\
             room_id INT DEFAULT 0,\
             room_name TEXT DEFAULT NULL,\
             unit_id INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        //NoticeTable
        //通知信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "NoticeTableName" (\
             notice_id INT DEFAULT 0,\
             community_id INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             title TEXT DEFAULT NULL,\
             summary TEXT DEFAULT NULL,\
             content TEXT DEFAULT NULL,\
             picture TEXT DEFAULT NULL,\
             notice_type INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        //FinanceReportTable
        //财务报告信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "FinanceReportTableName" (\
             report_id INT DEFAULT 0,\
             str_id TEXT DEFAULT NULL,\
             community_id INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             title TEXT DEFAULT NULL,\
             income TEXT DEFAULT NULL,\
             outcome TEXT DEFAULT NULL,\
             publish_time TEXT DEFAULT NULL,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        //WorkReportTable
        //工作报告信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "WorkReportTableName" (\
             report_id INT DEFAULT 0,\
             community_id INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             title TEXT DEFAULT NULL,\
             publish_time TEXT DEFAULT NULL,\
             html TEXT DEFAULT NULL,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        //YellowPageTable
        //黄页信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "YellowPageTableName" (\
             notice_id INT DEFAULT 0,\
             str_id TEXT DEFAULT NULL,\
             city_id INT DEFAULT 0,\
             community_id INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             lon DOUBLE DEFAULT 0,\
             lat DOUBLE DEFAULT 0,\
             name TEXT DEFAULT NULL,\
             address TEXT DEFAULT NULL,\
             telephone TEXT DEFAULT NULL,\
             service_time TEXT DEFAULT NULL,\
             content TEXT DEFAULT NULL,\
             content2 TEXT DEFAULT NULL,\
             station TEXT DEFAULT NULL,\
             page_type INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        //ShopTable
        //商户信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "ShopTableName" (\
             shop_id INT DEFAULT 0,\
             str_id TEXT DEFAULT NULL,\
             community_id INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             lon DOUBLE DEFAULT 0,\
             lat DOUBLE DEFAULT 0,\
             shop_name TEXT DEFAULT NULL,\
             address TEXT DEFAULT NULL,\
             telephone TEXT DEFAULT NULL,\
             logo TEXT DEFAULT NULL,\
             content TEXT DEFAULT NULL,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        //ActivityTable
        //社区活动信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "ActivityTableName" (\
             activity_id INT DEFAULT 0,\
             str_id TEXT DEFAULT NULL,\
             community_id INT DEFAULT 0,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             title TEXT DEFAULT NULL,\
             summary TEXT DEFAULT NULL,\
             content TEXT DEFAULT NULL,\
             picture TEXT DEFAULT NULL,\
             notice_type INT DEFAULT 0,\
             type INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        //PayLogTable
        //缴费记录信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "PayLogTableName" (\
             pay_id INT DEFAULT 0,\
             community_id INT DEFAULT 0,\
             community_name TEXT DEFAULT NULL,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             trade_status INT DEFAULT 0,\
             pay_method INT DEFAULT 0,\
             start_month INT DEFAULT 0,\
             month INT DEFAULT 0,\
             product_type INT DEFAULT 0,\
             product_id INT DEFAULT 0,\
             product_name TEXT DEFAULT NULL,\
             pay INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "ChinaCityTableName" (\
             city_id TEXT DEFAULT NULL,\
             city_name TEXT DEFAULT NULL,\
             parent_id TEXT DEFAULT NULL,\
             city_short_name TEXT DEFAULT NULL,\
             deep TEXT DEFAULT NULL,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "AdTableName" (\
             ad_id INT DEFAULT 0,\
             city_id INT DEFAULT 0,\
             community_id INT DEFAULT 0,\
             title TEXT DEFAULT NULL,\
             content TEXT DEFAULT NULL,\
             picture TEXT DEFAULT NULL,\
             type INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "ParkingTableName" (\
             parking_id INT DEFAULT 0,\
             community_id INT DEFAULT 0,\
             community_name TEXT DEFAULT NULL,\
             name TEXT DEFAULT NULL,\
             fee INT DEFAULT 0,\
             last_fee INT DEFAULT 0,\
             type INT DEFAULT 0,\
             parking_discount INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL)"])
            break;
        
        //TaskTable
        //任务信息表
        if(![fmdb_ executeUpdate:@"CREATE TABLE IF NOT EXISTS "TaskTableName" (\
             task_id TEXT PRIMARY KEY DEFAULT NULL,\
             community_id TEXT DEFAULT NULL,\
             user_id TEXT DEFAULT NULL,\
             create_time INT DEFAULT 0,\
             update_time INT DEFAULT 0,\
             asign_time INT DEFAULT 0,\
             picture_url TEXT DEFAULT NULL,\
             content TEXT DEFAULT NULL,\
             complainRepair_type INT DEFAULT 0,\
             type INT DEFAULT 0,\
             processor_name TEXT DEFAULT NULL,\
             user_name TEXT DEFAULT NULL,\
             user_telephone TEXT DEFAULT NULL,\
             processor_telephone TEXT DEFAULT NULL,\
             serial_number TEXT DEFAULT NULL,\
             processor_id TEXT DEFAULT NULL,\
             star INT DEFAULT 0,\
             community_name TEXT DEFAULT NULL,\
             need_material INT DEFAULT 0,\
             level INT DEFAULT 0,\
             isComplain INT DEFAULT 0,\
             processOrSupervise INT DEFAULT 0,\
             roomFullName TEXT DEFAULT NULL,\
             isRead INT DEFAULT 0,\
             ext_int0 INT DEFAULT 0,\
             ext_int1 INT DEFAULT 0,\
             ext_int2 INT DEFAULT 0,\
             ext_int3 INT DEFAULT 0,\
             ext_int4 INT DEFAULT 0,\
             ext_str0 TEXT DEFAULT NULL,\
             ext_str1 TEXT DEFAULT NULL,\
             ext_str2 TEXT DEFAULT NULL,\
             ext_str3 TEXT DEFAULT NULL,\
             ext_str4 TEXT DEFAULT NULL)"])
            break;
        
        [fmdb_ commit];
        
        [self parseChinaCity];
        
        //all done
        return;
    } while (0);
    
    //error occurred
    //TODO
    DJLog(@"create table error:%@,可能因为数据库表结构发生改变,请先尝试删除数据库文件或者删除程序",[fmdb_ lastErrorMessage]);
    [fmdb_ rollback];
    @throw NSGenericException;
}

@end

@implementation CommunityDbManager

+ (CommunityDbManager *)sharedInstance
{
    static CommunityDbManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CommunityDbManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)initDbWithDelegate:(id<CommunityDbManagerInitProtocol>)delegate
{
    
    initDelegate_ = delegate;
    [self initDb];
}

- (BOOL)insertOrUpdateUserInfo:(UserInfo *)info
{
    //是否存在
    if ([self queryUserInfo:info.userId]) {
        return [fmdb_ executeUpdate:@"UPDATE "UserTableName" SET \
                password = ?,\
                gender = ?,\
                user_name = ?,\
                nick_name = ?,\
                birthday = ?,\
                create_time = ?,\
                update_time = ?,\
                picture_url = ?,\
                community_id = ?,\
                community_name = ?,\
                room_id = ?,\
                room_name = ?,\
                telephone = ?,\
                room_discount = ?,\
                parking_discount = ? \
                WHERE user_id = ?",
                info.password,
                [NSNumber numberWithInt:info.gender],
                info.userName,
                info.nickName,
                [NSNumber numberWithLongLong:info.birthday],
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.picture,
                [NSNumber numberWithLongLong:info.communityId],
                info.communityName,
                [NSNumber numberWithLongLong:info.roomId],
                info.roomName,
                info.telephone,
                [NSNumber numberWithDouble:info.roomDiscount],
                [NSNumber numberWithDouble:info.parkingDiscount],
                [NSNumber numberWithLongLong:info.userId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "UserTableName" (\
            user_id,\
            password,\
            gender,\
            user_name,\
            nick_name,\
            birthday,\
            create_time,\
            update_time,\
            picture_url,\
            community_id,\
            community_name,\
            room_id,\
            room_name,\
            telephone,\
            room_discount,\
            parking_discount) \
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.userId],
            info.password,
            [NSNumber numberWithInt:info.gender],
            info.userName,
            info.nickName,
            [NSNumber numberWithLongLong:info.birthday],
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.picture,
            [NSNumber numberWithLongLong:info.communityId],
            info.communityName,
            [NSNumber numberWithLongLong:info.roomId],
            info.roomName,
            info.telephone,
            [NSNumber numberWithDouble:info.roomDiscount],
            [NSNumber numberWithDouble:info.parkingDiscount]];
}

//增加城市
- (BOOL)insertOrUpdateCity:(HotCity *)info
{
    if ([self queryCity:info.cityId]) {
        return [fmdb_ executeUpdate:@"UPDATE "CityTableName" SET \
                city_name = ?,\
                update_time = ?,\
                type = ? \
                WHERE city_id = ?",
                info.name,
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.cityId]];
    }
    return [fmdb_ executeUpdate:
            @"INSERT INTO "CityTableName" (\
            city_id,\
            city_name,\
            update_time,\
            type) \
            VALUES (?,?,?,?)",
            [NSNumber numberWithLongLong:info.cityId],
            info.name,
            [NSNumber numberWithLongLong:info.updateTime],
            [NSNumber numberWithInt:info.type]];
}

//增加社区
- (BOOL)insertOrUpdateCommunity:(Community *)info
{
    if ([self queryCommunity:info.communityId]) {
        return [fmdb_ executeUpdate:@"UPDATE "CommunityTableName" SET \
                community_name = ?,\
                city_id = ?,\
                lon = ?,\
                lat = ?,\
                address = ?,\
                create_time = ?,\
                update_time = ?,\
                telephone = ?,\
                type = ? \
                WHERE community_id = ?",
                info.name,
                [NSNumber numberWithLongLong:info.cityId],
                [NSNumber numberWithDouble:info.lon],
                [NSNumber numberWithDouble:info.lat],
                info.address,
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.telephone,
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.communityId]];
    }
    return [fmdb_ executeUpdate:
            @"INSERT INTO "CommunityTableName" (\
            community_id,\
            community_name,\
            city_id,\
            lon,\
            lat,\
            address,\
            create_time,\
            update_time,\
            telephone,\
            type) \
            VALUES (?,?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.communityId],
            info.name,
            [NSNumber numberWithLongLong:info.cityId],
            [NSNumber numberWithDouble:info.lon],
            [NSNumber numberWithDouble:info.lat],
            info.address,
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.telephone,
            [NSNumber numberWithInt:info.type]];
}

//增加幢
- (BOOL)insertOrUpdateBuilding:(Building *)info
{
    if ([self queryCommunity:info.buildingId]) {
        return [fmdb_ executeUpdate:@"UPDATE "BuildingTableName" SET \
                building_name = ?,\
                community_id = ?,\
                update_time = ?,\
                type = ? \
                WHERE building_id = ?",
                info.name,
                [NSNumber numberWithLongLong:info.communityId],
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.buildingId]];
    }
    return [fmdb_ executeUpdate:
            @"INSERT INTO "BuildingTableName" (\
            building_id,\
            building_name,\
            community_id,\
            update_time,\
            type) \
            VALUES (?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.buildingId],
            info.name,
            [NSNumber numberWithLongLong:info.communityId],
            [NSNumber numberWithLongLong:info.updateTime],
            [NSNumber numberWithInt:info.type]];
}

//增加单元
- (BOOL)insertOrUpdateUnit:(Unit *)info
{
    if ([self queryCommunity:info.unitId]) {
        return [fmdb_ executeUpdate:@"UPDATE "UnitTableName" SET \
                unit_name = ?,\
                building_id = ?,\
                update_time = ?,\
                type = ? \
                WHERE unit_id = ?",
                info.name,
                [NSNumber numberWithLongLong:info.buildingId],
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.unitId]];
    }
    return [fmdb_ executeUpdate:
            @"INSERT INTO "UnitTableName" (\
            unit_id,\
            unit_name,\
            building_id,\
            update_time,\
            type) \
            VALUES (?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.unitId],
            info.name,
            [NSNumber numberWithLongLong:info.buildingId],
            [NSNumber numberWithLongLong:info.updateTime],
            [NSNumber numberWithInt:info.type]];
}

//增加房间
- (BOOL)insertOrUpdateRoom:(Room *)info
{
    if ([self queryCommunity:info.roomId]) {
        return [fmdb_ executeUpdate:@"UPDATE "RoomTableName" SET \
                room_name = ?,\
                unit_id = ?,\
                update_time = ?,\
                type = ? \
                WHERE room_id = ?",
                info.shortName,
                [NSNumber numberWithLongLong:info.unitId],
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.roomId]];
    }
    return [fmdb_ executeUpdate:
            @"INSERT INTO "RoomTableName" (\
            room_id,\
            room_name,\
            unit_id,\
            update_time,\
            type) \
            VALUES (?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.roomId],
            info.shortName,
            [NSNumber numberWithLongLong:info.unitId],
            [NSNumber numberWithLongLong:info.updateTime],
            [NSNumber numberWithInt:info.type]];
}

//增加用户房间
- (BOOL)insertOrUpdateUserRoom:(UserRoom *)info
{
    return YES;
}

//增加通知
- (BOOL)insertOrUpdateNotice:(NoticeInfo *)info
{
    //是否存在
    if ([self queryNotice:info.noticeId]) {
   //     NSLog(@"%@",info);
        return [fmdb_ executeUpdate:@"UPDATE "NoticeTableName" SET \
                community_id = ?,\
                create_time = ?,\
                update_time = ?,\
                title = ?,\
                summary = ?,\
                content = ?,\
                picture = ?,\
                notice_type = ?,\
                type = ? \
                WHERE notice_id = ?",
                [NSNumber numberWithLongLong:info.communityId],
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.title,
                info.summary,
                info.content,
                info.picture,
                [NSNumber numberWithInt:info.noticeType],
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.noticeId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "NoticeTableName" (\
            notice_id,\
            community_id,\
            create_time,\
            update_time,\
            title,\
            summary,\
            content,\
            picture,\
            notice_type,\
            type) \
            VALUES (?,?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.noticeId],
            [NSNumber numberWithLongLong:info.communityId],
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.title,
            info.summary,
            info.content,
            info.picture,
            [NSNumber numberWithInt:info.noticeType],
            [NSNumber numberWithInt:info.type]];
}

//增加财务报告
- (BOOL)insertOrUpdateFinanceReport:(FinanceReportInfo *)info
{
    //是否存在
    if ([self queryFinanceReport:info.reportId]) {
        return [fmdb_ executeUpdate:@"UPDATE "FinanceReportTableName" SET \
                str_id = ?,\
                community_id = ?,\
                create_time = ?,\
                update_time = ?,\
                title = ?,\
                income = ?,\
                outcome = ?,\
                publish_time = ?,\
                type = ?,\
                WHERE report_id = ?",
                info.strId,
                [NSNumber numberWithLongLong:info.communityId],
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.title,
                info.income,
                info.outcome,
                info.publishTime,
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.reportId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "FinanceReportTableName" (\
            report_id,\
            str_id,\
            community_id,\
            create_time,\
            update_time,\
            title,\
            income,\
            outcome,\
            publish_time,\
            type) \
            VALUES (?,?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.reportId],
            info.strId,
            [NSNumber numberWithLongLong:info.communityId],
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.title,
            info.income,
            info.outcome,
            info.publishTime,
            [NSNumber numberWithInt:info.type]];
}

//增加工作报告
- (BOOL)insertOrUpdateWorkReport:(WorkReportInfo *)info
{
    //是否存在
    if ([self queryWorkReport:info.reportId]) {
        return [fmdb_ executeUpdate:@"UPDATE "WorkReportTableName" SET \
                community_id = ?,\
                create_time = ?,\
                update_time = ?,\
                title = ?,\
                publish_time = ?,\
                html = ?,\
                type = ?,\
                WHERE report_id = ?",
                [NSNumber numberWithLongLong:info.communityId],
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.title,
                info.publishTime,
                info.html,
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.reportId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "WorkReportTableName" (\
            report_id,\
            community_id,\
            create_time,\
            update_time,\
            title,\
            publish_time,\
            html,\
            type) \
            VALUES (?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.reportId],
            [NSNumber numberWithLongLong:info.communityId],
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.title,
            info.publishTime,
            info.html,
            [NSNumber numberWithInt:info.type]];
}

//增加黄页
- (BOOL)insertOrUpdateYellowPage:(YellowPageInfo *)info
{
    //是否存在
    if ([self queryYellowPage:info.noticeId]) {
        return [fmdb_ executeUpdate:@"UPDATE "YellowPageTableName" SET \
                str_id = ?,\
                city_id = ?,\
                community_id = ?,\
                lon = ?,\
                lat = ?,\
                create_time = ?,\
                update_time = ?,\
                name = ?,\
                content = ?,\
                content2 = ?,\
                address = ?,\
                telephone = ?,\
                service_time = ?,\
                page_type = ?,\
                station = ?,\
                type = ? \
                WHERE notice_id = ?",
                info.strId,
                [NSNumber numberWithLongLong:info.cityId],
                [NSNumber numberWithLongLong:info.communityId],
                [NSNumber numberWithDouble:info.lon],
                [NSNumber numberWithDouble:info.lat],
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.name,
                info.content,
                info.content2,
                info.address,
                info.telephone,
                info.serviceTime,
                [NSNumber numberWithInt:info.pageType],
                info.station,
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.noticeId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "YellowPageTableName" (\
            notice_id,\
            str_id,\
            city_id,\
            community_id,\
            lon,\
            lat,\
            create_time,\
            update_time,\
            name,\
            content,\
            content2,\
            address,\
            telephone,\
            service_time,\
            page_type,\
            station,\
            type) \
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.noticeId],
            info.strId,
            [NSNumber numberWithLongLong:info.cityId],
            [NSNumber numberWithLongLong:info.communityId],
            [NSNumber numberWithDouble:info.lon],
            [NSNumber numberWithDouble:info.lat],
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.name,
            info.content,
            info.content2,
            info.address,
            info.telephone,
            info.serviceTime,
            [NSNumber numberWithInt:info.pageType],
            info.station,
            [NSNumber numberWithInt:info.type]];
}

//增加商户
- (BOOL)insertOrUpdateShop:(ShopInfo *)info
{
    //是否存在
    if ([self queryShop:info.shopId]) {
        return [fmdb_ executeUpdate:@"UPDATE "ShopTableName" SET \
                str_id = ?,\
                community_id = ?,\
                lon = ?,\
                lat = ?,\
                create_time = ?,\
                update_time = ?,\
                shop_name = ?,\
                address = ?,\
                telephone = ?,\
                logo = ?,\
                content = ?,\
                type = ? \
                WHERE shop_id = ?",
                info.strId,
                [NSNumber numberWithLongLong:info.communityId],
                [NSNumber numberWithDouble:info.lon],
                [NSNumber numberWithDouble:info.lat],
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.shopName,
                info.address,
                info.telephone,
                info.logo,
                info.content,
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.shopId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "ShopTableName" (\
            shop_id,\
            str_id,\
            community_id,\
            lon,\
            lat,\
            create_time,\
            update_time,\
            shop_name,\
            address,\
            telephone,\
            logo,\
            content,\
            type) \
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.shopId],
            info.strId,
            [NSNumber numberWithLongLong:info.communityId],
            [NSNumber numberWithDouble:info.lon],
            [NSNumber numberWithDouble:info.lat],
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.shopName,
            info.address,
            info.telephone,
            info.logo,
            info.content,
            [NSNumber numberWithInt:info.type]];
}

//增加社区活动
- (BOOL)insertOrUpdateActivity:(ActivityInfo *)info
{
    //是否存在
    if ([self queryNotice:info.activityId]) {
        return [fmdb_ executeUpdate:@"UPDATE "ActivityTableName" SET \
                community_id = ?,\
                create_time = ?,\
                update_time = ?,\
                title = ?,\
                summary = ?,\
                content = ?,\
                picture = ?,\
                type = ? \
                WHERE activity_id = ?",
                [NSNumber numberWithLongLong:info.communityId],
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                info.title,
                info.summary,
                info.content,
                info.picture,
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.activityId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "ActivityTableName" (\
            activity_id,\
            community_id,\
            create_time,\
            update_time,\
            title,\
            summary,\
            content,\
            picture,\
            type) \
            VALUES (?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.activityId],
            [NSNumber numberWithLongLong:info.communityId],
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            info.title,
            info.summary,
            info.content,
            info.picture,
            [NSNumber numberWithInt:info.type]];
}

- (BOOL)insertOrUpdatePayLog:(PayLogInfo *)info
{
    //是否存在
    if ([self queryPayLog:info.payId]) {
        return [fmdb_ executeUpdate:@"UPDATE "PayLogTableName" SET \
                community_id = ?,\
                community_name = ?,\
                create_time = ?,\
                update_time = ?,\
                trade_status = ?,\
                pay_method = ?,\
                start_month = ?,\
                month = ?,\
                product_type = ?,\
                product_id = ?,\
                product_name = ?,\
                pay = ? \
                WHERE pay_id = ?",
                [NSNumber numberWithLongLong:info.communityId],
                info.communityName,
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithInt:info.tradeStatus],
                [NSNumber numberWithInt:info.payMethod],
                [NSNumber numberWithInt:info.startMonth],
                [NSNumber numberWithInt:info.month],
                [NSNumber numberWithInt:info.productType],
                [NSNumber numberWithLongLong:info.productId],
                info.productName,
                [NSNumber numberWithLongLong:info.pay],
                [NSNumber numberWithLongLong:info.payId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "PayLogTableName" (\
            pay_id,\
            community_id,\
            community_name,\
            create_time,\
            update_time,\
            trade_status,\
            pay_method,\
            start_month,\
            month,\
            product_type,\
            product_id,\
            product_name,\
            pay) \
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.payId],
            [NSNumber numberWithLongLong:info.communityId],
            info.communityName,
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            [NSNumber numberWithInt:info.tradeStatus],
            [NSNumber numberWithInt:info.payMethod],
            [NSNumber numberWithInt:info.startMonth],
            [NSNumber numberWithInt:info.month],
            [NSNumber numberWithInt:info.productType],
            [NSNumber numberWithLongLong:info.productId],
            info.productName,
            [NSNumber numberWithLongLong:info.pay]];
}

//增加中国城市记录
- (BOOL)insertOrUpdateChinaCity:(ChinaCityInfo *)info
{
    return [fmdb_ executeUpdate:
            @"INSERT INTO "ChinaCityTableName" (\
            city_id,\
            parent_id,\
            city_name,\
            city_short_name,\
            deep) \
            VALUES (?,?,?,?,?)",
            info.cityId,
            info.parent_id,
            info.name,
            info.short_name,
            info.deep];
}

- (BOOL)insertOrUpdateAd:(AdInfo *)info
{
    //是否存在
    if ([self queryAd:info.adId]) {
        return [fmdb_ executeUpdate:@"UPDATE "AdTableName" SET \
                city_id = ?,\
                community_id = ?,\
                title = ?,\
                content = ?,\
                picture = ?,\
                update_time = ?,\
                type = ? \
                WHERE ad_id = ?",
                [NSNumber numberWithLongLong:info.cityId],
                [NSNumber numberWithLongLong:info.communityId],
                info.title,
                info.content,
                info.picture,
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithLongLong:info.adId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "AdTableName" (\
            ad_id,\
            city_id,\
            community_id,\
            title,\
            content,\
            picture,\
            update_time,\
            type) \
            VALUES (?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.adId],
            [NSNumber numberWithLongLong:info.cityId],
            [NSNumber numberWithLongLong:info.communityId],
            info.title,
            info.content,
            info.picture,
            [NSNumber numberWithLongLong:info.updateTime],
            [NSNumber numberWithInt:info.type]];
}

- (BOOL)insertOrUpdateParking:(ParkingInfo *)info
{
    //是否存在
    if ([self queryParking:info.parkingId]) {
        return [fmdb_ executeUpdate:@"UPDATE "ParkingTableName" SET \
                community_id = ?,\
                name = ?,\
                community_name = ?,\
                fee = ?,\
                last_fee = ?,\
                type = ?,\
                parking_discount = ?,\
                update_time = ? \
                WHERE parking_id = ?",
                [NSNumber numberWithLongLong:info.communityId],
                info.name,
                info.communityName,
                [NSNumber numberWithDouble:info.fee],
                [NSNumber numberWithInt:info.lastFee],
                [NSNumber numberWithInt:info.type],
                [NSNumber numberWithDouble:info.parkingDiscount],
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithLongLong:info.parkingId]];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "ParkingTableName" (\
            parking_id,\
            community_id,\
            name,\
            community_name,\
            fee,\
            last_fee,\
            type,\
            parking_discount,\
            update_time) \
            VALUES (?,?,?,?,?,?,?,?,?)",
            [NSNumber numberWithLongLong:info.parkingId],
            [NSNumber numberWithLongLong:info.communityId],
            info.name,
            info.communityName,
            [NSNumber numberWithDouble:info.fee],
            [NSNumber numberWithInt:info.lastFee],
            [NSNumber numberWithInt:info.type],
            [NSNumber numberWithDouble:info.parkingDiscount],
            [NSNumber numberWithLongLong:info.updateTime]];
}

//增加任务信息
- (BOOL)insertOrUpdateTask:(TaskInfo *)info
{
    //是否存在
    if ([self queryTask:info.taskId]) {
        return [fmdb_ executeUpdate:@"UPDATE "TaskTableName" SET \
                community_id = ?,\
                user_id = ?,\
                create_time = ?,\
                update_time = ?,\
                asign_time = ?,\
                picture_url = ?,\
                content = ?,\
                complainRepair_type = ?,\
                type = ?,\
                processor_name = ?,\
                user_name = ?,\
                user_telephone = ?,\
                processor_telephone = ?,\
                serial_number = ?,\
                processor_id = ?,\
                star = ?,\
                community_name = ?,\
                need_material = ?,\
                level = ?,\
                isComplain = ?,\
                processOrSupervise = ?,\
                roomFullName = ?,\
                isRead = ? \
                WHERE task_id = ?",
                info.communityId,
                info.userId,
                [NSNumber numberWithLongLong:info.createTime],
                [NSNumber numberWithLongLong:info.updateTime],
                [NSNumber numberWithLongLong:info.asignTime],
                info.picture,
                info.content,
                [NSNumber numberWithInt:info.complainRepairType],
                [NSNumber numberWithInt:info.type],
                info.processorName,
                info.userName,
                info.userTelephone,
                info.processorTelephone,
                info.serialNumber,
                info.processorId,
                [NSNumber numberWithInt:info.star],
                info.communityName,
                [NSNumber numberWithInt:info.needMaterial],
                [NSNumber numberWithInt:info.level],
                [NSNumber numberWithInt:info.isComplain],
                [NSNumber numberWithInt:info.processOrSupervise],
                info.roomFullName,
                [NSNumber numberWithInt:info.isRead],
                info.taskId];
    }
    
    return [fmdb_ executeUpdate:
            @"INSERT INTO "TaskTableName" (\
            task_id,\
            community_id,\
            user_id,\
            create_time,\
            update_time,\
            asign_time,\
            picture_url,\
            content,\
            complainRepair_type,\
            type,\
            processor_name,\
            user_name,\
            user_telephone,\
            processor_telephone,\
            serial_number,\
            processor_id,\
            star,\
            community_name,\
            need_material,\
            level,\
            isComplain,\
            processOrSupervise,\
            roomFullName,\
            isRead) \
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
            info.taskId,
            info.communityId,
            info.userId,
            [NSNumber numberWithLongLong:info.createTime],
            [NSNumber numberWithLongLong:info.updateTime],
            [NSNumber numberWithLongLong:info.asignTime],
            info.picture,
            info.content,
            [NSNumber numberWithInt:info.complainRepairType],
            [NSNumber numberWithInt:info.type],
            info.processorName,
            info.userName,
            info.userTelephone,
            info.processorTelephone,
            info.serialNumber,
            info.processorId,
            [NSNumber numberWithInt:info.star],
            info.communityName,
            [NSNumber numberWithInt:info.needMaterial],
            [NSNumber numberWithInt:info.level],
            [NSNumber numberWithInt:info.isComplain],
            [NSNumber numberWithInt:info.processOrSupervise],
            info.roomFullName,
            [NSNumber numberWithInt:info.isRead]];
}

- (UserInfo *)queryUserInfo:(long long)userId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "UserTableName" WHERE user_id = '%lld'", userId];
    
    UserInfo *info = [[UserInfo alloc] init];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        info.userId = userId;
        info.password = [result stringForColumn:@"password"];
        info.gender = [result intForColumn:@"gender"];
        info.userName = [result stringForColumn:@"user_name"];
        info.nickName = [result stringForColumn:@"nick_name"];
        info.birthday = [result longLongIntForColumn:@"birthday"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.picture = [result stringForColumn:@"picture_url"];
        info.communityId = [result longLongIntForColumn:@"community_id"];
        info.communityName = [result stringForColumn:@"community_name"];
        info.roomId = [result longLongIntForColumn:@"room_id"];
        info.roomName = [result stringForColumn:@"room_name"];
        info.telephone = [result stringForColumn:@"room_name"];
        info.roomDiscount = [result doubleForColumn:@"room_discount"];
        info.parkingDiscount = [result doubleForColumn:@"parking_discount"];
        return info;
    }
    return nil;
}

//查询是否有城市信息
- (BOOL)queryCity:(long long)cityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CityTableName" WHERE city_id = '%lld'", cityId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有社区信息
- (BOOL)queryCommunity:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE community_id = '%lld'", communityId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有幢信息
- (BOOL)queryBuilding:(long long)buildingId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "BuildingTableName" WHERE building_id = '%lld'", buildingId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有单元信息
- (BOOL)queryUnit:(long long)unitId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "UnitTableName" WHERE unit_id = '%lld'", unitId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有房间信息
- (BOOL)queryRoom:(long long)roomId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "RoomTableName" WHERE room_id = '%lld'", roomId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有通知信息
- (BOOL)queryNotice:(long long)noticeId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "NoticeTableName" WHERE notice_id = '%lld'", noticeId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有财务报告信息
- (BOOL)queryFinanceReport:(long long)reportId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "FinanceReportTableName" WHERE report_id = '%lld'", reportId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有财务报告信息
- (BOOL)queryWorkReport:(long long)reportId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "WorkReportTableName" WHERE report_id = '%lld'", reportId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有黄页信息
- (BOOL)queryYellowPage:(long long)noticeId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "YellowPageTableName" WHERE notice_id = '%lld'", noticeId];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有商户信息
- (BOOL)queryShop:(long long)shopId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ShopTableName" WHERE shop_id = '%lld'", shopId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有社区活动
- (BOOL)queryActivity:(long long)activityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ActivityTableName" WHERE activity_id = '%lld'", activityId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有缴费记录
- (BOOL)queryPayLog:(long long)payId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "PayLogTableName" WHERE pay_id = '%lld'", payId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有广告记录
- (BOOL)queryAd:(long long)adId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "AdTableName" WHERE ad_id = '%lld'", adId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有车位记录
- (BOOL)queryParking:(long long)parkingId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ParkingTableName" WHERE parking_id = '%lld'", parkingId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//查询是否有任务记录
- (BOOL)queryTask:(NSString *)taskId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "TaskTableName" WHERE task_id = '%@'", taskId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

//获取城市
- (NSArray *)queryCities
{
    NSString *sql = @"SELECT * FROM "CityTableName" WHERE type = 1";
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        HotCity *info = [[HotCity alloc] init];
        info.cityId = [result longLongIntForColumn:@"city_id"];
        info.name = [result stringForColumn:@"city_name"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.type = [result intForColumn:@"type"];
        [array addObject:info];
    }
    return array;
}

//获取社区
- (NSArray *)queryCommunitys:(long long)cityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE city_id = '%lld' AND type = 1 AND community_name <> '%@'", cityId, @"test"];
    //    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE city_id = '%lld' AND type = 1", cityId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        Community *info = [[Community alloc] init];
        info.communityId = [result longLongIntForColumn:@"community_id"];
        info.name = [result stringForColumn:@"community_name"];
        info.cityId = cityId;
        info.address = [result stringForColumn:@"address"];
        info.lon = [result doubleForColumn:@"lon"];
        info.lat = [result doubleForColumn:@"lat"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.telephone = [result stringForColumn:@"telephone"];
        info.type = [result intForColumn:@"type"];
        [array addObject:info];
    }
    return array;
}
//获取社区new
- (NSArray *)queryCommunitysNew:(long long)cityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE city_id = '%lld' AND type = 1 AND community_name <> '%@'", cityId, @"test"];
    //    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE city_id = '%lld' AND type = 1", cityId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        Community *info = [[Community alloc] init];
        info.communityId = [result longLongIntForColumn:@"community_id"];
        info.name = [result stringForColumn:@"community_name"];
        info.cityId = cityId;
        info.address = [result stringForColumn:@"address"];
        info.lon = [result doubleForColumn:@"lon"];
        info.lat = [result doubleForColumn:@"lat"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.telephone = [result stringForColumn:@"telephone"];
        info.type = [result intForColumn:@"type"];
        [array addObject:info];
    }
    return array;
}



//获取幢
- (NSArray *)queryBuildings:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "BuildingTableName" WHERE community_id = '%lld' AND type = 1", communityId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        Building *info = [[Building alloc] init];
        info.buildingId = [result longLongIntForColumn:@"building_id"];
        info.name = [result stringForColumn:@"building_name"];
        info.communityId = communityId;
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.type = [result intForColumn:@"type"];
        [array addObject:info];
    }
    return array;
}

//获取单元
- (NSArray *)queryUnits:(long long)buildingId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "UnitTableName" WHERE building_id = '%lld' AND type = 1", buildingId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        Unit *info = [[Unit alloc] init];
        info.unitId = [result longLongIntForColumn:@"unit_id"];
        info.name = [result stringForColumn:@"unit_name"];
        info.buildingId = buildingId;
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.type = [result intForColumn:@"type"];
        [array addObject:info];
    }
    return array;
}

//获取房间
- (NSArray *)queryRooms:(long long)unitId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "RoomTableName" WHERE unit_id = '%lld' AND type = 1", unitId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        Room *info = [[Room alloc] init];
        info.roomId = [result longLongIntForColumn:@"room_id"];
        info.shortName = [result stringForColumn:@"room_name"];
        info.unitId = unitId;
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.type = [result intForColumn:@"type"];
        [array addObject:info];
    }
    return array;
}

//获取用户房间
- (NSArray *)queryUserRooms:(long long)userId
{
    //    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "MyCommunityTableName" WHERE user_id = '%lld' AND type = 1", userId];
    //
    //    NSMutableArray *array = [NSMutableArray new];
    //    FMResultSet* result = [fmdb_ executeQuery:sql];
    //    while ([result next]) {
    //        UserRoom *info = [[UserRoom alloc] init];
    //        info.roomId = [result longLongIntForColumn:@"room_id"];
    //        info.roomName = [result stringForColumn:@"room_name"];
    //        info.communityId = [result longLongIntForColumn:@"community_id"];
    //        info.communityName = [result stringForColumn:@"community_name"];
    //        info.updateTime = [result longLongIntForColumn:@"update_time"];
    //        info.type = [result intForColumn:@"type"];
    //        [array addObject:info];
    //    }
    //    return array;
    return nil;
}

//获取通知
- (NSArray *)queryNotices:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "NoticeTableName" WHERE community_id = '%lld' AND type = '1' ORDER BY update_time DESC", communityId];
//    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "NoticeTableName" WHERE type=1 ORDER BY update_time DESC"];

    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        NoticeInfo *info = [[NoticeInfo alloc] init];
        info.noticeId = [result longLongIntForColumn:@"notice_id"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.communityId = communityId;
        info.title = [result stringForColumn:@"title"];
        info.summary = [result stringForColumn:@"summary"];
        info.content = [result stringForColumn:@"content"];
        info.picture = [result stringForColumn:@"picture"];
        info.noticeType = [result intForColumn:@"notice_type"];
        [array addObject:info];
    }
    //数据库中只保存最新20条数据
    if (array.count > HttpRequestCount) {
        NoticeInfo *info = array[HttpRequestCount - 1];
        [self deleteNotices:info.updateTime];
    }
    return array;
}

//获取财务报告
- (NSArray *)queryFinanceReports:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "FinanceReportTableName" WHERE community_id = '%lld' AND type = 1 ORDER BY update_time DESC", communityId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        FinanceReportInfo *info = [[FinanceReportInfo alloc] init];
        info.reportId = [result longLongIntForColumn:@"report_id"];
        info.strId = [result stringForColumn:@"str_id"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.communityId = communityId;
        info.title = [result stringForColumn:@"title"];
        info.income = [result stringForColumn:@"income"];
        info.outcome = [result stringForColumn:@"outcome"];
        info.publishTime = [result stringForColumn:@"publish_time"];
        [array addObject:info];
    }
    //数据库中只保存最新20条数据
    if (array.count > HttpRequestCount) {
        FinanceReportInfo *info = array[HttpRequestCount - 1];
        [self deleteFinanceReports:info.updateTime];
    }
    return array;
}

//获取工作报告
- (NSArray *)queryWorkReports:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "WorkReportTableName" WHERE community_id = '%lld' AND type = 1 ORDER BY update_time DESC", communityId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        WorkReportInfo *info = [[WorkReportInfo alloc] init];
        info.reportId = [result longLongIntForColumn:@"report_id"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.communityId = communityId;
        info.title = [result stringForColumn:@"title"];
        info.publishTime = [result stringForColumn:@"publish_time"];
        info.html = [result stringForColumn:@"html"];
        [array addObject:info];
    }
    //数据库中只保存最新20条数据
    if (array.count > HttpRequestCount) {
        WorkReportInfo *info = array[HttpRequestCount - 1];
        [self deleteWorkReports:info.updateTime];
    }
    return array;
}

//根据黄页类型获取黄页
- (NSArray *)queryYellowPages:(long long)communityId pageType:(int)pageType
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "YellowPageTableName" WHERE community_id = '%lld' AND page_type = '%d' AND type = 1 ORDER BY update_time DESC", communityId, pageType];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        YellowPageInfo *info = [[YellowPageInfo alloc] init];
        info.noticeId = [result longLongIntForColumn:@"notice_id"];
        info.strId = [result stringForColumn:@"str_id"];
        info.cityId = [result longLongIntForColumn:@"city_id"];
        info.communityId = communityId;
        info.lon = [result doubleForColumn:@"lon"];
        info.lat = [result doubleForColumn:@"lat"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.name = [result stringForColumn:@"name"];
        info.address = [result stringForColumn:@"address"];
        info.telephone = [result stringForColumn:@"telephone"];
        info.serviceTime = [result stringForColumn:@"service_time"];
        info.content = [result stringForColumn:@"content"];
        info.content2 = [result stringForColumn:@"content2"];
        info.pageType = pageType;
        info.station = [result stringForColumn:@"station"];
        [array addObject:info];
    }
    //数据库中只保存最新20条数据
    if (array.count > HttpRequestCount) {
        YellowPageInfo *info = array[HttpRequestCount - 1];
        [self deleteYellowPages:info.updateTime];
    }
    return array;
}

//获取商户
- (NSArray *)queryShops:(long long)communityId type:(int)type
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ShopTableName" WHERE community_id = '%lld' AND type = '%d' ORDER BY update_time DESC", communityId, type];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        ShopInfo *info = [[ShopInfo alloc] init];
        info.shopId = [result longLongIntForColumn:@"shop_id"];
        info.strId = [result stringForColumn:@"str_id"];
        info.lon = [result doubleForColumn:@"lon"];
        info.lat = [result doubleForColumn:@"lat"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.communityId = communityId;
        info.shopName = [result stringForColumn:@"shop_name"];
        info.address = [result stringForColumn:@"address"];
        info.telephone = [result stringForColumn:@"telephone"];
        info.logo = [result stringForColumn:@"logo"];
        info.content = [result stringForColumn:@"content"];
        info.statueType=[[result stringForColumn:@"type"]intValue];
        NSLog(@"statue==%d",info.statueType);
        info.type = type;
        [array addObject:info];
    }
    //数据库中只保存最新20条数据
    if (array.count > HttpRequestCount) {
        ShopInfo *info = array[HttpRequestCount - 1];
        [self deleteShops:info.updateTime];
    }
    return array;
}

//获取社区通知
- (NSArray *)queryActivities:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ActivityTableName" WHERE community_id = '%lld' AND type = '1' ORDER BY update_time DESC", communityId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        ActivityInfo *info = [[ActivityInfo alloc] init];
        info.activityId = [result longLongIntForColumn:@"activity_id"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.communityId = communityId;
        info.title = [result stringForColumn:@"title"];
        info.summary = [result stringForColumn:@"summary"];
        info.content = [result stringForColumn:@"content"];
        info.picture = [result stringForColumn:@"picture"];
        [array addObject:info];
    }
    //数据库中只保存最新20条数据
    if (array.count > HttpRequestCount) {
        ActivityInfo *info = array[HttpRequestCount - 1];
        [self deleteActivities:info.updateTime];
    }
    return array;
}

//获取缴费记录
- (NSArray *)queryPayLogs
{
    NSString *sql = @"SELECT * FROM "PayLogTableName" ORDER BY update_time DESC";
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        PayLogInfo *info = [[PayLogInfo alloc] init];
        info.payId = [result longLongIntForColumn:@"pay_id"];
        info.communityId = [result longLongIntForColumn:@"community_id"];;
        info.communityName = [result stringForColumn:@"community_name"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.tradeStatus = [result intForColumn:@"trade_status"];
        info.payMethod = [result intForColumn:@"pay_method"];
        info.startMonth = [result intForColumn:@"start_month"];
        info.month = [result intForColumn:@"month"];
        info.productType = [result intForColumn:@"product_type"];
        info.productId = [result longLongIntForColumn:@"product_id"];
        info.productName = [result stringForColumn:@"product_name"];
        info.pay = [result longLongIntForColumn:@"pay"];
        [array addObject:info];
    }
    return array;
}

//获取广告记录
- (NSArray *)queryAds:(long long)communityId type:(int)type
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "AdTableName" WHERE community_id = '%lld' AND type = '%d' ORDER BY update_time DESC", communityId, type];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        AdInfo *info = [[AdInfo alloc] init];
        info.adId = [result longLongIntForColumn:@"ad_id"];
        info.communityId = communityId;
        info.cityId = [result longLongIntForColumn:@"city_id"];
        info.title = [result stringForColumn:@"title"];
        info.content = [result stringForColumn:@"content"];
        info.picture = [result stringForColumn:@"picture"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.type = [result intForColumn:@"type"];
        [array addObject:info];
    }
    return array;
}

//获取车位记录
- (NSArray *)queryParkings:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ParkingTableName" WHERE community_id = '%lld' AND type = 1 ORDER BY update_time DESC", communityId];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        ParkingInfo *info = [[ParkingInfo alloc] init];
        info.parkingId = [result longLongIntForColumn:@"parking_id"];
        info.communityId = communityId;
        info.name = [result stringForColumn:@"name"];
        info.communityName = [result stringForColumn:@"community_name"];
        info.fee = [result doubleForColumn:@"fee"];
        info.lastFee = [result intForColumn:@"last_fee"];
        info.type = [result intForColumn:@"type"];
        info.parkingDiscount = [result doubleForColumn:@"parking_discount"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        [array addObject:info];
    }
    return array;
}

//获取车位记录
- (NSArray *)queryTasks
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "TaskTableName" ORDER BY create_time DESC"];
    
    NSMutableArray *array = [NSMutableArray new];
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        TaskInfo *info = [[TaskInfo alloc] init];
        info.taskId = [result stringForColumn:@"task_id"];
        info.communityId = [result stringForColumn:@"community_id"];
        info.userId = [result stringForColumn:@"user_id"];
        info.createTime = [result longLongIntForColumn:@"create_time"];
        info.updateTime = [result longLongIntForColumn:@"update_time"];
        info.asignTime = [result longLongIntForColumn:@"asign_time"];
        info.picture = [result stringForColumn:@"picture_url"];
        info.content = [result stringForColumn:@"content"];
        info.complainRepairType = [result intForColumn:@"complainRepair_type"];
        info.type = [result intForColumn:@"type"];
        info.processorName = [result stringForColumn:@"processor_name"];
        info.userName = [result stringForColumn:@"user_name"];
        info.userTelephone = [result stringForColumn:@"user_telephone"];
        info.processorTelephone = [result stringForColumn:@"processor_telephone"];
        info.serialNumber = [result stringForColumn:@"serial_number"];
        info.processorId = [result stringForColumn:@"processor_id"];
        info.star = [result intForColumn:@"star"];
        info.communityName = [result stringForColumn:@"community_name"];
        info.needMaterial = [result intForColumn:@"need_material"];
        info.level = [result intForColumn:@"level"];
        info.isComplain = [result intForColumn:@"isComplain"];
        info.processOrSupervise = [result intForColumn:@"processOrSupervise"];
        info.roomFullName = [result stringForColumn:@"roomFullName"];
        info.isRead = [result intForColumn:@"isRead"];
        [array addObject:info];
    }
    return array;
}

//获取社区的电话号码
- (NSString *)queryTelephone:(long long)communityId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE community_id = '%lld'", communityId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result stringForColumn:@"telephone"];
    }
    return @"";
}

//查询中国城市
- (ChinaCityInfo *)queryChinaCity:(NSString *)cityId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM "ChinaCityTableName" WHERE city_id = '%@'", cityId];
    
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        ChinaCityInfo *info = [[ChinaCityInfo alloc] init];
        info.cityId = [result stringForColumn:@"city_id"];
        info.parent_id = [result stringForColumn:@"parent_id"];
        info.name = [result stringForColumn:@"city_name"];
        info.short_name = [result stringForColumn:@"city_short_name"];
        info.deep = [result stringForColumn:@"deep"];
        return info;
    }
    return nil;
}

//获取社区信息的最大和最小更新时间
- (long long)queryCitiesUpdateTimeMax:(BOOL)max
{
    NSString *sql;
    if (max) {
        sql = @"SELECT * FROM "CityTableName" ORDER BY update_time DESC";
    } else {
        sql = @"SELECT * FROM "CityTableName" ORDER BY update_time ASC";
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取社区信息的最大和最小更新时间
- (long long)queryCommunitysUpdateTimeMax:(BOOL)max cityId:(long long)cityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE city_id = '%lld' ORDER BY update_time DESC", cityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "CommunityTableName" WHERE city_id = '%lld' ORDER BY update_time ASC", cityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取幢信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryBuildingsUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "BuildingTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "BuildingTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取单元信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryUnitsUpdateTimeMax:(BOOL)max buildingId:(long long)buildingId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "UnitTableName" WHERE building_id = '%lld' ORDER BY update_time DESC", buildingId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "UnitTableName" WHERE building_id = '%lld' ORDER BY update_time ASC", buildingId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取房间信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryRoomsUpdateTimeMax:(BOOL)max unitId:(long long)unitId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "RoomTableName" WHERE unit_id = '%lld' ORDER BY update_time DESC", unitId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "RoomTableName" WHERE unit_id = '%lld' ORDER BY update_time ASC", unitId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取用户房间信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryUserRoomsUpdateTimeMax:(BOOL)max userId:(long long)userId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "MyCommunityTableName" WHERE user_id = '%lld' ORDER BY update_time DESC", userId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "MyCommunityTableName" WHERE user_id = '%lld' ORDER BY update_time ASC", userId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取通知信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryNoticesUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "NoticeTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "NoticeTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取财务报告信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryFinanceReportsUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "FinanceReportTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "FinanceReportTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取工作报告信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryWorkReportsUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "WorkReportTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "WorkReportTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取黄页信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryYellowPagesUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "YellowPageTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "YellowPageTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取商户信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryShopsUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ShopTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ShopTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取社区活动信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryActivitiesUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ActivityTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ActivityTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取缴费记录信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryPayLogsUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "PayLogTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "PayLogTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取广告信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryAdsUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "AdTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "AdTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取车位信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryParkingsUpdateTimeMax:(BOOL)max communityId:(long long)communityId
{
    NSString *sql;
    if (max) {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ParkingTableName" WHERE community_id = '%lld' ORDER BY update_time DESC", communityId];
    } else {
        sql = [[NSString alloc] initWithFormat:@"SELECT * FROM "ParkingTableName" WHERE community_id = '%lld' ORDER BY update_time ASC", communityId];
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

//获取任务历史记录信息的最大和最小更新时间 max == yes取最大值, 否则取最小值
- (long long)queryTasksUpdateTimeMax:(BOOL)max
{
    NSString *sql;
    if (max) {
        sql = @"SELECT * FROM "TaskTableName" ORDER BY update_time DESC";
    } else {
        sql = @"SELECT * FROM "TaskTableName" ORDER BY update_time ASC";
    }
    FMResultSet* result = [fmdb_ executeQuery:sql];
    while ([result next]) {
        return [result longLongIntForColumn:@"update_time"];
    }
    return 0;
}

- (BOOL)deleteNotices:(long long)updateTime
{
    return [fmdb_ executeUpdate:@"DELETE FROM "NoticeTableName" WHERE update_time < ?", [NSString stringWithFormat:@"%lld", updateTime]];
}

- (BOOL)deleteFinanceReports:(long long)updateTime
{
    return [fmdb_ executeUpdate:@"DELETE FROM "FinanceReportTableName" WHERE update_time < ?", [NSString stringWithFormat:@"%lld", updateTime]];
}

- (BOOL)deleteWorkReports:(long long)updateTime
{
    return [fmdb_ executeUpdate:@"DELETE FROM "WorkReportTableName" WHERE update_time < ?", [NSString stringWithFormat:@"%lld", updateTime]];
}

- (BOOL)deleteYellowPages:(long long)updateTime
{
    return [fmdb_ executeUpdate:@"DELETE FROM "YellowPageTableName" WHERE update_time < ?", [NSString stringWithFormat:@"%lld", updateTime]];
}

- (BOOL)deleteShops:(long long)updateTime
{
    return [fmdb_ executeUpdate:@"DELETE FROM "ShopTableName" WHERE update_time < ?", [NSString stringWithFormat:@"%lld", updateTime]];
}

- (BOOL)deleteActivities:(long long)updateTime
{
    return [fmdb_ executeUpdate:@"DELETE FROM "ActivityTableName" WHERE update_time < ?", [NSString stringWithFormat:@"%lld", updateTime]];
}

- (BOOL)deletePayLogs
{
    return [fmdb_ executeUpdate:@"DELETE FROM "PayLogTableName""];
}

- (BOOL)deleteParkingInfos
{
    return [fmdb_ executeUpdate:@"DELETE FROM "ParkingTableName""];
}

- (BOOL)deleteUserInfo:(long long)userId
{
    return [fmdb_ executeUpdate:@"DELETE FROM "UserTableName" WHERE user_id = (?) ",
            [NSString stringWithFormat:@"%lld", userId]];
}

- (BOOL)deleteTasks
{
    return [fmdb_ executeUpdate:@"DELETE FROM "TaskTableName""];
}

- (void)parseChinaCity
{
    NSString * cityPath =[[NSBundle mainBundle] pathForResource:@"city" ofType:@"xml"];
    NSData *citysData = [NSData dataWithContentsOfFile:cityPath];
    
    //解析xml文件内容
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:citysData];
    [parser setDelegate:self];
    [parser parse];
}

#pragma mark NSXMLParserDelegate method
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"city"]) {
        NSString *string = [attributeDict JSONString];
        ChinaCityInfo *city = [EzJsonParser deserializeFromJson:string asType:[ChinaCityInfo class]];
        [self insertOrUpdateChinaCity:city];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {}

//解析错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {}

//xml解析完成
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

@end