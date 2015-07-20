//
//  CheckUpdateResponse.h
//  Community
//
//  Created by SYZ on 14-3-10.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityBaseResponse.h"

@interface CheckUpdateResponse : CommunityBaseResponse

@property int latestVersion;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, strong) NSString *versionName;

@end
