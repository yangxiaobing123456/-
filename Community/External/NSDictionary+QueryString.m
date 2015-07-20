//
//  NSDictionary+QueryString.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "NSDictionary+QueryString.h"

@implementation NSDictionary (QueryString)

+ (NSDictionary *)dictionaryWithFormEncodedString:(NSString *)encodedString
{
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    NSArray* pairs = [encodedString componentsSeparatedByString:@"&"];
    
    for (NSString* kvp in pairs) {
        if ([kvp length] == 0)
            continue;
        
        NSRange pos = [kvp rangeOfString:@"="];
        NSString *key;
        NSString *val;
        
        if (pos.location == NSNotFound) {
            key = [kvp encodedStringWithUTF8];
            val = @"";
        } else {
            key = [[kvp substringToIndex:pos.location] encodedStringWithUTF8];
            val = [[kvp substringFromIndex:pos.location + pos.length] encodedStringWithUTF8];
        }
        
        if (!key || !val)
            continue; // I'm sure this will bite my arse one day
        
        [result setObject:val forKey:key];
    }
    return result;
}

- (NSString *)stringWithFormEncodedComponents
{
    NSMutableArray* arguments = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSString* key in self) {
        [arguments addObject:[NSString stringWithFormat:@"%@=%@",
                              [key encodedStringWithUTF8],
                              [[[self objectForKey:key] description] encodedStringWithUTF8]]];
    }
    
    return [arguments componentsJoinedByString:@"&"];
}

@end
