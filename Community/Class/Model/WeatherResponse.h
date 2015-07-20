//
//  WeatherResponse.h
//  Community
//
//  Created by SYZ on 14-1-4.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherInfo.h"

@interface IntimeWeatherResponse : NSObject

@property (nonatomic, strong) IntimeWeatherInfo *weatherinfo;

@end
