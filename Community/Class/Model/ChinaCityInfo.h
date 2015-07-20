//
//  ChinaCityInfo.h
//  Community
//
//  Created by SYZ on 14-3-1.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChinaCityInfo : NSObject

@property(nonatomic, strong) NSString *cityId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *short_name;
@property(nonatomic, strong) NSString *parent_id;
@property(nonatomic, strong) NSString *deep;

@end
