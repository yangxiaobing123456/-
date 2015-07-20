//
//  myAssTableViewCell.h
//  Community
//
//  Created by HuaMen on 14-12-1.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myAssTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *conentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *baoxiu;
@property (weak, nonatomic) IBOutlet UILabel *baoxiuLabel;
- (IBAction)isReadButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *PingjiaLow;
@property (weak, nonatomic) IBOutlet UIButton *PingjiaHigh;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;

@end
