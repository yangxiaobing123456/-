//
//  ShareActivityViewController.h
//  Community
//
//  Created by HuaMen on 15-2-2.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

#import "MultiImageUploadView.h"

@interface ShareActivityViewController : CommunityViewController<UITextViewDelegate,MultiImageUploadViewDelegate,UIAlertViewDelegate>
{
    UIScrollView *scrollView;
    UITextView *tsTextView;
    MultiImageUploadView *imageUploadView;
}
//copy 有的地方用的retain 可能会存在内存泄露
@property(nonatomic,copy)NSString *idStr;

@end