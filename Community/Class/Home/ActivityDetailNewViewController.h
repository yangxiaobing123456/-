//
//  ActivityDetailNewViewController.h
//  Community
//
//  Created by HuaMen on 15-2-1.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BottomBtnView.h"
//#import "TabarView.h"
#import "TabartwoView.h"
#import "FaBuActivityViewController.h"
@interface ActivityDetailNewViewController : UIViewController
{
    UILabel *contentLabel;
    float labelHeight;
    float viewFrameOrigin;
    BottomBtnView *bottomView;
    TabartwoView *tabarView;

    NSString *idString;
    NSString *flagString;
    NSString *shareFlagString;

    NSString *urlString;

}
@property(nonatomic,retain)NSString *idStr;

@property (strong, nonatomic) IBOutlet UIScrollView *myNewScrollview;

@end
