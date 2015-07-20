//
//  WebViewController.h
//  Community
//
//  Created by SYZ on 13-12-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"

@interface WebViewController : CommunityViewController <UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicatorView;
    
    NSURL *url;
    NSString *title;
}

- (id)initWithURL:(NSURL *)url_ title:(NSString *)title_;

@end
