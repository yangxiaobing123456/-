//
//  SelectOptionController.m
//  Community
//
//  Created by SYZ on 14-1-3.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "SelectOptionController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           62

@implementation SelectOptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 260.0f, CellHeight)];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = [UIFont systemFontOfSize:16.0f];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:contentLabel];
        
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 2.0f)];
        dividerView.backgroundColor = [UIColor whiteColor];
        dividerView.alpha = 0.5f;
        [self.contentView addSubview:dividerView];
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    contentLabel.text = content;
}

@end

@implementation SelectOptionController

- (id)init
{
    self = [super init];
    if (self) {
        optionArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    CGRect rect = CGRectMake(LeftMargin, 0.0f, TableViewWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    
    UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 2.0f)];
    dividerView.backgroundColor = [UIColor whiteColor];
    dividerView.alpha = 0.5f;
    tableView.tableFooterView = dividerView;
    
    [self customBackButton:self];
    
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    if (_tag == CityTag) {
        self.title = @"选择城市";
        [self getCities];
    } else if (_tag == CommunityTag) {
        self.title = @"选择社区";
        [self getCommunitys];
    } else if (_tag == BuildingTag) {
        self.title = @"选择幢";
        [self getBuildings];
    } else if (_tag == UnitTag) {
        self.title = @"选择单元";
        [self getUnits];
    } else if (_tag == RoomTag) {
        self.title = @"选择房间";
        [self getRooms];
    } else if (_tag == 1000) {
        self.title = @"选择停车位";
        [self getParkings];
    }
}

