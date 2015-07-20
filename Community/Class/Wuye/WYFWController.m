//
//  WYFWController.m
//  Community
//
//  Created by SYZ on 13-11-26.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "WYFWController.h"
#import "SQHDController.h"
#import "TSBXController.h"
#import "XQTZController.h"
#import "GZBGController.h"
#import "WYJFController.h"
#import "CWBGController.h"

#define TopMargin            10
#define CellLeftMargin       0
#define CellHeight           57

//和WYFW_List.txt对应
enum WYFWItem
{
    TSBX = 0,      //投诉报修
    WYJF,          //物业缴费
    XQTZ,          //小区通知
    //隐藏1
//    GZBG,          //工作报告
//    CWBG,          //财务报告
//    SQHD,          //社区活动
};

static UIImage *bgImage = nil;
static UIImage *arrowImage = nil;

@implementation WYFWCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
//            bgImage = [UIImage imageNamed:@"cell_bg_green_114H"];
        }
        if (!arrowImage) {
            arrowImage = [UIImage imageNamed:@"arrow"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, 0.0f, kContentWidth - 2 * CellLeftMargin, CellHeight)];
//        bgView.image = bgImage;
        bgView.backgroundColor=NewBackgroundColor;
        [self.contentView addSubview:bgView];
        
        float iconW = 28.0f, iconH = 28.0f;
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin + 26.0f, (CellHeight - iconH) / 2, iconW, iconH)];
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

@implementation WYFWController

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
    
    self.title = @"物业服务";
	
    float headerViewH = 100.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, headerViewH )];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, 0, kContentWidth - 2 * CellLeftMargin, headerViewH)];
    headerbg.image = [UIImage imageNamed:@"bg_home_community"];
    [headerView addSubview:headerbg];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85.0f, (headerViewH - 20.0f) / 2 + TopMargin, 200.0f, 20.0f)];
    //titleLabel.text = @"我们全心全意为您服务!";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [headerView addSubview:titleLabel];
    
    //写一个空白的footerView,可以实现透过TabBar还能看到tableview的效果
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, kTabBarHeight + TopMargin)];
    CGRect rect = CGRectMake(0.0f, -10.0f, kContentWidth, 330+57);
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
   //如何读取到数据的？？？？
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WYFW_List" ofType:@"txt"];
    functionArray = [EzJsonParser deserializeFromJson:[NSString stringWithContentsOfFile:path
                                                                                encoding:NSUTF8StringEncoding error:nil]
                                               asType:[NSArray class]];
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"WYFWview" owner:self options:nil];
    WYFWview *myView = [array objectAtIndex:0];
    //xib坐标一定要和此处一致，不然控件不响应
    myView.frame = CGRectMake(0, 272, 320, 57);
    [tableView addSubview:myView];
    
    [myView.huodongBtn addTarget:self action:@selector(huodongBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
}
//为了屏蔽财务报告添加代码
- (void)huodongBtnClick
{
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

    SQHDController *controller = [SQHDController new];
    
    controller.title = @"社区活动";
    
    controller.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:controller animated:YES];
 
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //隐藏1
//    return functionArray.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"item_cell";
    WYFWCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[WYFWCell alloc] initWithStyle:UITableViewCellStyleValue1
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
        case TSBX: {
            TSBXController *controller = [TSBXController new];
            controller.title = [dict valueForKey:@"function"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case WYJF: {
            WYJFController *controller = [WYJFController new];
            controller.title = [dict valueForKey:@"function"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case XQTZ: {
            XQTZController *controller = [XQTZController new];
            controller.title = [dict valueForKey:@"function"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            //隐藏1
            
//        case GZBG: {
//            GZBGController *controller = [GZBGController new];
//            controller.title = [dict valueForKey:@"function"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
//            
//        case CWBG: {
//            CWBGController *controller = [CWBGController new];
//            controller.title = [dict valueForKey:@"function"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
//            
//        case SQHD: {
//            SQHDController *controller = [SQHDController new];
//            controller.title = [dict valueForKey:@"function"];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
            
        default:
            break;
    }
}

@end
