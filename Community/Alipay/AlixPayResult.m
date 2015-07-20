//
//  AlixPayResult.m
//  SafepayInterface
//
//  Created by WenBi on 11-5-20.
//  Copyright 2011 Alipay. All rights reserved.
//

#import "AlixPayResult.h"
#import "JSON.h"

@interface AlixPayResult ()

- (void)setStatusCode:(int)code;
- (void)setStatusMessage:(NSString *)message;
- (void)setResultString:(NSString *)string;
- (void)setSignString:(NSString *)string;
- (void)setSignType:(NSString *)signType;

@end


@implementation AlixPayResult

@synthesize statusCode = _statusCode;
@synthesize statusMessage = _statusMessage;
@synthesize resultString = _resultString;
@synthesize signString = _signString;
@synthesize signType = _signType;

- (id)initWithString:(NSString *)string {
	
	if (self = [super init]) {
		
		self.statusCode = 0;
		self.statusMessage = @"未知错误。";
		
		SBJsonParser * parser = [[SBJsonParser alloc] init];
		NSDictionary * jsonQuery = [parser objectWithString:string];
        
		if (!jsonQuery) {
            [self parseFormStr:string];
        }
        else
        {
            do {
                
                NSDictionary * jsonMemo = [jsonQuery objectForKey:@"memo"];
                if (jsonMemo == nil) {
                    break;
                }
                
                self.statusCode = [[jsonMemo objectForKey:@"ResultStatus"] intValue];
                self.statusMessage = [jsonMemo objectForKey:@"memo"];
                if (self.statusCode != 9000) {
                    break;
                }
                
                NSString *resultString = [jsonMemo objectForKey:@"result"];
                
                //
                // 签名类型
                //
                NSRange range = [resultString rangeOfString:@"&sign_type=\""];
                if (range.location == NSNotFound) {
                    break;
                }
                self.resultString = [resultString substringToIndex:range.location];
                
                range.location += range.length;
                range.length = [resultString length] - range.location;
                NSRange range2 = [resultString rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:range];
                if (range2.location == NSNotFound) {
                    break;
                }
                range.length = range2.location - range.location;
                if (range.length <= 0) {
                    break;
                }
                self.signType = [resultString substringWithRange:range];
                
                //
                // 签名字符串
                //
                range.location = range2.location;
                range.length = [resultString length] - range.location;
                range = [resultString rangeOfString:@"sign=\"" options:NSCaseInsensitiveSearch range:range];
                if (range.location == NSNotFound) {
                    break;
                }
                range.location += range.length;
                range.length = [resultString length] - range.location;
                range2 = [resultString rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:range];
                if (range2.location == NSNotFound) {
                    break;
                }
                range.length = range2.location - range.location;
                if (range.length <= 0) {
                    break;
                }
                self.signString = [resultString substringWithRange:range];
                
            } while (0);
		}
	}
	
	return self;
}

- (NSString *)description {
	NSMutableString * description = [NSMutableString string];
	[description appendString:@"result = {\n"];
	[description appendFormat:@"\tstatusCode=%d\n", self.statusCode];
	[description appendFormat:@"\tstatusMessage=%@\n", self.statusMessage];
	[description appendFormat:@"\tsignType=%@\n", self.signType];
	[description appendFormat:@"\tsignString=%@\n", self.signString];
	[description appendString:@"}\n"];
	return description;
}

- (void)setSignType:(NSString *)signType {
	if (_signType != signType) {
        _signType = signType;
	}
}

- (void)setSignString:(NSString *)string {
	if (_signString != string) {
        _signString = string;
	}
}

- (void)setStatusCode:(int)code {
	_statusCode = code;
}

- (void)setStatusMessage:(NSString *)message {
	if (_statusMessage != message) {
        _statusMessage = message;
	}
}

- (void)setResultString:(NSString *)string {
	if (_resultString != string) {
        _resultString = string;
	}
}

- (void) parseFormStr:(NSString*)str
{
    NSString* resultString = str;

    NSMutableString* name = [[NSMutableString alloc] init];
    NSMutableString* resultStatus = [[NSMutableString alloc] init];
    NSMutableString* memo = [[NSMutableString alloc] init];
    NSMutableString* resultd = [[NSMutableString alloc] init];
    NSMutableString* temp = [[NSMutableString alloc] init];
    
    for (int i= 0; i<[resultString  length]; i++)
    {
        unichar tChar = [resultString characterAtIndex:i];
        switch (tChar)
        {
            case '=':
            {
                if (i<[resultString length]-1)
                {
                    unichar tChar2 = [resultString characterAtIndex:i+1];
                    
                    if (tChar2 == '{')
                    {
                        [name appendString:temp];
                        [temp setString:@""];
                        i+=1;
                        
                    }
                    else
                        [temp appendFormat:@"%C",tChar];
                    
                }
            }
                break;
            case '}':
            {
                if (i<[resultString length]-1)
                {
                    unichar tChar2 = [resultString characterAtIndex:i+1];
                    
                    if (tChar2 != ';')
                    {
                        [temp appendFormat:@"%C",tChar];
                        break;
                    }
                }
                
                i+=1;
                
                if ([name compare:@"resultStatus"] == 0)
                {
                    [resultStatus appendString:temp];
                }
                else if([name compare:@"memo"] == 0)
                {
                    [memo appendString:temp];
                }
                else if([name compare:@"result"] == 0)
                {
                    [resultd appendString:temp];
                }
                //save value
                [temp setString:@""];
                [name setString:@""];
            }
                break;
            default:
            {
                [temp appendFormat:@"%C",tChar];
            }
                break;
        }
    }
    
    do
    {
        NSRange range = [resultd rangeOfString:@"&sign_type=\""];
        if (range.location == NSNotFound) {
            break;
        }
        //self.resultString = [resultd substringToIndex:range.location];
        
        range.location += range.length;
        range.length = [resultd length] - range.location;
        NSRange range2 = [resultd rangeOfString:@"\"" options:NSCaseInsensitiveSearch range:range];
        if (range2.location == NSNotFound) {
            break;
        }
        range.length = range2.location - range.location;
        if (range.length <= 0) {
            break;
        }
        self.signType = [resultd substringWithRange:range];
        
        //
        // 签名字符串
        //
        range = [resultd rangeOfString:@"sign=\""];
        if (range.location == NSNotFound) {
            break;
        }
        range2.location = 0;
        range2.length = range.location-1;
        self.resultString = [resultd substringWithRange:range2];
        
        
        
        //
        // 签名类型
        //
        range2 = [resultd rangeOfString:@"&sign_type=\""];
        
        range = [resultd rangeOfString:@"&sign=\""];
        
        
        range.location += range.length;
        range.length = range2.location - range.location-1;
        
        self.signString = [resultd substringWithRange:range];
        
        
        break;
    } while (0);
    
    
    self.statusCode = [resultStatus intValue];
    self.statusMessage = memo;
    //
    //    NSLog(@"signString=%@",self.signString);
    //    NSLog(@"signType=%@",self.signType);
    //
    //
    //
    //    NSLog(@"resultStatus=%@",resultStatus);
    //    NSLog(@"memo=%@",memo);
}

@end