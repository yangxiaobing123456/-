//
//  FirstPageWebViewController.m
//  Community
//
//  Created by HuaMen on 14-12-13.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "FirstPageWebViewController.h"

@interface FirstPageWebViewController ()

@end

@implementation FirstPageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"url====%@",_urlStr);
//    NSString *url=[NSString stringWithFormat:@"%@%@",kCommunityImageServer,_urlStr];
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-64)];
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    webView.scalesPageToFit=YES;
    [webView loadHTMLString:_urlStr baseURL:nil];
    [self.view addSubview:webView];
//    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
