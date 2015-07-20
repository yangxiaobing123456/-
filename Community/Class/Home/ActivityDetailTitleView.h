//
//  ActivityDetailTitleView.h
//  Community
//
//  Created by HuaMen on 15-3-7.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailTitleView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *titleImage;
@property (strong, nonatomic) IBOutlet UIImageView *IsStartImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *AddLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UILabel *telLabel;

@property (strong, nonatomic) IBOutlet UIButton *hotBtn;
@property (strong, nonatomic) IBOutlet UIButton *freeBtn;
@property (strong, nonatomic) IBOutlet UIButton *todayBtn;

@property (strong, nonatomic) IBOutlet UIButton *telBtn;
@property (strong, nonatomic) IBOutlet UIButton *detailBtnPush;

@property (strong, nonatomic) IBOutlet UIImageView *littleHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *hostLabel;
@property (strong, nonatomic) IBOutlet UILabel *telepLabel;

@end
