//
//  SubTuanGouViewController.h
//  Community
//
//  Created by HuaMen on 14-10-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "ASIHTTPRequest.h"

@interface SubTuanGouViewController : CommunityViewController
{
    UIImageView *headImage;
    UILabel *titlelabel;
    UILabel *priceLabel;
    UIScrollView *scrollView;
    UIWebView *webview;
    
    UILabel *distanceLabel;
    UILabel *shangpaiLabel;
    UILabel *liangdianLabel;
    UILabel *needKnowLabel1;
    UILabel *needKnowLabel;
}
@property(nonatomic,retain)NSString *GoodID;
@property(nonatomic,retain)NSString *nameStr;
@property(nonatomic,retain)NSString *priceStr;
@property(nonatomic,retain)NSString *timeStr;
@property(nonatomic,retain)NSString *imageUrlStr;
@property(nonatomic,retain)NSString *DJStr;

@end
