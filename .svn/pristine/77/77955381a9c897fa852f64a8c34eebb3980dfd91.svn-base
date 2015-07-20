//
//  SHHYController.m
//  Community
//
//  Created by SYZ on 13-11-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "SHHYController.h"
#import "SHHY_ZWXXController.h"
#import "SHHY_GGJTController.h"
#import "SHHY_OtherController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           57

static UIImage *bgImage = nil;
static UIImage *arrowImage = nil;

@implementation SHHYCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
//            bgImage = [UIImage imageNamed:@"cell_bg_red_114H"];
        }
        if (!arrowImage) {
//            arrowImage = [UIImage imageNamed:@"arrow"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, CellHeight)];
//        bgView.image = bgImage;
        bgView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        float iconW = 28.0f, iconH = 28.0f;
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(30.0f, (CellHeight - iconH) / 2, iconW, iconH)];
        [self.contentView addSubview:iconView];
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(117.0f, (CellHeight - 20.0f) / 2, 80.0f, 20.0f)];
        itemLabel.textColor = [UIColor grayColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:itemLabel];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 56.0f,kContentWidth - 2 * LeftMargin, 0.5)];
        line.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:line];
        
        float arrowW = 22.0f, arrowH = 22.0f;
        arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(TableViewWidth - arrowW - 25.0f, (CellHeight - arrowH) / 2, arrowW, arrowH)];
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


@implementation SHHYController

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
	
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *titleBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, 34.0f)];
    titleBgView.image = [UIImage imageNamed:@"bg_red_68H"];
    [headerView addSubview:titleBgView];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(260.0f, 4.0f, 26.0f, 26.0f)];
    iconView.image = [UIImage imageNamed:@"shhy"];
    [headerView addSubview:iconView];
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    CGRect rect = CGRectMake(LeftMargin, 0.0f, TableViewWidth, kContentHeight);
    tableView = [[CommunityTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setBounces:NO];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView setTableHeaderView:headerView];
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SHHY_List" ofType:@"txt"];
    functionArray = [EzJsonParser deserializeFromJson:[NSString stringWithContentsOfFile:path
                                                                                encoding:NSUTF8StringEncoding error:nil]
                                               asType:[NSArray class]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 这里要是SHHYItem的个数
    return functionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SHHY_cell";
    SHHYCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SHHYCell alloc] initWithStyle:UITableViewCellStyleValue1
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
    
    NSDictionary *dict = [functionArray objectAtIndex:indexPath.row];
    int index = [[dict valueForKey:@"index"] intValue];
    
    switch (index) {
        case ZWXX: {
            SHHY_ZWXXController *controller = [SHHY_ZWXXController new];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case GGJT: {
            SHHY_GGJTController *controller = [SHHY_GGJTController new];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default: {
            SHHY_OtherController *controller = [SHHY_OtherController new];
            controller.sshyItem = index;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}

@end
