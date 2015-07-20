//
//  Fabu_View.h
//  Community
//
//  Created by HuaMen on 15-2-4.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fabu_View : UIView
@property (strong, nonatomic) IBOutlet UITextField *titleTextfield;
@property (strong, nonatomic) IBOutlet UITextView *xiangqingTextView;
@property (strong, nonatomic) IBOutlet UILabel *xiangqingLabel;
@property (strong, nonatomic) IBOutlet UITextField *renshuTextfield;
@property (strong, nonatomic) IBOutlet UITextField *dianhuaTextfield;


@property (strong, nonatomic) IBOutlet UIButton *feeBtn;
@property (strong, nonatomic) IBOutlet UIButton *typeBtn;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UIButton *endBtn;


@property (strong, nonatomic) IBOutlet UITextField *addressTextf;
@property (strong, nonatomic) IBOutlet UIButton *fabuBtn;

@property (strong, nonatomic) IBOutlet UILabel *feeLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *startLabel;
@property (strong, nonatomic) IBOutlet UILabel *endLabel;
@property (strong, nonatomic) IBOutlet UIImageView *feeImagev;
@property (strong, nonatomic) IBOutlet UIImageView *typeImagev;
@property (strong, nonatomic) IBOutlet UIImageView *startImagev;

@end
