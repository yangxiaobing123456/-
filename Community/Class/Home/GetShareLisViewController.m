//
//  GetShareLisViewController.m
//  Community
//
//  Created by HuaMen on 15-2-28.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "GetShareLisViewController.h"

#import "ImgScrollView.h"
#import "TapImageView.h"


#define Wide  80
#define IntevalY  10
#define IntevalX  20

@interface GetShareLisViewController ()<TapImageViewDelegate,ImgScrollViewDelegate,UIScrollViewDelegate>
{
    //    UITableView *myTable;   talkTable
    PinglunCell *tapCell;
    
    UIScrollView *my_ScrollView;
    NSInteger currentIndex;
    UIView *markView;
    UIView *scrollPanel;
    
    ImgScrollView *lastImgScrollView;
}

@end

@implementation GetShareLisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    discussListArray = [NSMutableArray arrayWithCapacity:0];
    
    scrollPanel = [[UIView alloc] initWithFrame:self.view.bounds];
    scrollPanel.backgroundColor = [UIColor clearColor];
    scrollPanel.alpha = 0;
    [self.view addSubview:scrollPanel];
    
    markView = [[UIView alloc] initWithFrame:scrollPanel.bounds];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0.0;
    [scrollPanel addSubview:markView];
    
    my_ScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollPanel addSubview:my_ScrollView];
    my_ScrollView.pagingEnabled = YES;
    my_ScrollView.delegate = self;
    //    CGSize contentSize = my_ScrollView.contentSize;
    //    contentSize.height = self.view.bounds.size.height;
    //    contentSize.width = 320 * 6;
    //    my_ScrollView.contentSize = contentSize;
    
    
    
    // Do any additional setup after loading the view.
    self.title = @"分享";
    myScrollview = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [myScrollview setContentSize:CGSizeMake(320, 2000)];
    myScrollview.showsVerticalScrollIndicator = NO;
    //    myScrollview.backgroundColor = [UIColor redColor];
    [self.view addSubview:myScrollview];
    
    [self addBarButtonItem];
    [self homedown];
    
    talkTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 0) style:UITableViewStylePlain];
    talkTable.delegate = self;
    talkTable.dataSource = self;
    talkTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    talkTable.scrollEnabled = NO;
    
    [myScrollview addSubview:talkTable];
    
    
    
}
#pragma mark -
#pragma mark - custom method
- (void) addSubImgView
{
    for (UIView *tmpView in my_ScrollView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    for (int i = 0; i < imageArray.count; i ++)
    {
        if (i == currentIndex)
        {
            continue;
        }
        
        TapImageView *tmpView = (TapImageView *)[tapCell viewWithTag:10 + i];
        
        //转换后的rect
        CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
        
        ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){i*my_ScrollView.bounds.size.width,0,my_ScrollView.bounds.size}];
        [tmpImgScrollView setContentWithFrame:convertRect];
        [tmpImgScrollView setImage:tmpView.image];
        [my_ScrollView addSubview:tmpImgScrollView];
        tmpImgScrollView.i_delegate = self;
        
        [tmpImgScrollView setAnimationRect];
    }
}

- (void) setOriginFrame:(ImgScrollView *) sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        markView.alpha = 1.0;
    }];
}
#pragma mark -
#pragma mark - custom delegate
- (void) tappedWithObject:(TapImageView *)sender
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    
    [self.view bringSubviewToFront:scrollPanel];
    scrollPanel.alpha = 1.0;
    TapImageView *tmpView = sender;
    
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    //然后使用indexPathForCell方法，就得到indexPath了~
    NSIndexPath *indexPath = [talkTable indexPathForCell:cell];
    
    int imagenumMHP = [[[[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"picture"] componentsSeparatedByString:@"#"] count];
    CGSize contentSize = my_ScrollView.contentSize;
    contentSize.height = self.view.bounds.size.height;
    contentSize.width = 320 * imagenumMHP;
    my_ScrollView.contentSize = contentSize;
    
    currentIndex = tmpView.tag - 10;
    tapCell = tmpView.identifier;
    
    //转换后的rect
    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
    
    CGPoint contentOffset = my_ScrollView.contentOffset;
    contentOffset.x = currentIndex*320;
    my_ScrollView.contentOffset = contentOffset;
    
    //添加
    [self addSubImgView];
    
    ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){contentOffset,my_ScrollView.bounds.size}];
    [tmpImgScrollView setContentWithFrame:convertRect];
    [tmpImgScrollView setImage:tmpView.image];
    [my_ScrollView addSubview:tmpImgScrollView];
    tmpImgScrollView.i_delegate = self;
    
    [self performSelector:@selector(setOriginFrame:) withObject:tmpImgScrollView afterDelay:0.1];
}

