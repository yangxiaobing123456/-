//
//  WebViewController.m
//  Community
//
//  Created by SYZ on 13-12-27.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithURL:(NSURL *)url_ title:(NSString *)title_
{
    self = [super init];
    if (self) {
        url = url_;
        title = title_;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = title;
    self.view.backgroundColor = [UIColor whiteColor];
    [self customBackButton:self];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentWidth, kNavContentHeight)];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter:webView.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray] ;
    [self.view addSubview:activityIndicatorView] ;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBackAction
{
    [webView stopLoading];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    DJLog(@"WebView request URL:%@", request.URL);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [activityIndicatorView startAnimating] ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网页加载失败"];
}

@end
