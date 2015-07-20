//
//  CommunityMoreController.m
//  Community
//
//  Created by SYZ on 13-12-20.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityMoreController.h"
#import "communityNewTableViewCell.h"
#import "helpExplainViewController.h"

#define LeftMargin           0
#define TableViewWidth       320

#define MoreCellHeight       41

static UIImage *bgImage = nil;
static UIImage *arrowImage = nil;

@implementation CommunityMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
//            bgImage = [UIImage imageNamed:@"more_cell_bg"];
        }
        if (!arrowImage) {
            arrowImage = [UIImage imageNamed:@"celllsit2"];
        }
    }
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 39.0f)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    float iconW = 23.0f, iconH = 23.0f;
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(8 + 10.0f, (MoreCellHeight - iconH) / 2, iconW, iconH)];
    [self.contentView addSubview:iconView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 0.0f, 120.0f, 40.0f)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:titleLabel];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 40.0f, 320, 0.5)];
    line.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:line];
    
    return self;
}

- (void)setTitle:(NSString *)title bgWithArrow:(BOOL)arrow Image:(UIImage *)image
{
    titleLabel.text = title;
    if (arrow) {
        bgView.image = arrowImage;
    } else {
        bgView.image = bgImage;
    }
    iconView.image=image;
}

@end

@implementation CommunityMoreController

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
    
	self.title = @"更多";
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:blurView];
    
    CommunityMoreHeaderView *headerView = [[CommunityMoreHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 70.0f)];
    [headerView setContent:[NSString stringWithFormat:@"益社区 版本:%@\n请及时更新，以获得更好的交互体验和便捷的社区生活服务。", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]]];
    
    //空白的footerview,没有这个在iPhone4上列表不能显示完全
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 60.0f)];
    
    CGRect rect = CGRectMake(LeftMargin, 0.0f, TableViewWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tableView.backgroundView = nil;
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = footerView;
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bind_cell";
    CommunityMoreCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CommunityMoreCell alloc] initWithStyle:UITableViewCellStyleValue1
                                        reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.row == 0) {
        UIImage *image=[UIImage imageNamed:@"qingchuhuncun"];
        [cell setTitle:@"清除缓存" bgWithArrow:NO Image:image];
        
    }
//    else if (indexPath.row == 1) {
//        UIImage *image=[UIImage imageNamed:@"jianchagengxin"];
//        [cell setTitle:@"当前版本" bgWithArrow:NO Image:image];
//    }
    else if (indexPath.row == 1) {
        UIImage *image=[UIImage imageNamed:@"yindaoye"];
        [cell setTitle:@"引导页" bgWithArrow:NO Image:image];
    } else if (indexPath.row == 2) {
        UIImage *image=[UIImage imageNamed:@"newicon_30"];
        [cell setTitle:@"评价我们" bgWithArrow:YES Image:image];
    } else if (indexPath.row == 3) {
        UIImage *image=[UIImage imageNamed:@"yijianfankui"];
        [cell setTitle:@"意见反馈" bgWithArrow:YES Image:image];
    } else if (indexPath.row == 4) {
        UIImage *image=[UIImage imageNamed:@"更多-关于我们"];
        [cell setTitle:@"关于我们" bgWithArrow:YES Image:image];
    }else if(indexPath.row==5){
        UIImage *image=[UIImage imageNamed:@"xiugaimima"];
        [cell setTitle:@"修改密码" bgWithArrow:YES Image:image];
    }else if(indexPath.row==6){
        UIImage *image=[UIImage imageNamed:@"bangzhushuoming"];
        [cell setTitle:@"帮助说明" bgWithArrow:YES Image:image];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MoreCellHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self cleanCache];
            break;
            
//        case 1:
//            [self checkUpdate];
//            break;
            
        case 1:{
            GuideController *controller = [GuideController new];
            [self.navigationController presentViewController:controller animated:NO completion:nil];
        }
            break;
            
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=841181474"]];
            break;
            
        case 3:{
            FeedBackController *controller = [FeedBackController new];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case 4:{
            AboutUsController *controller = [AboutUsController new];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }case 5:{
            selectPwdViewController *controller = [selectPwdViewController new];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 6:{
            helpExplainViewController *controller = [helpExplainViewController new];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)cleanCache
{
    [[CommunityIndicator sharedInstance] startLoading];
    [AppSetting cleanCache];
    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"缓存已清除"];
}

- (void)checkUpdate
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSArray *numArray = [version componentsSeparatedByString:@"."];
    NSString *versionNumber = [[NSString alloc] init];
    for (NSString *num in numArray) {
        versionNumber = [versionNumber stringByAppendingString:num];
    }
    int v = [versionNumber intValue];
    //loginFrom==1表示iphone用户
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:v], @"version", [NSNumber numberWithInt:1], @"loginFrom", nil];
    [[HttpClientManager sharedInstance] checkUpdateWithDict:dict
                                                   complete:^(BOOL success, CheckUpdateResponse *resp) {
                                                       if (success) {
                                                           if (resp.latestVersion > v) {
                                                               [self alertView:resp];
                                                           } else {
                                                               [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"当前是最新版本"];
                                                           }                                                          
                                                       } else {
                                                           [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络错误,请重试"];
                                                       }
                                                   }
     ];
    
}

- (void)alertView:(CheckUpdateResponse *)resp
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:resp.versionName
                                                        message:resp.description
                                                       delegate:self
                                              cancelButtonTitle:@"下次再说"
                                              otherButtonTitles:@"更新",nil];
    [alertView show];
}

#pragma mark UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //跳转itunes
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppItunesURL]];
    }
}

@end