//
//  TaskFlowController.m
//  Community
//
//  Created by SYZ on 14-4-19.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "TaskFlowController.h"
#import "TS_pingjiaViewController.h"
#import "BX_pingjiaViewController.h"

#define CellHeight1         20.0f
#define CellHeight2         80.0f
#define CellTopMargin       5.0f
#define CellLeftMargin      10.0f
#define ContentLabelHeight  60.0f

static UIImage *bgImage = nil;

@implementation TaskFlowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!bgImage) {
            bgImage = [UIImage imageNamed:@"clear_bg_170H"];
        }
        
        bgView = [[UIImageView alloc] init];
        [self.contentView addSubview:bgView];
        
        
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellLeftMargin + 5.0f, self.contentView.frame.size.height / 2 - 30.0f, 90.0f, 40.0f)];
        statusLabel.textColor = [UIColor grayColor];
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.font = [UIFont systemFontOfSize:16.0f];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        statusLabel.numberOfLines = 0;
        [self.contentView addSubview:statusLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellLeftMargin + 5.0f, self.contentView.frame.size.height / 2  + 10.0f, 90.0f, 20.0f)];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:14.0f];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:timeLabel];
        
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:lineView];
        
        contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = [UIFont systemFontOfSize:14.0f];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        
        imageControl = [[TaskImageControl alloc] initWithFrame:CGRectMake(185.0f, contentLabel.frame.origin.y + contentLabel.frame.size.height + 5.0f, 55.0f, 55.0f)];
        imageControl.hidden = YES;
        [imageControl addTarget:self action:@selector(checkImage) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:imageControl];
    }
    return self;
}

- (void)loadFlow:(TaskFlowInfo *)flow
{
    float cellHeight;
    CGSize contentSize = [flow.content sizeWithFont:[UIFont systemFontOfSize:14.0f]
                                  constrainedToSize:CGSizeMake(180.0f, MAXFLOAT)];
    float sizeHeight = contentSize.height;
    if (contentSize.height <= ContentLabelHeight) {
        sizeHeight = ContentLabelHeight;
    }
    if ([flow.picture isEmptyOrBlank]) {
        cellHeight = CellHeight1 + sizeHeight;
    } else {
        cellHeight = CellHeight2 + sizeHeight;
    }
    
    bgView.frame = CGRectMake(CellLeftMargin, CellTopMargin, kContentWidth - 2 * CellLeftMargin, cellHeight - 2 * CellTopMargin);
    statusLabel.frame = CGRectMake(CellLeftMargin + 5.0f, cellHeight / 2 - 30.0f, 90.0f, 40.0f);
    timeLabel.frame = CGRectMake(CellLeftMargin + 5.0f, cellHeight / 2  + 10.0f, 90.0f, 20.0f);
    lineView.frame = CGRectMake(110.0f, CellTopMargin, 1.0f, cellHeight - 2 * CellTopMargin);
    contentLabel.frame = CGRectMake(120.0f, CellTopMargin + 5.0f, 180.0f, sizeHeight);
    imageControl.frame = CGRectMake(185.0f, contentLabel.frame.origin.y + contentLabel.frame.size.height + 5.0f, 55.0f, 55.0f);
    imageControl.hidden = [flow.picture isEmptyOrBlank];
    
    bgView.image = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 100.0f, 20.0f, 100.0f) resizingMode:UIImageResizingModeStretch];
    //任务状态
    switch (flow.type) {
        case TYPE_NEW:
            statusLabel.text = @"新任务";
            break;
            
        case TYPE_ASSIGNED:
            statusLabel.text = @"分配任务";
            break;
            
        case TYPE_PREPROCESS:
            statusLabel.text = @"管家接单";
            break;
            
        case TYPE_PROCESSING:
            statusLabel.text = @"处理任务";
            break;
            
        case TYPE_PROCESSED:
            statusLabel.text = @"处理完成";
            break;
            
        case TYPE_VISITED:
            statusLabel.text = @"管家回访";
            break;
            
        case TYPE_VISITED2:
            statusLabel.text = @"信息中心\n回访";
            break;
            
        case TYPE_FINISHED:
            statusLabel.text = @"任务完成";
            break;
            
        default:
            break;
    }
    //格式化时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:flow.updateTime / 1000.f];
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    timeLabel.text = [df stringFromDate:date];
    
    contentLabel.text = flow.content;
    
    [imageControl downLoadImage:flow.picture];
    
    url = flow.picture;
}

