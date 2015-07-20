//
//  PinglunCell.h
//  Community
//
//  Created by HuaMen on 15-2-13.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinglunCell : UITableViewCell

@property (retain, nonatomic) UIImageView *userPic;
@property (retain, nonatomic) UILabel *level;
@property (retain, nonatomic) UILabel *time;
@property (retain, nonatomic) UILabel *content;
@property (retain, nonatomic) UIButton *deleteBtn;
@property (retain, nonatomic) UIImageView *deletImage;

@property (retain, nonatomic) UIButton *pinglunBtn;
@property (retain, nonatomic) UIImageView *imageLine;
@property (retain, nonatomic) UIImageView *pingImage;
@property (retain, nonatomic) UIView *sexView;

@end