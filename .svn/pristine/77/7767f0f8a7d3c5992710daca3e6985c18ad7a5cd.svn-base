//
//  PinglunCell.m
//  Community
//
//  Created by HuaMen on 15-2-13.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "PinglunCell.h"

@implementation PinglunCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _userPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        CALayer *picLayer = [_userPic layer];
        [picLayer setMasksToBounds:YES];
        [picLayer setCornerRadius:4.0];
        
        _userPic.image = [UIImage imageNamed:@"maomao.png"];
        [self.contentView addSubview:_userPic];
        
        //名字
        _level=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 130, 20)];
        _level.backgroundColor = [UIColor clearColor];
        _level.font = [UIFont systemFontOfSize:15];
        _level.textColor = RGBA(87, 107, 149, 1);
        [self.contentView addSubview:_level];
        
        _sexView = [[UIView alloc] initWithFrame:CGRectMake(_level.frame.origin.x, _level.frame.origin.y, 160, 20)];
        _sexView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_sexView];
        
        _time=[[UILabel alloc]initWithFrame:CGRectMake(238, 10, 77, 20)];
        _time.font = [UIFont systemFontOfSize:13];
        _time.textColor = RGBA(102, 102, 102, 1);
        [self.contentView addSubview:_time];
        
        //内容
        _content= [[UILabel alloc]initWithFrame:CGRectMake(60, 34, 190, 20)];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:14];
        _content.textColor = RGBA(160, 160, 150, 1);
        _content.backgroundColor  = [UIColor clearColor];
        [self.contentView addSubview:_content];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(265, _content.frame.origin.y-20, 64, 40);
//        _deleteBtn.backgroundColor = [UIColor redColor];
//        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"rubbishbox.png"] forState:UIControlStateNormal];
        _deletImage = [[UIImageView alloc] initWithFrame:CGRectMake(296, _content.frame.origin.y, 14, 16)];
        _deletImage.image = [UIImage imageNamed:@"rubbishbox.png"];
        [self.contentView addSubview:_deletImage];

        [self.contentView addSubview:_deleteBtn];
        
        _pinglunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pinglunBtn.frame = CGRectMake(265, _content.frame.size.height+35, 49, 45);
//        _pinglunBtn.backgroundColor = [UIColor redColor];
        _pingImage = [[UIImageView alloc] init];
        _pingImage.frame = CGRectMake(291, _content.frame.size.height+45, 19, 15);
        _pingImage.image = [UIImage imageNamed:@"rightPinglun.png"];
        [self.contentView addSubview:_pingImage];

        [self.contentView addSubview:_pinglunBtn];
        
        //分割线
        _imageLine = [[UIImageView alloc] init];
        _imageLine.frame = CGRectMake(0, _content.frame.size.height+71.5, 320, 0.5);
        _imageLine.backgroundColor = RGBA(217, 217, 217, 1);
        [self.contentView addSubview:_imageLine];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