- (void) tapImageViewTappedWithObject:(id)sender
{
    self.navigationController.navigationBar.hidden = NO;
    
    
    ImgScrollView *tmpImgView = sender;
    
    [UIView animateWithDuration:0.5 animations:^{
        markView.alpha = 0;
        [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished) {
        scrollPanel.alpha = 0;
    }];
    
}
#pragma mark -
#pragma mark - scroll delegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}





#pragma mark-  BarButtonItem
- (void)addBarButtonItem
{
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    leftBarBtn.frame=CGRectMake(0, 0, 12, 20);
    leftBarBtn.tag = 101;
    [leftBarBtn addTarget:self action:@selector(rightBarBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)rightBarBtnSelect:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark request methods
-(void)homedown{
//    [discussListArray removeAllObjects];
    //此处不可以清空  切记
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:self.activityId,@"activityId",@"1",@"page",@"20",@"pageSize", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:getShareByActivityId];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
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
    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络不给力啊"];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"])
        {
            discussListArray = [NSMutableArray arrayWithCapacity:0];

            discussListArray = [[dic objectForKey:@"pageVo"] objectForKey:@"dataList"];
            
            CGFloat table2Height = 44;
            
            CGFloat zanHeight = 44;
            for (int i=0; i<discussListArray.count; i++)
            {
                CGFloat sectionHeight = [[[discussListArray objectAtIndex:i] objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height +46 + 34;
                NSArray *pictArr = [[[discussListArray objectAtIndex:i] objectForKey:@"picture"] componentsSeparatedByString:@"#"];
                table2Height = table2Height + sectionHeight +zanHeight+90+90*(pictArr.count/4);
                NSLog(@"table2Height==1112=%f",table2Height);
                
                NSArray *commentListA = [[discussListArray objectAtIndex:i] objectForKey:@"commentList"];
                int k = [commentListA count];
                if (k >0) {
                    for (int j=0; j<k; j++)
                    {
                        NSString *content = [[commentListA objectAtIndex:j] objectForKey:@"content"];
                        CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                        CGFloat cellHeight1 = cellHeight + 44;
                        table2Height = table2Height + cellHeight1;
                        NSLog(@"table2Height==222=%f",table2Height);
                        
                    }
                    
                }
            }
            
            talkTable.frame = CGRectMake(0, 0, 320, table2Height-44);
            [myScrollview setContentSize:CGSizeMake(320, table2Height+80)];
            [talkTable reloadData];
            
        }
    }
    else if (request.tag==200)
    {
        [self homedown];
    }
    else if (request.tag==300)
    {
        [self homedown];
    }else if (request.tag==400)
    {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"])
        {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"成功删除！"];

            [self homedown];
            
        }
        
    }
    
    
}

