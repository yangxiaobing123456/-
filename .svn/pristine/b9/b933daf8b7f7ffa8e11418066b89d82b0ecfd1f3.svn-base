//
//  ZBYH_DetailController.m
//  Community
//
//  Created by SYZ on 14-3-14.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "ZBYH_DetailController.h"

#define LeftMargin          8.0f
#define ViewWidth           304.0f

@interface ZBYH_DetailController ()

@end

@implementation ZBYH_DetailController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 0.0f, ViewWidth, TopMargin)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    float infoViewH = 185.0f;
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, TopMargin, ViewWidth, infoViewH)];
    infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infoView];
    
    logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 93.0f, 62.0f)];
    logoView.image = [ImageUtil imageCenterWithImage:[UIImage imageNamed:@"default_loading"]
                                          targetSize:CGSizeMake(93.0f, 62.0f)
                                     backgroundColor:[UIColor colorWithHexValue:0xFFDBDCDC]];
    [infoView addSubview:logoView];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0f, 2.0f, 190.0f, 40.0f)];
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.font = [UIFont systemFontOfSize:14.0f];
    addressLabel.numberOfLines = 2;
    [infoView addSubview:addressLabel];
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(105.0f, 42.0f, 190.0f, 20.0f)];
    phoneLabel.textColor = [UIColor grayColor];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    [infoView addSubview:phoneLabel];
    
    UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 62.0f, ViewWidth, 2.0f)];
    dividerView.backgroundColor = [UIColor grayColor];
    dividerView.alpha = 0.5f;
    [infoView addSubview:dividerView];
    
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, ViewWidth, infoViewH - 64.0f)];
    contentTextView.backgroundColor = [UIColor colorWithHexValue:0xFFE2341E];
    contentTextView.textColor = [UIColor whiteColor];
    contentTextView.editable = NO;
    contentTextView.font = [UIFont systemFontOfSize:16.0f];
    [infoView addSubview:contentTextView];
    
    map = [[MKMapView alloc] initWithFrame:CGRectMake(LeftMargin, infoViewH + TopMargin, ViewWidth, kNavContentHeight - infoViewH - TopMargin)];
    map.mapType = MKMapTypeStandard;
    [self.view addSubview:map];
    
    if (_shopInfo.telephone && ![_shopInfo.telephone isEmptyOrBlank]) {
        UIButton *telephoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        telephoneButton.frame = CGRectMake((kContentWidth - 194.0f) / 2, kNavContentHeight - 65.0f, 194.0f, 45.0f);
        [telephoneButton setTitle:[@"联系电话: " stringByAppendingString:_shopInfo.telephone]
                         forState:UIControlStateNormal];
        [telephoneButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [telephoneButton setTitleColor:[UIColor blackColor]
                              forState:UIControlStateNormal];
        [telephoneButton setBackgroundImage:[UIImage imageNamed:@"phone_button"]
                                   forState:UIControlStateNormal];
        [telephoneButton addTarget:self
                            action:@selector(didPhoneButtonClick)
                  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:telephoneButton];
    }
    
    [self loadData];
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    addressLabel.text = [@"地址: " stringByAppendingString:_shopInfo.address];
    phoneLabel.text = [@"电话: " stringByAppendingString:_shopInfo.telephone];
    contentTextView.text = [@"优惠详情:\n\n" stringByAppendingString:_shopInfo.content];
    
    if ([_shopInfo.logo isEqualToString:kCommunityImageServer]) {
        return;
    }
    NSString *imgPath = [PathUtil pathOfImage:[NSString stringWithFormat:@"%lu", (unsigned long)[_shopInfo.logo hash]]];
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:imgPath]) { // 图片文件不存在
        ImageDownloadingTask *task = [ImageDownloadingTask new];
        [task setImageUrl:_shopInfo.logo];
        [task setUserData:_shopInfo];
        [task setTargetFilePath:imgPath];
        [task setCompletionHandler:^(BOOL succeeded, ImageDownloadingTask *idt) {
            if(succeeded && idt != nil && [idt.userData isEqual:_shopInfo]){
                UIImage *tempImg = [UIImage imageWithData:[idt resultImageData]];
                [logoView setImage:tempImg];
            }
        }];
        [[ImageDownloader sharedInstance] download:task];
    } else { //图片存在
        NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
        [logoView setImage:[UIImage imageWithData:imgData]];
    }
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(_shopInfo.lat, _shopInfo.lon);
    if (!CLLocationCoordinate2DIsValid(coords)) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"经纬度错误,找不到位置"];
        return;
    }
    
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [map setRegion:[map regionThatFits:region] animated:YES];
    
    CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithCoordinate:coords];
    [map addAnnotation:annotation];
}

- (void)didPhoneButtonClick
{
    //NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //结束电话之后会进入联系人列表
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@", _shopInfo.telephone]; //而这个方法则打电话前先弹框,打完电话之后回到程序中
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

@end
