//
//  MapController.h
//  Community
//
//  Created by SYZ on 13-12-8.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "CustomAnnotation.h"

@interface MapController : CommunityViewController
{
    MKMapView *map;
    double lat;
    double lon;
}

@property (nonatomic, strong) NSString *telephone;

- (id)initWithLat:(double)lat_ lon:(double)lon_;
   
@end
