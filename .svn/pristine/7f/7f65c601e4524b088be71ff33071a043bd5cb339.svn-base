//
//  NSString+UrlEncoding.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UrlEncoding)

//utf8 encoding by default
- (NSString *)encodedStringWithUTF8;

//utf8 encoding by default
- (NSString *)decodedStringWithUTF8;

@end

@interface NSString (OtherExtentions)

//返回完全形式的url(追加http://)
- (NSString *)completeUrl;

- (NSString *)trim;

- (NSString *)trimLeft;

- (NSString *)stringFromSHA256;

- (NSUInteger)indexOfString:(NSString *)str;

- (NSUInteger)lastIndexOfString:(NSString *)str;

- (BOOL)contains:(NSString*)str;
- (BOOL)containsCasInsensitive:(NSString*)str;

- (BOOL)isEqualToStringCaseInsensitive:(NSString *)aString;

- (BOOL)hasPrefixCaseInsensitive:(NSString*)prefix;
- (BOOL)hasSuffixCaseInsensitive:(NSString *)suffix;

- (BOOL)isEmptyOrBlank;

- (NSStringEncoding)convertToStringEncoding;

//中国大陆手机号
- (BOOL)isChinaPhoneNumber;

//----------版本号比较----------
//支持1.0.3、1.2.3.4等各种形式的相互比较
- (BOOL)isVersionLowerThan:(NSString*)version;
- (BOOL)isVersionLowerThanOrEqualsTo:(NSString*)version;
- (BOOL)isVersionEqualsTo:(NSString*)version;
- (BOOL)isVersionHigherThan:(NSString*)version;
- (BOOL)isVersionHigherThanOrEqualsTo:(NSString*)version;

//将字节数转化为用户友好的字符串表达
//例：10.25MB、3.05kB
+ (NSString *)readableStringWithBytes:(long long)bytes;

//毫秒时间转换为字符创
+ (NSString *)formatDateWithMillisecond:(long long)millisecond;
//毫秒时间转换为距离现在的天数
+ (NSString *)getPastDayWithMillisecond:(long long)millisecond;
//获得字符数
- (int)characterLength;

@end


//htmlencoding
//源码来自gtm
@interface NSString (HtmlEncoding)

/// Get a string where internal characters that need escaping for HTML are escaped
//
///  For example, '&' become '&amp;'. This will only cover characters from table
///  A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
///  which is what you want for a unicode encoded webpage. If you have a ascii
///  or non-encoded webpage, please use stringByEscapingAsciiHTML which will
///  encode all characters.
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByEscapingForHTML;

/// Get a string where internal characters that need escaping for HTML are escaped
//
///  For example, '&' become '&amp;'
///  All non-mapped characters (unicode that don't have a &keyword; mapping)
///  will be converted to the appropriate &#xxx; value. If your webpage is
///  unicode encoded (UTF16 or UTF8) use stringByEscapingHTML instead as it is
///  faster, and produces less bloated and more readable HTML (as long as you
///  are using a unicode compliant HTML reader).
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByEscapingForAsciiHTML;

/// Get a string where internal characters that are escaped for HTML are unescaped
//
///  For example, '&amp;' becomes '&'
///  Handles &#32; and &#x32; cases as well
///
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByUnescapingFromHTML;

@end