//
//  UPPayViewController.m
//  Community
//
//  Created by SYZ on 14-5-17.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "UPPayViewController.h"

#define kMode             @"00"         //00为正式环境，01为测试环境

@interface UPPayViewController ()

@end

@implementation UPPayViewController

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
    
    self.title = @"银联支付";
    [self customBackButton:self];
    
    [UPPayPlugin startPay:_tradeNumber
                     mode:kMode
           viewController:self
                 delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UPPayPluginDelegate methods
- (void)UPPayPluginResult:(NSString *)result
{
    
    NSString *msg = [NSString stringWithFormat:@"支付结果:%@", result];
    NSLog(@"---%@", msg);
    if ([result isEqualToString:@"success"]) {
        [[CommunityIndicator sharedInstance] startLoading];
        [self downLoad];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)downLoad{
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_orderNumber,@"no", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:KpayOk];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [[CommunityIndicator sharedInstance] hideIndicator:YES];
    NSLog(@"faild===%@",request.error);
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    [[CommunityIndicator sharedInstance] hideIndicator:YES];
    NSLog(@"OK!!");
    NSDictionary *dic=[request.responseData objectFromJSONData];
    NSLog(@"%@",dic);
    NSString *result=[dic objectForKey:@"result"];
    if ([result isEqualToString:@"1"]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"恭喜您缴费成功!"];
        [self.navigationController popViewControllerAnimated:NO];
        
    }else{
//        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
        
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