- (void)pinglunBtnClick:(UIButton *)btn
{
    CGFloat zanHeight = 44;
    //lineHeight 第N个讨论表格总高度
    CGFloat lineHeight = 44;
    for (int i=0; i<btn.tag + 1; i++)
    {
        CGFloat sectionHeight = [[[discussListArray objectAtIndex:i] objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height +70;
        NSArray *pictArr = [[[discussListArray objectAtIndex:i] objectForKey:@"picture"] componentsSeparatedByString:@"#"];
        
        lineHeight = lineHeight + sectionHeight +zanHeight+90+90*(pictArr.count/4);
        NSLog(@"lineHeight==1112=%f",lineHeight);
        NSArray *commentListA = [[discussListArray objectAtIndex:i] objectForKey:@"commentList"];
        int k = [commentListA count];
        //此处判断很重要
        if (k >0) {
            for (int j=0; j<k; j++)
            {
                NSString *content = [[commentListA objectAtIndex:j] objectForKey:@"content"];
                CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(208, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                CGFloat cellHeight1 = cellHeight + 30;
                lineHeight = lineHeight + cellHeight1;
                NSLog(@"lineHeight==222=%f",lineHeight);
                
            }
            
        }
    }
    
    NSArray *duoyuArray = [[discussListArray objectAtIndex:btn.tag] objectForKey:@"commentList"];
    int q = [duoyuArray count];
    if (q >0) {
        for (int j=0; j<q; j++)
        {
            NSString *content = [[duoyuArray objectAtIndex:j] objectForKey:@"content"];
            CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(208, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
            CGFloat duoyuHeight = cellHeight + 30;
            lineHeight = lineHeight - duoyuHeight;
            NSLog(@"lineHeight==222=%f",lineHeight);
            
        }
        
    }
    
    NSLog(@"123123123=====");
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"PinglunView" owner:self options:nil];
    pingView = [array objectAtIndex:0];
    pingView.frame = CGRectMake(103,lineHeight+talkTable.frame.origin.y-44-43-28, 180, 39);
    //判断是否点赞
    
    
    
    pingView.zanBtn.tag = btn.tag;
    pingView.pingBtn.tag = btn.tag;
    
    [pingView.zanBtn addTarget:self action:@selector(zanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pingView.pingBtn addTarget:self action:@selector(pingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [myScrollview addSubview:pingView];
    zanFlagString = [[discussListArray objectAtIndex:btn.tag] objectForKey:@"zanFlag"];
    NSLog(@"zanFlagString===%@",zanFlagString);
    if ([zanFlagString isEqualToString:@"1"]) {
        //        pingView.zanLabel.text = @"赞";
        [pingView.zanBtn setBackgroundImage:[UIImage imageNamed:@"zan.png"] forState:UIControlStateNormal];
        
    }else
    {
        //        pingView.zanLabel.text = @"取消赞";
        [pingView.zanBtn setBackgroundImage:[UIImage imageNamed:@"quxiaozan.png"] forState:UIControlStateNormal];
        
    }
}
- (void)pingBtnClick:(UIButton *)btn
{
    [pingView removeFromSuperview];

    send_view =[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49, 320, 49)];
    send_view.backgroundColor=RGBA(231, 231, 231, 231);
    [self.view addSubview:send_view];
    UIButton *sendbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    sendbtn.frame=CGRectMake(210, 5, 110, 39);
    sendbtn.frame=CGRectMake(240, 6, 74, 34);
    sendbtn.layer.cornerRadius = 4;
    sendbtn.layer.masksToBounds = YES;
    
    [sendbtn setTitle:@"发送" forState:UIControlStateNormal];
    sendbtn.backgroundColor = RGBA(0, 122, 255, 1);
    
    [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendbtn addTarget:self action:@selector(sendbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [send_view addSubview:sendbtn];
    
    message_field=[[UITextField alloc] initWithFrame:CGRectMake(5, 6, 220, 36)];
    message_field.borderStyle=UITextBorderStyleRoundedRect;
    message_field.delegate=self;
    message_field.placeholder=@"请输入评论";
    [send_view addSubview:message_field];
    
}

- (void)sendbtnClick
{
//    [pingView removeFromSuperview];
    [self pinglunRequest:pingView.pingBtn];
    
    [message_field resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [send_view removeFromSuperview];
    [UIView commitAnimations];
    
}

#pragma mark-textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑的时候 不要被键盘挡到
    NSLog(@"开始编辑");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    send_view.frame=CGRectMake(0, self.view.frame.size.height-49-250, 320, 49);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //键盘return按钮的时候  把相关视图恢复到原来的位置
    [textField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    send_view.frame=CGRectMake(0, self.view.frame.size.height-49, 320, 49);
    [UIView commitAnimations];
    return YES;
}

- (void)sharetalkDeleteBtnClick:(UIAlertView *)aler
{
    
    NSLog(@"deletePingString===%@",deletePingString);
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:deletePingString,@"id", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:DeleteSharePing];
        NSLog(@"DeleteSharePing==:%@",DeleteSharePing);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        
        request.tag=400;
        request.delegate=self;
        [request startAsynchronous];
    }
    [pingView removeFromSuperview];
    
}

- (void)pinglunRequest:(UIButton *)btn
{
    NSString *idstring = [[discussListArray objectAtIndex:btn.tag] objectForKey:@"id"];
    NSString *contentString = message_field.text;
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"shareid",contentString,@"content", nil];
    
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:Shareaddcomment];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        
        request.tag=300;
        
        request.delegate=self;
        [request startAsynchronous];
    }
    
}

-(void)MHPeleteBtnClick:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    //然后使用indexPathForCell方法，就得到indexPath了~
    NSIndexPath *indexPath = [talkTable indexPathForCell:cell];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要删除此条评论吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    NSArray *array1 = [[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
    
    deletePingString = [[array1 objectAtIndex:indexPath.row-2] objectForKey:@"id"];
    NSLog(@"deletePingString===%@====",deletePingString);
    
    alert.tag = 1001;
    alert.delegate = self;
    [alert show];
    
}


- (void)zanBtnClick:(UIButton *)btn
{
    NSString *idstring = [[discussListArray objectAtIndex:btn.tag] objectForKey:@"id"];
    NSLog(@"idString===%@",idstring);
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"shareId", nil];
    
    if ([zanFlagString isEqualToString:@"1"]) {
        user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"shareId", nil];
    }else
    {
        user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"shareId", nil];
    }
    
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:ShareDianzan];
        if ([zanFlagString isEqualToString:@"1"]) {
            url = [NSURL URLWithString:ShareDianzan];
        }else
        {
            url = [NSURL URLWithString:ShareDeleteDianzan];
        }
        
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
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
    [pingView removeFromSuperview];
    
}
#pragma mark-AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1&&alertView.tag==1001)
    {
        [self sharetalkDeleteBtnClick:alertView];
    }
}

