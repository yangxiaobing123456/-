//
//  JoinTableViewCell.h
//  Community
//
//  Created by HuaMen on 15-2-10.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userPic;
@property (strong, nonatomic) IBOutlet UILabel *level;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *actNum;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIView *sexView;

@end
