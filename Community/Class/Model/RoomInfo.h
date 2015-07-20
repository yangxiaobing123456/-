//
//  RoomInfo.h
//  Community
//
//  Created by SYZ on 14-1-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomInfo : NSObject

@property long long roomId;
@property (nonatomic, strong) NSString *strId;
@property (nonatomic, strong) NSString *communityName;
@property (nonatomic, strong) NSString *buildingName;
@property (nonatomic, strong) NSString *unitName;
@property (nonatomic, strong) NSString *roomName;
@property double totalArea;
@property int propertyType;
@property int lastPropertyFee;
@property double unitPrice;
@property int type;
@property long long updateTime;
@property double roomDiscount;
@property long long paymentTypeId;
@property (nonatomic, strong) NSString *payName;

@end