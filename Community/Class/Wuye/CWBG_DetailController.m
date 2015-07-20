//
//  CWBG_DetailController.m
//  Community
//
//  Created by SYZ on 13-12-19.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CWBG_DetailController.h"

#define TableViewWidth       304
#define LeftMargin           8
#define CellHeight           40
#define SectionHeight        44

static UIImage *bgImage0 = nil;
static UIImage *bgImage1 = nil;

@implementation CWBG_DetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage0) {
            bgImage0 = [UIImage imageNamed:@"cell_bg_80H_income"];
        }
        if (!bgImage1) {
            bgImage1 = [UIImage imageNamed:@"cell_bg_80H_outcome"];
        }
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, CellHeight)];
        [self.contentView addSubview:bgView];
        
        itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 130.0f, CellHeight)];
        itemLabel.textColor = [UIColor whiteColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.font = [UIFont systemFontOfSize:14.0f];
        itemLabel.textAlignment = NSTextAlignmentLeft;
        itemLabel.numberOfLines = 0;
        [self.contentView addSubview:itemLabel];
        
        amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(162.0f, 0.0f, 130.0f, CellHeight)];
        amountLabel.textColor = [UIColor grayColor];
        amountLabel.backgroundColor = [UIColor clearColor];
        amountLabel.font = [UIFont systemFontOfSize:14.0f];
        amountLabel.textAlignment = NSTextAlignmentRight;
//        amountLabel.numberOfLines = 0;
        [self.contentView addSubview:amountLabel];
    }
    return self;
}

- (void)loadItemAndAmount:(NSString *)string income:(BOOL)income
{
    if (income) {
        bgView.image = bgImage0;
    } else {
        bgView.image = bgImage1;
    }
    
    NSArray *array = [string componentsSeparatedByString:@"-"];
    itemLabel.text = array[0];
    amountLabel.text = array[1];
}

@end


@implementation CWBG_DetailController

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
    
    self.title = @"明细";
	
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, TableViewWidth, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, TopMargin)];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, TableViewWidth, TopMargin)];
    footerView.backgroundColor = [UIColor clearColor];
    
    CGRect rect = CGRectMake(LeftMargin, -44.0f, TableViewWidth, kContentHeight);
    tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    tableView.contentInset = UIEdgeInsetsMake(34.0f, 0.0f, 0.0f, 0.0f);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44.0f, 0.0f, 0.0f, 0.0f);
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = footerView;
    [self.view addSubview:tableView];
    
    [self customBackButton:self];
    
    [self parseIncomeAndOutcome];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parseIncomeAndOutcome
{
    _report.incomeArray = [_report.income componentsSeparatedByString:@"#"];
    _report.outcomeArray = [_report.outcome componentsSeparatedByString:@"#"];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _report.incomeArray.count;
    } else {
        return _report.outcomeArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"report_detail_cell";
    CWBG_DetailCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CWBG_DetailCell alloc] initWithStyle:UITableViewCellStyleValue1
                               reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.section == 0) {
        [cell loadItemAndAmount:[_report.incomeArray objectAtIndex:indexPath.row] income:YES];
    } else {
        [cell loadItemAndAmount:[_report.outcomeArray objectAtIndex:indexPath.row] income:NO];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    UIImageView *headerBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, TopMargin, TableViewWidth, 34.0f)];
    [view addSubview:headerBgView];
    
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, TopMargin, 40.0f, 20.0f)];
    yearLabel.textColor = [UIColor whiteColor];
    yearLabel.backgroundColor = [UIColor clearColor];
    yearLabel.font = [UIFont systemFontOfSize:16.0f];
    yearLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:yearLabel];
    
    UILabel *seasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, TopMargin + 20.0f, 50.0f, 12.0f)];
    seasonLabel.textColor = [UIColor whiteColor];
    seasonLabel.backgroundColor = [UIColor clearColor];
    seasonLabel.font = [UIFont systemFontOfSize:12.0f];
    seasonLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:seasonLabel];
    
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(TableViewWidth / 2, TopMargin, TableViewWidth / 2 - 10.0f, 34.0f)];
    categoryLabel.textColor = [UIColor whiteColor];
    categoryLabel.backgroundColor = [UIColor clearColor];
    categoryLabel.font = [UIFont systemFontOfSize:16.0f];
    categoryLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:categoryLabel];
    
    if (section == 0) {
        headerBgView.image = [UIImage imageNamed:@"bg_green_68H"];
        categoryLabel.text = @"收入";
    } else {
        headerBgView.image = [UIImage imageNamed:@"bg_dark_green_68H"];
        categoryLabel.text = @"支出";
    }
    NSArray *array = [_report.publishTime componentsSeparatedByString:@"-"];
    yearLabel.text = [NSString stringWithFormat:@"%@", array[0]];
    seasonLabel.text = [NSString stringWithFormat:@"第%@季度", array[1]];
    
    return view;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
