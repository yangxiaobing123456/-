//
//  TS_pingjiaViewController.h
//  Community
//
//  Created by HuaMen on 14-10-20.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "SevenSwitch.h"
#import "RatingView.h"

@interface TS_pingjiaViewController : CommunityViewController<RatingViewDelegate,UITextViewDelegate>
{
     UIScrollView *scrollView;
    SevenSwitch *intimeSwitch;
    SevenSwitch *attitudeSwitch;
    SevenSwitch *needMaterialSwitch;
    SevenSwitch *paySwitch;
    SevenSwitch *invoicedSwitch;
    SevenSwitch *visitedSwitch;
    SevenSwitch *isGetfeed;
    UIImageView *headimage;
    UILabel *nameLabel;
    UILabel *jibieLabel;
    UIImageView *jibieImage;
    
    UILabel *satisfactionLabel;
    RatingView *rateView;
    UITextView *contentView;
    NSString *str1;
     NSString *str2;
     NSString *str3;
     NSString *str4;
     NSString *str5;
     NSString *str6;
    NSString *str7;
    NSString *str8;
    
}
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic,assign)int isComPair;
@end
