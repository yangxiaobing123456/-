//
//  ZBYHController.m
//  Community
//
//  Created by SYZ on 13-12-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "ZBYHController.h"
#import "ZBYHItemController.h"

#define TopMargin            10
#define CellLeftMargin       8
#define CellHeight           57

static UIImage *bgImage = nil;
static UIImage *arrowImage = nil;

@implementation ZBYHCell

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
//        bgView.image = bgImage;
        bgView.backgroundColor=[UIColor whiteColor];
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

@implementation ZBYHController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"周边优惠";
	
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(CellLeftMargin, 0.0f, kContentWidth - 2 * CellLeftMargin, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    float headerViewH = 100.0f;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, headerViewH + TopMargin)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *headerbg = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, TopMargin, kContentWidth - 2 * CellLeftMargin, headerViewH)];
    headerbg.image = [UIImage imageNamed:@"bg1_with_icon"];
    [headerView addSubview:headerbg];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85.0f, (headerViewH - 20.0f) / 2 + TopMargin, 200.0f, 20.0f)];
//    titleLabel.text = @"我们全心全意为您服务!";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [headerView addSubview:titleLabel];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, TopMargin)];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kContentHeight);
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZBYH_List" ofType:@"txt"];
    functionArray = [EzJsonParser deserializeFromJson:[NSString stringWithContentsOfFile:path
                                                                                encoding:NSUTF8StringEncoding error:nil]
                                               asType:[NSArray class]];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return functionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"item_cell";
    ZBYHCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ZBYHCell alloc] initWithStyle:UITableViewCellStyleValue1
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
    
    ZBYHItemController *controller = [ZBYHItemController new];
    controller.title = [dict valueForKey:@"function"];
    controller.item = index;
    controller.iconImage = [UIImage imageNamed:[dict valueForKey:@"imageName"]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
