//
//  JoinActViewController.h
//  Community
//
//  Created by HuaMen on 14-12-29.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface JoinActViewController : CommunityViewController<UITextViewDelegate,UIAlertViewDelegate>
{
    UIButton *canjiaBtn;
}
@property(nonatomic,retain)NSString *idStr;

@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *contentStr;
@property(nonatomic,copy)NSString *btnStr;

@property(nonatomic,assign)NSInteger tag;



@end
