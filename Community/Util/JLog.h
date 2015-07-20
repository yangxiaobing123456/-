//
//  JLog.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#ifndef DJDEBUG
#define DJDEBUG 1
#endif

#ifndef JLog
#define JLine(firstarg, ...) ([NSString stringWithFormat:@"\t(%08x.%04d)%s %@",(unsigned int)self,__LINE__,__FUNCTION__,[NSString stringWithFormat:firstarg, ##__VA_ARGS__ ]])
#define JLineC(firstarg, ...) ([NSString stringWithFormat:@"\t(%08x.%04d) %s %s(): %@",NULL,__LINE__,__FILE__,__FUNCTION__,[NSString stringWithFormat:firstarg , ##__VA_ARGS__ ]])

#define JLog(firstarg, ...) NSLog(@"%@",JLine(firstarg , ##__VA_ARGS__ ))
#define JLogC(firstarg, ...) NSLog(@"%@",JLineC(firstarg , ##__VA_ARGS__ ))

#define DJLog if(DJDEBUG)JLog
#define DJLogC if(DJDEBUG)JLogC

#define D2JLog if(DJDEBUG>1)JLog
#define D2JLogC if(DJDEBUG>1)JLogC

#define D3JLog if(DJDEBUG>2)JLog
#define D3JLogC if(DJDEBUG>2)JLogC 

#define DJLOG if(DJDEBUG)DJLog(@"");
#define D2JLOG if(DJDEBUG>1)DJLog(@"");
#define D3JLOG if(DJDEBUG>1)DJLog(@"");
#endif
