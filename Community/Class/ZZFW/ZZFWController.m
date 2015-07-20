//
//  ZZFWController.m
//  Community
//
//  Created by SYZ on 13-12-7.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "ZZFWController.h"
#import "EzJsonParser.h"
#import "ZBYHController.h"
#import "SHHYController.h"

#define TopMargin            0
#define CellLeftMargin       0
#define CellHeight           57

//和ZZFW_List.txt对应
enum ZZFWItem
{
    ZBYH = 0,      //周边优惠
    HCP,           //火车票
    FJP,           //飞机票
    SJCZ,          //手机充值
    JDLY,          //酒店旅游
    SHHY,          //生活黄页
};

static UIImage *bgImage = nil;
static UIImage *arrowImage = nil;

@implementation ZZFWCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
//            bgImage = [UIImage imageNamed:@"cell_bg_red_114H"];
        }
        if (!arrowImage) {
            arrowImage = [UIImage imageNamed:@"arrow"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, 0.0f, kContentWidth - 2 * CellLeftMargin, CellHeight)];
        bgView.image = bgImage;
        bgView.backgroundColor=NewBackgroundColor;
        [self.contentView addSubview:bgView];
        
        float iconW = 23.0f, iconH = 23.0f;
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin + 30.0f, (CellHeight - iconH) / 2, iconW, iconH)];
        [self.contentView addSubview:iconView];
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(125.0f, (CellHeight - 20.0f) / 2, 80.0f, 20.0f)];
        itemLabel.textColor = [UIColor grayColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:itemLabel];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CellLeftMargin, 56.0f,kContentWidth - 2 * CellLeftMargin, 1.0)];
        line.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        float arrowW = 12.0f, arrowH = 15.0f;
        arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(kContentWidth - arrowW - 25.0f, (CellHeight - arrowH) / 2, arrowW, arrowH)];
        arrowView.image = arrowImage;
        [self.contentView addSubview:arrowView];
    }
    return self;
}

- (void)loadFunction:(NSDictionary *)dict
{
    iconView.image = [UIImage imageNamed:[dict valueForKey:@"imageName"]];
    itemLabel.text = [dict valueForKey:@"function"];
}

@end

@implementation ZZFWController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"增值服务";
	
    float headerViewH = 100.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, headerViewH + TopMargin)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, TopMargin, kContentWidth - 2 * CellLeftMargin, headerViewH)];
    headerbg.image = [UIImage imageNamed:@"bg_home_community"];
    [headerView addSubview:headerbg];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85.0f, (headerViewH - 20.0f) / 2 + TopMargin, 200.0f, 20.0f)];
//    titleLabel.text = @"我们全心全意为您服务!";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [headerView addSubview:titleLabel];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, kTabBarHeight + TopMargin)];
    
    CGRect rect = CGRectMake(0.0f, -10.0f, kContentWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:headerView];
    [tableView setTableFooterView:footerView];
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZZFW_List" ofType:@"txt"];
    functionArray = [EzJsonParser deserializeFromJson:[NSString stringWithContentsOfFile:path
                                                                                encoding:NSUTF8StringEncoding error:nil]
                                               asType:[NSArray class]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//是否登录
- (BOOL)didLogin
{
    if ([AppSetting userId] == ILLEGLE_USER_ID) {
        return NO;
    }
    return YES;
}

//判断是否完善信息
- (BOOL)didUpdatedUserInfo
{
    UserInfo *info = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    if ([info.roomName isEmptyOrBlank] || info.roomName == nil) {
        return NO;
    }
    return YES;
}

//进入完善个人信息页面
- (void)enterUpdateUserInfoView
{
    UpdateUserInfoController *controller = [[UpdateUserInfoController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return functionArray.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"item_cell";
    ZZFWCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ZZFWCell alloc] initWithStyle:UITableViewCellStyleValue1
                               reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [cell loadFunction:[functionArray objectAtIndex:indexPath.row]];
    
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
    
    if (![self didLogin]) {
        LoginController *controller = [[LoginController alloc] init];
        CommunityNavigationController *navController = [[CommunityNavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
        return;
    }
    if (![self didUpdatedUserInfo]) {
        [self enterUpdateUserInfoView];
        return;
    }
    
    NSDictionary *dict = [functionArray objectAtIndex:indexPath.row];
    int index = [[dict valueForKey:@"index"] intValue];
    
    switch (index) {
        case ZBYH: {
            ZBYHController *controller = [ZBYHController new];
            controller.title = [dict valueForKey:@"function"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case HCP: {
            WebViewController *controller = [[WebViewController alloc] initWithURL:[NSURL URLWithString:kTrainTicketURL] title:[dict valueForKey:@"function"]];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case FJP: {
            WebViewController *controller = [[WebViewController alloc] initWithURL:[NSURL URLWithString:kAirplaneTicketURL] title:[dict valueForKey:@"function"]];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case SJCZ: {
            WebViewController *controller = [[WebViewController alloc] initWithURL:[NSURL URLWithString:kMobileRechargeURL] title:[dict valueForKey:@"function"]];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
          
        case JDLY: {
            WebViewController *controller = [[WebViewController alloc] initWithURL:[NSURL URLWithString:kHotelURL] title:[dict valueForKey:@"function"]];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case SHHY: {
            SHHYController *controller = [SHHYController new];
            controller.title = [dict valueForKey:@"function"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