#pragma mark-tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return discussListArray.count + 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }else
    {
       NSArray *ListArray = [[discussListArray objectAtIndex:section-1] objectForKey:@"commentList"];
        
        return ListArray.count + 2;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
//        static NSString *cellIdentifier = @"cellIdentiifer";
//        PeopleNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        PeopleNumTableViewCell *cell;
        if (!cell)
        {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PeopleNumTableViewCell" owner:nil options:nil];
            
            cell = (PeopleNumTableViewCell *)[array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.userLabel.text = @"";
        cell.hidden = YES;
        return cell;
        
    }else
    {
        if (indexPath.row==0)
        {
            static NSString *cellIdentifier = @"cellIdentiifer";
//            PinglunCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            PinglunCell *cell;
            if (!cell)
            {
                cell = [[PinglunCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSDictionary *dic = [discussListArray objectAtIndex:indexPath.section-1];
            
            NSString *ImageStr=[dic objectForKey:@"userPic"];
            NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
            [cell.userPic setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_132"]];
            
            cell.level.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            //开始
            CGSize titleSize = [cell.level.text sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(130, 20)];
            UIImageView *sexbg  = [[UIImageView alloc] initWithFrame:CGRectMake(titleSize.width+5, 4, 27, 12)];
            [cell.sexView addSubview:sexbg];
            UIImageView *sexArrow  = [[UIImageView alloc] initWithFrame:CGRectMake(sexbg.frame.origin.x+3, 7, 6, 6)];
            [cell.sexView addSubview:sexArrow];
            UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(sexArrow.frame.origin.x +sexArrow.frame.size.width, 4, 18, 12)];
            ageLabel.textColor = [UIColor whiteColor];
            ageLabel.textAlignment = NSTextAlignmentCenter;
            ageLabel.font = [UIFont systemFontOfSize:10.0];
            [cell.sexView addSubview:ageLabel];
            ageLabel.text = [dic objectForKey:@"age"];
            
            if ([[dic objectForKey:@"sex"] isEqualToString:@"0"]) {
                sexbg.image = [UIImage imageNamed:@"女.png"];
                sexArrow.image = [UIImage imageNamed:@"女箭头.png"];
                
            }else
            {
                sexbg.image = [UIImage imageNamed:@"男.png"];
                sexArrow.image = [UIImage imageNamed:@"男箭头.png"];
            }
            //结束
            
            cell.time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]];
            cell.content.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
            CGFloat contentHeight = [cell.content.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
            //delType 有问题
            cell.deleteBtn.hidden=YES;
            cell.deletImage.hidden = YES;
            //修改此处
            cell.content.frame = CGRectMake(60, 34, 190, contentHeight);
            //九宫格
            imageArray = [[dic objectForKey:@"picture"] componentsSeparatedByString:@"#"];
            NSLog(@"[dic objectForKey:picture======%@",[dic objectForKey:@"picture"]);
            
            CGSize contentSize = my_ScrollView.contentSize;
            contentSize.height = self.view.bounds.size.height;
            contentSize.width = 320 * imageArray.count;
            
            my_ScrollView.contentSize = contentSize;
            NSLog(@"imageArray.count=====%d",imageArray.count);
            
            picNum = [imageArray count];
            
            
            for (int i=0; i<imageArray.count; i++) {
                CGFloat fX = IntevalX + (IntevalX + Wide)*(i%3);
                CGFloat fY = contentHeight + 46 +IntevalY + (IntevalY + Wide)*(i/3);
                TapImageView *imageV = [[TapImageView alloc] initWithFrame:CGRectMake(fX, fY, 80, 80)];
                imageV.t_delegate = self;
                imageV.tag = 10 + i;
                
                NSString *fImageString = [imageArray objectAtIndex:i];
                NSURL *fImageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,fImageString]];
                [imageV setImageWithURL:fImageUrl placeholderImage:[UIImage imageNamed:@"maomao.png"]];
                
                [cell.contentView addSubview:imageV];
                
                TapImageView *tmpView1 = (TapImageView *)[cell.contentView viewWithTag:10+i];
                tmpView1.identifier = cell;
            }
            
            NSLog(@"%f",contentHeight+35+IntevalY +Wide + (IntevalY + Wide)*(imageArray.count/4));
            // 坐标 问题  IntevalY +Wide + (IntevalY + Wide)*(imageArray.count/3)== 90+90*(picNum/3)
            cell.pinglunBtn.frame = CGRectMake(265, contentHeight+35+IntevalY +Wide + (IntevalY + Wide)*(imageArray.count/4), 49, 45);
            
            
            
            
            cell.pingImage.frame = CGRectMake(285, contentHeight+55+IntevalY +Wide + (IntevalY + Wide)*(imageArray.count/4), 19, 15);
            // 修改此处
            cell.imageLine.frame = CGRectMake(0, contentHeight+46+33.5+IntevalY +Wide + (IntevalY + Wide)*(imageArray.count/4), 320, 0.5);
            
            cell.pinglunBtn.tag = indexPath.section - 1;
            
            
            [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (indexPath.row==1)
        {
//            static NSString *cellIdentifier = @"cellIdentiifer";
//            DianZanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            DianZanTableViewCell *cell;
            if (!cell)
            {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DianZanTableViewCell" owner:nil options:nil];
                
                cell = (DianZanTableViewCell *)[array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSDictionary *dic = [discussListArray objectAtIndex:indexPath.section-1];
            
            cell.dianZanNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"zanString"]];
            
            return cell;
        }else
        {
            static NSString *cellIdentifier = @"cellIdentiifer";
//            TalkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            TalkCell *cell;
            if (!cell)
            {
                cell = [[TalkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
            }
            
            if (indexPath.row==2) {
                cell.talkImag.hidden = NO;
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSArray *mentListArray = [[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
            
            NSDictionary *dic = [mentListArray objectAtIndex:indexPath.row-2];
            
            NSString *ImageStr=[dic objectForKey:@"userPic"];
            NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
            [cell.userPic setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_132"]];
            
            cell.level.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            //修改此处         //开始
            CGSize titleSize = [cell.level.text sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(130, 20)];
            UIImageView *sexbg  = [[UIImageView alloc] initWithFrame:CGRectMake(titleSize.width+5, 4, 27, 12)];
            [cell.sexView addSubview:sexbg];
            UIImageView *sexArrow  = [[UIImageView alloc] initWithFrame:CGRectMake(sexbg.frame.origin.x+3, 7, 6, 6)];
            [cell.sexView addSubview:sexArrow];
            UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(sexArrow.frame.origin.x +sexArrow.frame.size.width, 4, 18, 12)];
            ageLabel.textColor = [UIColor whiteColor];
            ageLabel.textAlignment = NSTextAlignmentCenter;
            ageLabel.font = [UIFont systemFontOfSize:10.0];
            [cell.sexView addSubview:ageLabel];
            ageLabel.text = [dic objectForKey:@"age"];
            
            if ([[dic objectForKey:@"sex"] isEqualToString:@"0"]) {
                sexbg.image = [UIImage imageNamed:@"女.png"];
                sexArrow.image = [UIImage imageNamed:@"女箭头.png"];
                
            }else
            {
                sexbg.image = [UIImage imageNamed:@"男.png"];
                sexArrow.image = [UIImage imageNamed:@"男箭头.png"];
            }
            //结束
            
            cell.time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]];
            cell.content.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
            
            NSString *commenddelType = [dic objectForKey:@"delType"];
            if ([commenddelType isEqualToString:@"1"]) {
//                cell.deleteBtn.tag = indexPath.row-2+1000000;
                
                NSLog(@"cell.deleteBtn.tag====%d",cell.deleteBtn.tag);
                [cell.deleteBtn addTarget:self action:@selector(MHPeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else
            {
                cell.deleteBtn.hidden = YES;
                cell.deletImage.hidden = YES;
            }

            CGFloat tentHeight = [cell.content.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
            
            cell.content.frame = CGRectMake(82, 34, 200, tentHeight);
            cell.imageLine.frame = CGRectMake(30, cell.content.frame.size.height+43.5, 320, 0.5);
            
            return cell;
            
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {//修改
        //        return 44;
        return 0;
        
    }else
    {
        NSDictionary *dic = [discussListArray objectAtIndex:indexPath.section-1];
        NSArray *imArray = [[dic objectForKey:@"picture"] componentsSeparatedByString:@"#"];
        int Num = [imArray count];
        
        NSString *contentS = [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        CGFloat tentHeight = [contentS sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
        
        if (indexPath.row==0)
        {
            CGFloat height = 46;
            if (kScreenHeight<481) {
                height += (tentHeight + 34)+90+90*(Num/4);
            }else
            {
                height += (tentHeight + 34)+90+90*(Num/4);
                NSLog(@"picNum====%d",Num);
                
                NSLog(@"picNum/4====%d",Num/4);
            }
            return height;
            
        }else if (indexPath.row==1)
        {
            CGFloat height = 44;
            return height;
        }else
        {
            NSArray *stArray = [[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
            NSDictionary *dic = [stArray objectAtIndex:indexPath.row-2];
            CGFloat htHeight = [[dic objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
            
            CGFloat height = 0;
            if (kScreenHeight<481) {
                height += (htHeight + 44);
            }else
            {
                height += (htHeight + 44);
                
            }
            
            return height;
            
        }
        
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [pingView removeFromSuperview];
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
