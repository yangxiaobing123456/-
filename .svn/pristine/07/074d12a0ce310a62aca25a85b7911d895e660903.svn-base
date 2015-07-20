//
//  EditCommunityView.h
//  Community
//
//  Created by SYZ on 13-12-2.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityInfo.h"

enum {
    ProvinceTag = 3,
    CityTag,
    CommunityTag,
    BuildingTag,
    UnitTag,
    RoomTag,
} EditCommunityViewTag;

@protocol EditCommunityViewDelegate <NSObject>

- (void)changeEditCommunityViewValue:(int)tag;

@end

@interface EditCommunityModel : NSObject

@property HotCity *city;
@property Community *community;
@property Building *building;
@property Unit *unit;
@property Room *room;

@end

@interface SelectControl : UIControl
{
    UIImageView *backgroundView;
    UILabel *content;
}

- (void)setImage:(UIImage *)image;

@end

@interface EditCommunityView : UIView
{
    SelectControl *cityControl;
    SelectControl *communityControl;
    SelectControl *buildingControl;
    SelectControl *unitControl;
    SelectControl *roomControl;
    UILabel *communityLabel;
}

@property (nonatomic, weak) id<EditCommunityViewDelegate> delegate;
@property (nonatomic, strong) EditCommunityModel *editCommunity;

- (void)reloadCommunityData;

@end