- (void)checkImage
{
    if ([url isEmptyOrBlank]) {
        return;
    }
    NSString *imgPath = [PathUtil pathOfImage:[NSString stringWithFormat:@"%lu", (unsigned long)[url hash]]];
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imgPath])
        return;
    NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
    [[CheckImageView sharedInstance] setImage:[UIImage imageWithData:imgData]];
}

@end

@implementation TaskFlowController

- (id)init
{
    self = [super init];
    if (self) {
        flowArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"任务流程";
    [self customBackButton:self];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kContentWidth, kNavContentHeight);
    tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    
    [self getTaskFlow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTableView
{
    if (flowArray.count != 0) {
        TaskFlowInfo *flow = [flowArray objectAtIndex:0];
        if (flow.type == TYPE_VISITED) {  //管家回访之后，业主评价
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, 80.0f)];
            footerView.backgroundColor = [UIColor clearColor];
            
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, kContentWidth, 20.0f)];
            tipLabel.textColor = [UIColor grayColor];
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.font = [UIFont systemFontOfSize:14.0f];
            tipLabel.text = @"任务已完成，请对此次任务的处理给予评价";
            [footerView addSubview:tipLabel];
            
            float buttonW = 100.0f, buttonH = 32.0f;
            UIButton *evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
            evaluateButton.frame = CGRectMake((kContentWidth - buttonW) / 2, 40.0f, buttonW, buttonH);
            [evaluateButton setTitle:@"评  价"
                            forState:UIControlStateNormal];
            [evaluateButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                                 forState:UIControlStateNormal];
            [evaluateButton setBackgroundImage:[UIImage imageNamed:@"button_normal_200W"]
                                      forState:UIControlStateNormal];
            [evaluateButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                                      forState:UIControlStateHighlighted];
            [evaluateButton addTarget:self
                               action:@selector(goEvaluate)
                     forControlEvents:UIControlEventTouchUpInside];
            [footerView addSubview:evaluateButton];
            
            tableView.tableFooterView = footerView;
        }
    }
    [tableView reloadData];
}

//获得任务详细流程
- (void)getTaskFlow
{
    [[CommunityIndicator sharedInstance] startLoading];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:0], @"before",
                          [NSNumber numberWithLongLong:MAXLONGLONG], @"after",
                          [NSNumber numberWithInt:100], @"count",
                          _taskId, @"id", nil];
    
    [[HttpClientManager sharedInstance] getTaskFlowWith:dict complete:^(int result, NSArray *array) {
        [HttpResponseNotification getTaskFlowHttpResponse:result];
        if (result == RESPONSE_SUCCESS && array) {
            [flowArray removeAllObjects];
            [flowArray addObjectsFromArray:array];
            [self reloadTableView];
        }
    }];
}

- (void)goEvaluate
{
//    TaskEvaluateController *controller = [TaskEvaluateController new];
//    controller.taskId = _taskId;
//    NSLog(@"_taskId==%@",_taskId);
    
    if (_isComPair==2) {
        TS_pingjiaViewController *controller = [TS_pingjiaViewController new];
        controller.taskId = _taskId;
        NSLog(@"%@",_taskId);
        [self.navigationController pushViewController:controller animated:YES];
    }else if(_isComPair==1){
        BX_pingjiaViewController *controller = [BX_pingjiaViewController new];
        controller.taskId = _taskId;
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [flowArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"notice_cell";
    TaskFlowCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TaskFlowCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    TaskFlowInfo *flow = [flowArray objectAtIndex:(flowArray.count - indexPath.row - 1)];
    [cell loadFlow:flow];
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskFlowInfo *flow = [flowArray objectAtIndex:(flowArray.count - indexPath.row - 1)];
    CGSize contentSize = [flow.content sizeWithFont:[UIFont systemFontOfSize:14.0f]
                                  constrainedToSize:CGSizeMake(180.0f, MAXFLOAT)];
    float sizeHeight = contentSize.height;
    if (contentSize.height <= ContentLabelHeight) {
        sizeHeight = ContentLabelHeight;
    }
    if ([flow.picture isEmptyOrBlank]) {
        return CellHeight1 + sizeHeight;
    }
    return CellHeight2 + sizeHeight;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark TaskEvaluateControllerDelegate methods
- (void)successEvaluate:(TaskEvaluateController *)controller
{
    [controller.navigationController popViewControllerAnimated:YES];
    
    tableView.tableFooterView = nil;
    [self getTaskFlow];
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
