//
//  PraiseViewController.m
//  Community
//
//  Created by HuaMen on 14-12-10.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "PraiseViewController.h"
#import "UMSocial.h"
#import "RatingView.h"
#import "MultiImageUploadView.h"

@interface PraiseViewController ()<RatingViewDelegate,MultiImageUploadViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    RatingView *rateView;
    UITextView *contentView;
    MultiImageUploadView *imageUploadView;
    UIButton *nameBtn;
    NSMutableArray *dataArr;
    NSString *nameIdStr;
    //适配64位修改
    UIPickerView *_pickerView;
    NSString *starStr;
    NSString *nameStr;
    UITextField *nameField;
    
}

@end

@implementation PraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    starStr=@"5";
    nameStr=@"";
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(bbiClick)];
    leftBBI.tag = 1;
    // 添加到导航控制器上
    self.navigationItem.rightBarButtonItem = leftBBI;
    [self addView];
    [dataArr removeObject:[dataArr objectAtIndex:1]];
    [self customBackButton:self];
    

    
    
    
}
-(void)btnClick{
    [nameBtn setEnabled:NO];
    [self downName];
    
}
-(void)showPicker{
    
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        //    pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定                                                                                                                           义高度了，一般默认是无法修改其216像素的高度
        
        _pickerView.dataSource = self;   //这个不用说了瑟
        
        _pickerView.delegate = self;       //这个不用说了瑟
        
        _pickerView.frame = CGRectMake(0, 84, 320, 100);
        
        _pickerView.showsSelectionIndicator = YES;    //这个最好写 你不写来试下哇
        
        [self.view addSubview:_pickerView];

}
-(void)downName{
    NSDictionary *user = [[NSDictionary alloc]init];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:kGetHPraiseURL];
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
-(void)addView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, 320, self.view.bounds.size.height+64)];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.contentInset = UIEdgeInsetsMake(54, 0.0f, 0.0f, 0.0f);
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(320, 800.0f);
    UIImageView *wightImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 310, 60)];
    [wightImage setBackgroundColor:[UIColor whiteColor]];
    [scrollView addSubview:wightImage];
    
    UIImageView *heightImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 150, 30)];
    [heightImage setBackgroundColor:[UIColor lightGrayColor]];
    [scrollView addSubview:heightImage];
    nameBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [nameBtn setFrame:heightImage.frame];
    [nameBtn setTitle:@"选择表扬管家" forState:UIControlStateNormal];
    [nameBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:nameBtn];
    
//    nameField = [[UITextField alloc] initWithFrame:nameBtn.frame];
//    nameField.backgroundColor = [UIColor clearColor];
//    nameField.placeholder=@"请填写表扬管家";
//    nameField.textColor = [UIColor grayColor];
//    nameField.returnKeyType = UIReturnKeyDefault;
//    nameField.font = [UIFont fontWithName:@"Arial" size:13.0f];
//    [scrollView addSubview:nameField];

    
    rateView = [[RatingView alloc] initWithFrame:CGRectMake(160.0f, 20.0f, 0.0f, 0.0f)];
    [rateView setImagesDeselected:@"透明小红旗.png" partlySelected:nil fullSelected:@"小红旗.png" andDelegate:self];
    [rateView displayRating:5.0f];
    [scrollView addSubview:rateView];
    
    UIImageView *textViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75, 320, 200.0f)];
    textViewBg.image = [UIImage imageNamed:@"enter_box_330H"];
    [scrollView addSubview:textViewBg];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(5, 80, 310, 180.0f)];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.textColor = [UIColor grayColor];
    contentView.returnKeyType = UIReturnKeyDefault;
    contentView.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [scrollView addSubview:contentView];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(7, 286, 290, 12)];
    [l setText:@"选择照片"];
    l.font = [UIFont fontWithName:@"Arial" size:11.0f];
    [scrollView addSubview:l];
    imageUploadView = [[MultiImageUploadView alloc] initWithFrame:CGRectMake(7.0f, 300.0f, 290.0f, 64.0f)];
    imageUploadView.backgroundColor=[UIColor whiteColor];
    imageUploadView.type = 4;
    imageUploadView.controller=self;
    imageUploadView.delegate = self;
    [scrollView addSubview:imageUploadView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake((320 - 100.0f) / 2, 380, 100.0f, 32.0f);
    [submitButton setTitle:@"确  定"
                  forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [submitButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                       forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                            forState:UIControlStateHighlighted];
    [submitButton addTarget:self
                     action:@selector(submitButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitButton];

    
    
}
-(void)submitButtonClick{
    if ([nameBtn.titleLabel.text isEqualToString:@"选择表扬管家"]) {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请填写相关信息"];
        return;
    }
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:nameIdStr,@"adminId",starStr,@"score",contentView.text,@"content",@"",@"pic",nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:kPraiseURL];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=200;
        request.delegate=self;
        [request startAsynchronous];
    }

    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"请求失败"];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"OK!!");
    if (request.tag==100) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            dataArr=[dic objectForKey:@"adminList"];
            [self showPicker];

            
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
            
        }
        
    }if (request.tag==200) {
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"表扬成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"获取信息失败"];
            
        }
        
    }

    
    
    
}

#pragma mark MultiImageUploadViewDelegate
- (void)hideKeyboard
{
    [contentView resignFirstResponder];
}

#pragma mark RatingViewDelegate method
- (void)ratingChanged:(float)newRating
{
    switch ((int)newRating) {
        case 1:
            starStr=@"1";
            break;
            
        case 2:
             starStr=@"2";
            break;
            
        case 3:
             starStr=@"3";
            break;
            
        case 4:
             starStr=@"4";
            break;
            
        case 5:
             starStr=@"5";
            break;
            
        default:
            break;
    }
}
#pragma mark -

#pragma mark UIPickerViewDataSource



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;     //这个picker里的组键数
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return [dataArr count];  //数组个数
    
}

#pragma mark -

#pragma mark UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [nameBtn setEnabled:YES];
        [nameBtn setTitle:[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:row] objectForKey:@"name"]] forState:UIControlStateNormal];
        nameIdStr=[NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:row] objectForKey:@"id"]];
        
    }
    [_pickerView setHidden:YES];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (component == 0) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [[dataArr objectAtIndex:row]objectForKey:@"name"];
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }else {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
        
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:14];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    
    return myView;
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    
    CGFloat componentWidth = 0.0;
    
    
    if (component == 0)
        
        componentWidth = 100.0; // 第一个组键的宽度  
    
    else
        
        componentWidth = 180.0; // 第2个组键的宽度
    
    
    return componentWidth;
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 40.0;
    
}

-(void)bbiClick{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMengAppkey
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,UMShareToQQ,UMShareToDouban,UMShareToLine,UMShareToFacebook,UMShareToEmail,UMShareToSms,UMShareToWechatTimeline,UMShareToPinterest,nil]
                                       delegate:nil];

    
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
