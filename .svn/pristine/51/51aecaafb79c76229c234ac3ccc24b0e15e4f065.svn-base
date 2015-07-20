//
//  CommunityHomeController.h
//  Community
//
//  Created by SYZ on 13-11-17.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CommunityViewController.h"
#import "CommunityNavigationController.h"
#import "CommunityHomeCell.h"
#import "CityInfo.h"
#import "CommunityHomeControl.h"
#import "AdsView.h"
#import "TSBXController.h"
#import "WYJF_WYController.h"
#import "UserParkingController.h"
#import "SHHYController.h"
#import "SQHDController.h"
#import "XQTZController.h"
#import "ZBYHController.h"
#import "XQTZ_DetailController.h"
#import "FirstPageController.h"
#import "XLCycleScrollView.h"

@interface CommunityHomeController : CommunityViewController <NSXMLParserDelegate, MKMapViewDelegate,pushAdViewDelegate,AdsViewDelegate,XLCycleScrollViewDelegate,XLCycleScrollViewDatasource>
{
    UIScrollView *scrollView;
    HomeHeaderView *headerView;
    //MKMapView *map;
    //NSString *cityId;
    NSMutableArray *_AdData;
    NSObject *ob;
    
    UIImageView *welcomeImage;
    UILabel *welcomeLabel;
    
    CommunityHomeControl *control1;
    CommunityHomeControl *control2;
    CommunityHomeControl *control3;
    CommunityHomeControl *control4;
    XLCycleScrollView *xlCycleScroll;
    
    AdsView *adsView;
    AdInfo *adInfo;
    
    NoticeInfo *newestNotice;
    BOOL checkUpdate;
    BOOL checkIsFee;
}

@end
