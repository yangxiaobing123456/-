                                                                                                        //
//  CommunityHomeCell.m
//  Community
//
//  Created by SYZ on 13-11-26.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityHomeCell.h"

@implementation HomeHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, HomeHeaderViewHeight, HomeHeaderViewHeight)];
        avatarView.layer.masksToBounds=YES;
        avatarView.layer.cornerRadius=5;
        avatarView.image = [AppSetting avatarImage];
        [self addSubview:avatarView];
        
        UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(HomeHeaderViewHeight + CellHorizontalSpace, 0.0f, HomeHeaderViewHeight, HomeHeaderViewHeight)];
        dateView.backgroundColor = [UIColor colorWithHexValue:0xFF009FE8];
        dateView.layer.masksToBounds=YES;
        dateView.layer.cornerRadius=5;
        [self addSubview:dateView];
        
        dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f, HomeHeaderViewHeight, 40.0f)];
        dayLabel.textColor = [UIColor whiteColor];
        dayLabel.backgroundColor = [UIColor clearColor];
//        dayLabel.font = [UIFont systemFontOfSize:40.0f];
        dayLabel.font=[UIFont italicSystemFontOfSize:40.0f];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        [dateView addSubview:dayLabel];
        
        monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 47.0f, 35.0f, 20.0f)];
        monthLabel.textColor = [UIColor whiteColor];
        monthLabel.backgroundColor = [UIColor clearColor];
        monthLabel.font = [UIFont systemFontOfSize:10.0f];
        monthLabel.textAlignment = NSTextAlignmentCenter;
        [dateView addSubview:monthLabel];
        
        weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 47.0f, 35.0f, 20.0f)];
        weekdayLabel.textColor = [UIColor whiteColor];
        weekdayLabel.backgroundColor = [UIColor clearColor];
        weekdayLabel.font = [UIFont systemFontOfSize:10.0f];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        [dateView addSubview:weekdayLabel];
        
        /*天气模块
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(198.0f, 2.0f, 2.0f, HomeHeaderViewHeight - 2 * 2.0f)];
        lineView.backgroundColor = BlurColor;
        [self addSubview:lineView];
        
        UILabel *weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(205.0f, 5.0f, 20.0f, 10.0f)];
        weatherLabel.text = @"温度";
        weatherLabel.textColor = [UIColor whiteColor];
        weatherLabel.backgroundColor = [UIColor clearColor];
        weatherLabel.font = [UIFont systemFontOfSize:10.0f];
        [self addSubview:weatherLabel];
        
        tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 0.0f, self.frame.size.width - 200.0f, self.frame.size.height)];
        tempLabel.text = @"N/A";
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.font = [UIFont systemFontOfSize:40.0f];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tempLabel];*/
        
        [self setDateValue];
    }
    return self;
}

- (void)setDateValue
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now = [NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    dayLabel.text = [NSString stringWithFormat:@"%ld", (long)[comps day]];
    
    switch ([comps month]) {
        case 1:
            monthLabel.text = @"一月";
            break;
            
        case 2:
            monthLabel.text = @"二月";
            break;
            
        case 3:
            monthLabel.text = @"三月";
            break;
            
        case 4:
            monthLabel.text = @"四月";
            break;
            
        case 5:
            monthLabel.text = @"五月";
            break;
            
        case 6:
            monthLabel.text = @"六月";
            break;
            
        case 7:
            monthLabel.text = @"七月";
            break;
            
        case 8:
            monthLabel.text = @"八月";
            break;
            
        case 9:
            monthLabel.text = @"九月";
            break;
            
        case 10:
            monthLabel.text = @"十月";
            break;
            
        case 11:
            monthLabel.text = @"十一月";
            break;
            
        case 12:
            monthLabel.text = @"十二月";
            break;
            
        default:
            break;
    }
    
    switch ([comps weekday]) {
        case 1:
            weekdayLabel.text = @"星期日";
            break;
            
        case 2:
            weekdayLabel.text = @"星期一";
            break;
            
        case 3:
            weekdayLabel.text = @"星期二";
            break;
            
        case 4:
            weekdayLabel.text = @"星期三";
            break;
            
        case 5:
            weekdayLabel.text = @"星期四";
            break;
            
        case 6:
            weekdayLabel.text = @"星期五";
            break;
            
        case 7:
            weekdayLabel.text = @"星期六";
            break;
            
        default:
            break;
    }
}

- (void)refreshAvatar
{
    avatarView.image = [AppSetting avatarImage];
}

/*天气模块
- (void)setTemp:(NSString *)temp
{
    if ([temp isEmptyOrBlank] || temp == nil) {
        tempLabel.text = @"N/A";
    } else {
        tempLabel.text = [NSString stringWithFormat:@"%@°C", temp];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[[event touchesForView:self] anyObject] locationInView:self];
    if (CGRectContainsPoint(tempLabel.frame, point) &&
        [tempLabel.text isEqualToString:@"N/A"]) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请打开定位服务\n获取实时温度"];
    }
}*/

@end

@implementation HomeRecommendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        recommendView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, CellVerticalSpace, ViewWidth, RecommendCellHeight)];
        recommendView.image = [UIImage imageNamed:@"recommend"];
        [self.contentView addSubview:recommendView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

static UIImage *bgImage0 = nil;
static UIImage *bgImage1 = nil;
static UIImage *bgImage2 = nil;
static UIImage *themeImage0 = nil;
static UIImage *themeImage1 = nil;
static UIImage *themeImage2 = nil;

@implementation HomeFunctionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initImage];
        
        float cellBgViewW = 228.0f;
        cellBgView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - cellBgViewW, CellVerticalSpace, cellBgViewW, FunctionCellHeight)];
        [self.contentView addSubview:cellBgView];
        
        cellThemeView = [[UIImageView alloc] initWithFrame:CGRectMake(CellLeftMargin, CellVerticalSpace, 88.0f, FunctionCellHeight)];
        [self.contentView addSubview:cellThemeView];
        
        cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 15.0f, 76.0f, 30.0f)];
        cellTitleLabel.textColor = [UIColor whiteColor];
        cellTitleLabel.backgroundColor = [UIColor clearColor];
        cellTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:cellTitleLabel];
    }
    return self;
}

- (void)loadFuctionData:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case FunctionWYFW:
            cellBgView.image = bgImage0;
            cellThemeView.image = themeImage0;
            cellTitleLabel.text = @"物业服务";
            break;
            
        case FunctionZZFW:
            cellBgView.image = bgImage1;
            cellThemeView.image = themeImage1;
            cellTitleLabel.text = @"增值服务";
            break;
            
        case FunctionSQHD:
            cellBgView.image = bgImage2;
            cellThemeView.image = themeImage2;
            cellTitleLabel.text = @"社区活动";
            break;
            
        default:
            break;
    }
}

- (void)initImage
{
    if (!bgImage0) {
        bgImage0 = [UIImage imageNamed:@"bg0"];
    }
    
    if (!bgImage1) {
        bgImage1 = [UIImage imageNamed:@"bg1"];
    }
    
    if (!bgImage2) {
        bgImage2 = [UIImage imageNamed:@"bg2"];
    }
    
    if (!themeImage0) {
        themeImage0 = [UIImage imageNamed:@"home_cell_0"];
    }
    
    if (!themeImage1) {
        themeImage1 = [UIImage imageNamed:@"home_cell_1"];
    }
    
    if (!themeImage2) {
        themeImage2 = [UIImage imageNamed:@"home_cell_2"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
