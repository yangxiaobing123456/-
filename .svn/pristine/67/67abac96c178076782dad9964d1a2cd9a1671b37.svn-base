//
//  MapController.m
//  Community
//
//  Created by SYZ on 13-12-8.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "MapController.h"

@implementation MapController

- (id)initWithLat:(double)lat_ lon:(double)lon_
{
    self = [super init];
    if (self) {
        lat = lat_;
        lon = lon_;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"地图";
    [self customBackButton:self];
	
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, kNavContentHeight)];
    map.mapType = MKMapTypeStandard;
    [self.view addSubview:map];
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(lat,lon);
    if (!CLLocationCoordinate2DIsValid(coords)) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"经纬度错误,找不到位置"];
        return;
    }
    
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [map setRegion:[map regionThatFits:region] animated:YES];
    
    CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithCoordinate:coords];
    [map addAnnotation:annotation];
    
    if (_telephone && ![_telephone isEmptyOrBlank]) {
        UIButton *telephoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        telephoneButton.frame = CGRectMake((kContentWidth - 194.0f) / 2, kNavContentHeight - 65.0f, 194.0f, 45.0f);
        [telephoneButton setTitle:[@"联系电话: " stringByAppendingString:_telephone]
                         forState:UIControlStateNormal];
        [telephoneButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [telephoneButton setTitleColor:[UIColor blackColor]
                              forState:UIControlStateNormal];
        [telephoneButton setBackgroundImage:[UIImage imageNamed:@"phone_button"]
                                   forState:UIControlStateNormal];
        [telephoneButton addTarget:self
                            action:@selector(didPhoneButtonClick)
                  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:telephoneButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didPhoneButtonClick
{
    //NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //结束电话之后会进入联系人列表
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@", _telephone]; //而这个方法则打电话前先弹框,打完电话之后回到程序中
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

@end
