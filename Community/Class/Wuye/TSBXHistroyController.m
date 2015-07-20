//
//  TSBXHistroyController.m
//  Community
//
//  Created by SYZ on 14-5-6.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "TSBXHistroyController.h"
#import "BX_pingjiaViewController.h"
#import "TS_pingjiaViewController.h"

#define CellHeight      80.0f
#define CellLeftMargin  0.0f
#define CellTopMargin   5.0f
#define TableViewWidth  304.0f
#define LeftMargin      8.0f

static UIImage *bgImage = nil;
static UIImage *dayBgImage = nil;

@implementation ComplainOrRepairView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setData:(BOOL)complain
{
    if (complain) {
        text = @"投诉";
        backgroundColor = [UIColor colorWithHexValue:0xFFE95513];
    } else {
        text = @"报修";
        backgroundColor = [UIColor colorWithHexValue:0xFFFFBC00];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画圆并填充颜
    CGContextSetRGBStrokeColor(context,1.0f, 1.0f, 1.0f, 1.0f);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);//填充颜色
    CGContextAddArc(context, 30, 35, 25, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBFillColor (context, 1.0f, 1.0f, 1.0f, 1.0f); //设置字体颜色
    UIFont *font = [UIFont boldSystemFontOfSize:16.0];
    [text drawInRect:CGRectMake(14, 25, 50, 20) withFont:font];
}

@end

@implementation TSBXHistroyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"pslist_cell_bg"];
        }
        if (!dayBgImage) {
            dayBgImage = [UIImage imageNamed:@"icon_day_bg"];
        }
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, CellTopMargin, kContentWidth - 2 * CellLeftMargin, CellHeight - 2 * CellTopMargin)];
        bgView.image = bgImage;
        [self.contentView addSubview:bgView];
        
        complainOrRepairView = [[ComplainOrRepairView alloc] initWithFrame:CGRectMake(CellLeftMargin, CellTopMargin, 65.0f, CellHeight - 2 * CellTopMargin)];
        [self.contentView addSubview:complainOrRepairView];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, CellTopMargin + 5.0f, 180.0f, CellHeight - 2 * CellTopMargin - 10.0f)];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = [UIFont systemFontOfSize:14.0f];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        
        UIImageView *dayBgView = [[UIImageView alloc] initWithFrame:CGRectMake(250.0f, 15.0f, 50.0f, 50.0f)];
        dayBgView.image = dayBgImage;
        [self.contentView addSubview:dayBgView];
        
        dayCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(250.0f, 15.0f, 50.0f, 50.0f)];
        dayCountLabel.textColor = [UIColor whiteColor];
        dayCountLabel.backgroundColor = [UIColor clearColor];
        dayCountLabel.font = [UIFont systemFontOfSize:30.0f];
        dayCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dayCountLabel];
        
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(290.0f, 45.0f, 10.0f, 10.0f)];
        dayLabel.textColor = [UIColor whiteColor];
        dayLabel.backgroundColor = [UIColor clearColor];
        dayLabel.font = [UIFont systemFontOfSize:10.0f];
        dayLabel.textAlignment = NSTextAlignmentLeft;
        dayLabel.text = @"天";
        [self.contentView addSubview:dayLabel];
    }
    return self;
}

- (void)loadTask:(TaskInfo *)task
{
    contentLabel.text = task.content;
    dayCountLabel.text = [NSString getPastDayWithMillisecond:task.createTime];
    if (task.isComplain == TASK_COMPLAIN) {
        [complainOrRepairView setData:YES];
    } else {
        [complainOrRepairView setData:NO];
    }
}

@end

@implementation TSBXHistroyController

- (id)init
{
    self = [super init];
    if (self) {
        taskArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"历史记录";
    
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
    
    [self customBackButton:self];
    
    [self readDBData];
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//读取数据库数据
- (void)readDBData
{
    [taskArray removeAllObjects];
    
    NSArray *array = [[CommunityDbManager sharedInstance] queryTasks];
    [taskArray addObjectsFromArray:array];
    [tableView reloadData];
}

- (void)refreshData
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    long long time = [[CommunityDbManager sharedInstance] queryTasksUpdateTimeMax:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", MAXLONGLONG], @"after",
                          [NSString stringWithFormat:@"%lld", time], @"before",
                          [NSString stringWithFormat:@"%d", 1000], @"count", nil];
    [[HttpClientManager sharedInstance] tsbxHistoryWithDict:dict complete:^(int result) {
        [HttpResponseNotification getTaskHttpResponse:result];
        if (result == RESPONSE_SUCCESS) {
            [self readDBData];
        }
    }];
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"notice_cell";
    TSBXHistroyCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TSBXHistroyCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    TaskInfo *task = [taskArray objectAtIndex:indexPath.row];
    [cell loadTask:task];
    
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
    
    TaskInfo *task = [taskArray objectAtIndex:indexPath.row];
    TaskFlowController *controller = [TaskFlowController new];
    controller.taskId = task.taskId;
    NSLog(@"%@",task.taskId);
    controller.isComPair=task.isComplain;
    [self.navigationController pushViewController:controller animated:YES];
//    if (task.isComplain==1) {
//        TS_pingjiaViewController *controller = [TS_pingjiaViewController new];
//        controller.taskId = task.taskId;
//        NSLog(@"12233=====%@",controller.taskId);
//        controller.isComPair=task.isComplain;
//        [self.navigationController pushViewController:controller animated:YES];
//    }else if(task.isComplain==2){
//        BX_pingjiaViewController *controller = [BX_pingjiaViewController new];
//        controller.taskId = task.taskId;
//        controller.isComPair=task.isComplain;
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