- (void)reloadTableView
{
    [tableView reloadData];
    if (optionArray == nil || optionArray.count == 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                       message:[NSString stringWithFormat:@"暂无数据"]
                                                                       delegate:self
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                        [alert show];

        
    }
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [optionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"option_cell";
    SelectOptionCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SelectOptionCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (_tag == CityTag) {
        HotCity *c = [optionArray objectAtIndex:indexPath.row];
        ChinaCityInfo *info = [[CommunityDbManager sharedInstance] queryChinaCity:[NSString stringWithFormat:@"%lld", c.cityId]];
        cell.content = info.name;
    } else if (_tag == CommunityTag) {
        Community *c = [optionArray objectAtIndex:indexPath.row];
        cell.content = c.name;
    } else if (_tag == BuildingTag) {
        Building *b = [optionArray objectAtIndex:indexPath.row];
        cell.content = b.name;
    } else if (_tag == UnitTag) {
        Unit *u = [optionArray objectAtIndex:indexPath.row];
        cell.content = u.name;
    } else if (_tag == RoomTag) {
        Room *r = [optionArray objectAtIndex:indexPath.row];
        cell.content = r.shortName;
    } else if (_tag == 1000) {
        ParkingInfo *p = [optionArray objectAtIndex:indexPath.row];
        cell.content = p.name;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_tag == CityTag) {
        HotCity *c = [optionArray objectAtIndex:indexPath.row];
        ChinaCityInfo *info = [[CommunityDbManager sharedInstance] queryChinaCity:[NSString stringWithFormat:@"%lld", c.cityId]];
        c.name = info.name;
        [_delegate selectCity:c];
    } else if (_tag == CommunityTag) {
        Community *c = [optionArray objectAtIndex:indexPath.row];
        [_delegate selectCommunity:c];
    } else if (_tag == BuildingTag) {
        Building *b = [optionArray objectAtIndex:indexPath.row];
        [_delegate selectBuilding:b];
    } else if (_tag == UnitTag) {
        Unit *u = [optionArray objectAtIndex:indexPath.row];
        [_delegate selectUnit:u];
    } else if (_tag == RoomTag) {
        Room *r = [optionArray objectAtIndex:indexPath.row];
        [_delegate selectRoom:r];
    } else if (_tag == 1000) {
        [[CommunityIndicator sharedInstance] startLoading];
        
        ParkingInfo *p = [optionArray objectAtIndex:indexPath.row];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%lld", p.parkingId], @"id", nil];
        [[HttpClientManager sharedInstance] addUserParkingsWithDict:dict
                                                           complete:^(BOOL success, int result) {
                                                               [_delegate addedParking];
                                                               [self.navigationController popViewControllerAnimated:YES];
                                                               [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                           }];
    }
}

//获取城市
- (void)getCities
{
    [[CommunityIndicator sharedInstance] startLoading];
    //这里只取最新城市信息
    long long time = [[CommunityDbManager sharedInstance] queryCitiesUpdateTimeMax:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          @"1000", @"count", nil];
    [[HttpClientManager sharedInstance] getCitiesWithDict:dict
                                                 complete:^(BOOL success, int result) {
                                                     NSArray *array = [[CommunityDbManager sharedInstance] queryCities];
                                                     [optionArray addObjectsFromArray:array];
                                                     [self reloadTableView];
                                                     [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                 }];
}

//获取社区
- (void)getCommunitys
{
    [[CommunityIndicator sharedInstance] startLoading];
    //这里只取最新社区信息
    long long time = [[CommunityDbManager sharedInstance] queryCommunitysUpdateTimeMax:YES cityId:_parentId];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", _parentId], @"id",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          @"1000", @"count", nil];
    [[HttpClientManager sharedInstance] getCommunitysWithDict:dict
                                                     complete:^(BOOL success, int result) {
                                                         NSArray *array = [[CommunityDbManager sharedInstance] queryCommunitys:_parentId];
                                                         [optionArray addObjectsFromArray:array];
                                                         [self reloadTableView];
                                                         [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                     }];
}

//获取幢
- (void)getBuildings
{
    [[CommunityIndicator sharedInstance] startLoading];
    //这里只取最新幢信息
    long long time = [[CommunityDbManager sharedInstance] queryBuildingsUpdateTimeMax:YES communityId:_parentId];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", _parentId], @"id",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          @"1000", @"count", nil];
    [[HttpClientManager sharedInstance] getBuildingsWithDict:dict
                                                    complete:^(BOOL success, int result) {
                                                        NSArray *array = [[CommunityDbManager sharedInstance] queryBuildings:_parentId];
                                                        [optionArray addObjectsFromArray:array];
                                                        [self reloadTableView];
                                                        [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                    }];
}

//获取单元
- (void)getUnits
{
    [[CommunityIndicator sharedInstance] startLoading];
    //这里只取最新单元信息
    long long time = [[CommunityDbManager sharedInstance] queryUnitsUpdateTimeMax:YES buildingId:_parentId];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", _parentId], @"id",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          @"1000", @"count", nil];
    [[HttpClientManager sharedInstance] getUnitsWithDict:dict
                                                complete:^(BOOL success, int result) {
                                                    NSArray *array= [[CommunityDbManager sharedInstance] queryUnits:_parentId];
                                                    [optionArray addObjectsFromArray:array];
                                                    [self reloadTableView];
                                                    [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                }];
}

//获取房间
- (void)getRooms
{
    [[CommunityIndicator sharedInstance] startLoading];
    //这里只取最新房间信息
    long long time = [[CommunityDbManager sharedInstance] queryRoomsUpdateTimeMax:YES unitId:_parentId];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", _parentId], @"id",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          @"1000", @"count", nil];
    [[HttpClientManager sharedInstance] getRoomsWithDict:dict
                                                complete:^(BOOL success, int result) {
                                                    NSArray *array = [[CommunityDbManager sharedInstance] queryRooms:_parentId];
                                                    [optionArray addObjectsFromArray:array];
                                                    [self reloadTableView];
                                                    [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                }];
}

- (void)getParkings
{
    [[CommunityIndicator sharedInstance] startLoading];
    //获取停车位
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", [AppSetting communityId]], @"id",
                          [NSString stringWithFormat:@"%d", 0], @"before",
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%d", 5000], @"count", nil];
    
    [[HttpClientManager sharedInstance] getParkingsWithDict:dict
                                                   complete:^(BOOL success, int result, NSArray *array) {
                                                       for (ParkingInfo *park in array) {
                                                           if (park.type == 1) {
                                                               [optionArray addObject:park];
                                                           }
                                                       }
                                                       [self reloadTableView];
                                                       [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                   }];
}

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (buttonIndex == 1) {
        if (_tag == CityTag) {
            [self getCities];
        } else if (_tag == CommunityTag) {
            [self getCommunitys];
        } else if (_tag == BuildingTag) {
            [self getBuildings];
        } else if (_tag == UnitTag) {
            [self getUnits];
        } else if (_tag == RoomTag) {
            [self getRooms];
        } else if (_tag == 1000) {
            [self getParkings];
        }
    }
}

@end
