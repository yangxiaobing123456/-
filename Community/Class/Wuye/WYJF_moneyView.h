//
//  WYJF_moneyView.h
//  Community
//
//  Created by wutao on 15-1-15.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYJF_moneyView : UIView
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UILabel *jifeMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;

@property (weak, nonatomic) IBOutlet UIButton *qianbaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *jifenBtn;
@property (weak, nonatomic) IBOutlet UIButton *yinlianBtn;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIImageView *qianbaoImage;
@property (weak, nonatomic) IBOutlet UIImageView *jifenImage;
@property (weak, nonatomic) IBOutlet UIImageView *yinlianImage;

@property (weak, nonatomic) IBOutlet UILabel *jifenChange;


@end
