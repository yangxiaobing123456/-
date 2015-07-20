//
//  ActivityDetailSecondViewController.m
//  Community
//
//  Created by HuaMen on 15-3-8.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "ActivityDetailSecondViewController.h"

#define PeopleH  44
#define JoinH  88
#define PingH  100
#define DianH  44
#define TalkH  44

@interface ActivityDetailSecondViewController ()

@end

@implementation ActivityDetailSecondViewController

//- (void)setContentSize
//{
//    [myScrollview setContentSize:sizeScroll];
//}
- (void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewDidLoad) name:@"talkpoprefreshNotification" object:nil];
    
    //    [self homedown];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title= @"活动详情";
    
    //双击 单击手势
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    //双击
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//    
//    [doubleTap setNumberOfTapsRequired:2];
//    
//    [self.view addGestureRecognizer:singleTap];
//    
//    [self.view addGestureRecognizer:doubleTap];
//    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    
    _imageNameArray = [NSArray arrayWithObjects:@"拼车1.png",@"拼旅游1.png",@"拼K歌1.png",@"拼商品1.png",@"拼健身1.png",@"拼广场舞1.png",@"拼宠物1.png",@"球类1.png",@"拼跑步1.png",@"拼棋牌1.png",@"拼吃货1.png",@"跳蚤市场1.png",@"其他1.png", nil];
    
    [self addBarButtonItem];
    
    //用此处的方法可以改变scrollview的setContentSize
    myScrollview = [[UIScrollView alloc] init];
    myScrollview.frame= CGRectMake(0, 0, 320, kScreenHeight);
    //    myScrollview.backgroundColor = [UIColor redColor];
    CGSize sizeScr = CGSizeMake(320, 1000);
    
    [myScrollview setContentSize:sizeScr];
    myScrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollview];
    
    //    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ActivityDetailTitleView" owner:self options:nil];
    //    acDtitleView = [array objectAtIndex:0];
    acDtitleView = [[[NSBundle mainBundle]loadNibNamed:@"ActivityDetailTitleView" owner:self options:nil] objectAtIndex:0];
    acDtitleView.backgroundColor = [UIColor whiteColor];
    //xib坐标一定要和此处一致，不然控件不响应
    acDtitleView.frame = CGRectMake(0, 0, 320, 214);
    [myScrollview addSubview:acDtitleView];
    [acDtitleView.telBtn addTarget:self action:@selector(telBtn) forControlEvents:UIControlEventTouchUpInside];
    [acDtitleView.detailBtnPush addTarget:self action:@selector(detailBtnPush) forControlEvents:UIControlEventTouchUpInside];
    
    [self homedown];
    [self setTables];
    
    
}

//-(void)handleSingleTap:(id)sender
//{
//    [self.view resignFirstResponder];
//    
//}
//-(void)handleDoubleTap:(id)sender
//{
//    [self.view resignFirstResponder];
//    
//}


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


#pragma mark-  ButtonClick
- (void)fenxiangBtnClick
{
    NSLog(@"点击1");
    ShareActivityViewController *shareVC = [[ShareActivityViewController alloc] init];
    shareVC.idStr = self.idStr;
    [self.navigationController pushViewController:shareVC animated:YES];
}
- (void)canjiaBtnClick
{
    NSLog(@"点击2");
    JoinActViewController *JoinVC = [[JoinActViewController alloc] init];
    JoinVC.idStr = self.idStr;
    JoinVC.titleStr = @"我要参加";
    JoinVC.contentStr = @"一句话介绍自己情况";
    JoinVC.btnStr = @"我要参加";
    JoinVC.tag = 1;
    [self.navigationController pushViewController:JoinVC animated:YES];
    
}//
- (void)buCanjiaBtnClick:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要取消参加吗？" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"确定", nil];
    alert.tag = btn.tag;
    alert.delegate = self;
    [alert show];
    
    //    [self cancleHomedown];  buFabujiaBtnClick
}

- (void)buFabujiaBtnClick:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要取消发布吗？" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"确定", nil];
    alert.tag = btn.tag;
    alert.delegate = self;
    [alert show];
    
    //    [self cancleHomedown];  buFabujiaBtnClick
}


- (void)taolunBtnClick
{
    NSLog(@"点击讨论");
    JoinActViewController *JoinVC = [[JoinActViewController alloc] init];
    JoinVC.idStr = self.idStr;
    JoinVC.titleStr = @"参与讨论";
    JoinVC.contentStr = @"说出你要讨论的内容";
    JoinVC.btnStr = @"提交讨论";
    JoinVC.tag = 2;
    
    [self.navigationController pushViewController:JoinVC animated:YES];
}//编辑发布
- (void)bianjiBtnClick
{
    [self bianjiHomedown];
    
}


- (void)littleRequestsWithDic:(NSDictionary *)dictionaryP
{
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:NewActivityDetail];
        
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

-(void)btnClick{
    JoinActViewController *gv=[[JoinActViewController alloc]init];
    gv.idStr=_idStr;
    NSLog(@"id===%@",_idStr);
    [self.navigationController pushViewController:gv animated:YES];
    
    
}

#pragma mark request methods
-(void)homedown{


//    [discussListArray removeAllObjects];
//    [userListArray removeAllObjects];
//    [commentListArray removeAllObjects];
//    [shareListArray removeAllObjects];

    
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:NewActivityDetail];
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
-(void)cancleHomedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //取消发布
        NSURL *url = [NSURL URLWithString:urlString];
        NSLog(@"urlString====%@",urlString);
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=600;
        request.delegate=self;
        [request startAsynchronous];
    }
    
    
}

-(void)bianjiHomedown{
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:_idStr,@"activityId", nil];
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:getDetail2];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=700;
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
        if ([result isEqualToString:@"1"]) {
            //            [tableView reloadData];
            [self addaBottomView];
            
            discussListArray = [NSMutableArray arrayWithCapacity:0];
            userListArray = [NSMutableArray arrayWithCapacity:0];
//            commentListArray = [NSMutableArray arrayWithCapacity:0];
            shareListArray = [NSMutableArray arrayWithCapacity:0];

            detailDic = [NSDictionary dictionary];
            detailDic = [dic objectForKey:@"appNewActivityVo"];
            
            numString = [detailDic objectForKey:@"num"];
            discussNumString = [detailDic objectForKey:@"discussNum"];
            shareNumString = [detailDic objectForKey:@"shareNum"];
            
            userListArray = [NSMutableArray arrayWithCapacity:0];
            userListArray = [detailDic objectForKey:@"userList"];
            idString = [detailDic objectForKey:@"id"];
            flagString = [detailDic objectForKey:@"flag"];
            shareFlagString = [detailDic objectForKey:@"shareflag"];
            

            discussListArray = [dic objectForKey:@"discussList"];
            
            
            NSLog(@"discussListArray.count=====%d",discussListArray.count);
            
            shareListArray = [NSMutableArray arrayWithCapacity:0];
            shareListArray = [detailDic objectForKey:@"shareList"];
            
            //计算表格的高度 两个for循环
            table2Height = 44;
            CGFloat zanHeight = 44;
            for (int i=0; i<discussListArray.count; i++)
            {
                CGFloat sectionHeight = [[[discussListArray objectAtIndex:i] objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height +46 + 26;
                table2Height = table2Height + sectionHeight +zanHeight;
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
            
            //计算表格的高度 两个for循环
            shareTable2Height = 44;
            //            CGFloat zanHeight = 44;
            for (int i=0; i<shareListArray.count; i++)
            {
                CGFloat sectionHeight = [[[shareListArray objectAtIndex:i] objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height +46 + 26;
                shareTable2Height = shareTable2Height + sectionHeight +zanHeight;
                NSLog(@"shareTable2Height==1112=%f",shareTable2Height);
                
                NSArray *commentListA = [[shareListArray objectAtIndex:i] objectForKey:@"commentList"];
                int k = [commentListA count];
                if (k >0) {
                    for (int j=0; j<k; j++)
                    {
                        NSString *content = [[commentListA objectAtIndex:j] objectForKey:@"content"];
                        CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                        CGFloat cellHeight1 = cellHeight + 44;
                        shareTable2Height = shareTable2Height + cellHeight1;
                        NSLog(@"table2Height==222=%f",shareTable2Height);
                    }
                    
                }
            }
            
            
            acDtitleView.titleLabel.text=[detailDic objectForKey:@"title"];
            acDtitleView.timeLabel.text=[detailDic objectForKey:@"time"];
            acDtitleView.AddLabel.text=[detailDic objectForKey:@"address"];
            
            acDtitleView.telLabel.text = [NSString stringWithFormat:@"%@个邻居评论",[detailDic objectForKey:@"discussNum"]];
            acDtitleView.userLabel.text = [NSString stringWithFormat:@"%@个邻居已参加（最少%@人）",[detailDic objectForKey:@"num"],[detailDic objectForKey:@"lowNum"]];
            
            NSString *ImageStr=[detailDic objectForKey:@"userPic"];
            NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
            [acDtitleView.littleHeadImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maomao.png"]];
            int actyTypeNum = [[detailDic objectForKey:@"actyType"] intValue];
            NSLog(@"actyTypeNum-=====%d",actyTypeNum);
            acDtitleView.titleImage.image = [UIImage imageNamed:[_imageNameArray objectAtIndex:actyTypeNum-1]];
            
            acDtitleView.telepLabel.text = [detailDic objectForKey:@"telephone"];
            
            NSString *nameStr = [detailDic objectForKey:@"nickName"];
            if ([nameStr isEqualToString:@""]) {
                acDtitleView.hostLabel.text = [detailDic objectForKey:@"hostUnit"];
            }else
            {
                acDtitleView.hostLabel.text = [detailDic objectForKey:@"nickName"];
            }
            
            NSString *actyStatus=[detailDic objectForKey:@"actyStatus"];
            if ([actyStatus isEqualToString:@"3"])
            {
                acDtitleView.IsStartImage.image = [UIImage imageNamed:@"已结束.png"];
                
                if ([shareFlagString isEqualToString:@"0"]) {
                    //未参加
                    bottomView.fenxiangBtn.hidden=NO;
                    bottomView.fenxiangImage.hidden=NO;
                    [bottomView.fenxiangBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }else if ([shareFlagString isEqualToString:@"1"])
                {
                    bottomView.canjiaBtn.hidden=NO;
                    bottomView.canjiaImage.hidden=NO;
                    bottomView.taolunBtn.hidden=NO;
                    bottomView.taolunImage.hidden=NO;
                    
                    bottomView.canjiaImage.image = [UIImage imageNamed:@"分享.png"];
                    [bottomView.canjiaBtn setTitle:@"分享" forState:UIControlStateNormal];
                    bottomView.taolunImage.image = [UIImage imageNamed:@"讨论.png"];
                    [bottomView.taolunBtn setTitle:@"参与讨论" forState:UIControlStateNormal];
                    urlString = CancelJoinActivity;
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(fenxiangBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    [bottomView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                }
            }
            else if ([actyStatus isEqualToString:@"2"])
            {
                acDtitleView.IsStartImage.image = [UIImage imageNamed:@"进行中.png"];
                
                if ([shareFlagString isEqualToString:@"0"]) {
                    //未参加
                    bottomView.fenxiangBtn.hidden=NO;
                    bottomView.fenxiangImage.hidden=NO;
                    [bottomView.fenxiangBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }else if ([shareFlagString isEqualToString:@"1"])
                {
                    bottomView.canjiaImage.hidden=NO;
                    bottomView.canjiaBtn.hidden=NO;
                    bottomView.taolunImage.hidden=NO;
                    bottomView.taolunBtn.hidden=NO;
                    
                    bottomView.canjiaImage.image = [UIImage imageNamed:@"分享.png"];
                    [bottomView.canjiaBtn setTitle:@"分享" forState:UIControlStateNormal];
                    bottomView.taolunImage.image = [UIImage imageNamed:@"讨论.png"];
                    [bottomView.taolunBtn setTitle:@"参与讨论" forState:UIControlStateNormal];
                    urlString = CancelJoinActivity;
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(fenxiangBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    [bottomView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                }
                
            }
            else{
                acDtitleView.IsStartImage.image = [UIImage imageNamed:@"未开始.png"];
                bottomView.canjiaBtn.hidden=NO;
                bottomView.canjiaImage.hidden=NO;
                bottomView.taolunBtn.hidden=NO;
                bottomView.taolunImage.hidden=NO;
                
                [bottomView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                if ([flagString isEqualToString:@"1"]) {
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(canjiaBtnClick) forControlEvents:UIControlEventTouchUpInside];
                }else if ([flagString isEqualToString:@"2"])
                {
                    bottomView.canjiaImage.image = [UIImage imageNamed:@"取消参加.png"];
                    [bottomView.canjiaBtn setTitle:@"取消参加" forState:UIControlStateNormal];
                    
                    urlString = CancelJoinActivity;
                    
                    [bottomView.canjiaBtn addTarget:self action:@selector(buCanjiaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                }else if ([flagString isEqualToString:@"3"])
                {
                    bottomView.hidden = YES;
                    [self addaTabarView];
                    [tabarView.fenxiangBtn addTarget:self action:@selector(bianjiBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                    urlString = cancelPublish;
                    [tabarView.canjiaBtn addTarget:self action:@selector(buFabujiaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [tabarView.taolunBtn addTarget:self action:@selector(taolunBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
            }
            
            [self hotFreeToday:acDtitleView];
            
            
            peopleTable.frame = CGRectMake(0, 224, 320, userListArray.count*JoinH + 44);
            talkTable.frame = CGRectMake(0, peopleTable.frame.origin.y+peopleTable.frame.size.height+10, 320, table2Height);
            shareTable.frame = CGRectMake(0, talkTable.frame.origin.y+talkTable.frame.size.height+10, 320, shareTable2Height);
            UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, peopleTable.frame.origin.y+peopleTable.frame.size.height+10+table2Height-0.5, 320, 0.5)];
            image2.backgroundColor = RGBA(217, 217, 217, 1);
            [myScrollview addSubview:image2];
            
            UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, talkTable.frame.origin.y+talkTable.frame.size.height+10+shareTable2Height-0.5, 320, 0.5)];
            image3.backgroundColor = RGBA(217, 217, 217, 1);
            [myScrollview addSubview:image3];

            CGSize sizeScroll = CGSizeMake(320, shareTable.frame.origin.y + shareTable2Height + 300);
//            [self setContentSize];
            [myScrollview setContentSize:sizeScroll];
            
            
            [peopleTable reloadData];
            [talkTable reloadData];
            [shareTable reloadData];
            
        }
    }
    else if (request.tag==200)
    {
        [self homedown];
    }
    else if (request.tag==300)
    {
        [self homedown];
    }
    else if (request.tag==400)
    {
        [self homedown];
    }
    else if (request.tag==500)
    {
        [self homedown];
    }
    else if (request.tag==600)
    {
        [self homedown];
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"])
        {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"取消成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelPublishNotification" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (request.tag==700)
    {
        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        
        if ([result isEqualToString:@"1"])
        {
            //            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"成功了！哈哈"];
            
            NSDictionary *aVoDic = [dic objectForKey:@"appNewActivityVo"];
            
            FaBuActivityViewController *JoinVC = [[FaBuActivityViewController alloc] init];
            JoinVC.fabuDic = aVoDic;
            
            [self.navigationController pushViewController:JoinVC animated:YES];
        }
    }
    else if (request.tag==800)
    {
        [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"成功删除！"];
        
        [self homedown];
        
    }
    else if (request.tag==900)
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
    else if (request.tag==1000)
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
#pragma mark- xib 创建 addaBottomView
- (void)addaBottomView
{
    //1.新建MyView 2.新建Empty的Xib 3，拖入一个View --选中View修改Class为MyView --设置frame为freedom改变大小  --设置status为none去掉电池  --在使用处导入。h头文件  --- (void)viewDidLoad填写下面代码
    
    //此处 MyView 要改名字
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"BottomBtnView" owner:self options:nil];
    bottomView = [array objectAtIndex:0];
    bottomView.backgroundColor = [UIColor whiteColor];
    //xib坐标一定要和此处一致，不然控件不响应
    
    //    CGFloat screenHeight =  [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"kScreenHeight===%f",kScreenHeight);
    NSLog(@"kScreenWidth===%f",kScreenWidth);
    
    if (kScreenHeight>481)
    {
        //需要继续优化
        bottomView.frame = CGRectMake(0, kScreenHeight-108, 320, 45);
    }else
    {
        
        bottomView.frame = CGRectMake(0, kScreenHeight-108, 320, 45);
        
    }
    [self.view addSubview:bottomView];
}
- (void)addaTabarView
{
    //1.新建MyView 2.新建Empty的Xib 3，拖入一个View --选中View修改Class为MyView --设置frame为freedom改变大小  --设置status为none去掉电池  --在使用处导入。h头文件  --- (void)viewDidLoad填写下面代码
    
    //此处 MyView 要改名字
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"TabartwoView" owner:self options:nil];
    tabarView = [array objectAtIndex:0];
    tabarView.backgroundColor = [UIColor whiteColor];
    //xib坐标一定要和此处一致，不然控件不响应
    
    //    CGFloat screenHeight =  [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"kScreenHeight===%f",kScreenHeight);
    NSLog(@"kScreenWidth===%f",kScreenWidth);
    
    if (kScreenHeight>481)
    {
        //需要继续优化
        tabarView.frame = CGRectMake(0, kScreenHeight-108, 320, 45);
    }else
    {
        
        tabarView.frame = CGRectMake(0, kScreenHeight-108, 320, 45);
        
    }
    [self.view addSubview:tabarView];
}

#pragma mark-setTables
- (void)setTables
{
    peopleTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 224, 320, userListArray.count*JoinH + 44) style:UITableViewStylePlain];
    peopleTable.tag = 100;
    peopleTable.delegate = self;
    peopleTable.dataSource = self;
    peopleTable.scrollEnabled = NO;
//    peopleTable.separatorStyle = NO;
    peopleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myScrollview addSubview:peopleTable];
    
    talkTable = [[UITableView alloc] initWithFrame:CGRectMake(0, peopleTable.frame.origin.y+peopleTable.frame.size.height+10, 320, table2Height) style:UITableViewStylePlain];
    talkTable.tag = 200;
    talkTable.delegate = self;
    talkTable.dataSource = self;
    talkTable.scrollEnabled = NO;
    talkTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    [myScrollview addSubview:talkTable];
    
    shareTable = [[UITableView alloc] initWithFrame:CGRectMake(0, talkTable.frame.origin.y+talkTable.frame.size.height+10, 320, shareTable2Height) style:UITableViewStylePlain];
    shareTable.tag = 300;
    shareTable.delegate = self;
    shareTable.dataSource = self;
    shareTable.scrollEnabled = NO;
    shareTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    [myScrollview addSubview:shareTable];
    
    //    sizeScroll = CGSizeMake(320, shareTable.frame.origin.y + shareTable2Height + 300);
    //    [self setContentSize];
    
    
    
    
}

#pragma mark-tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 200) {
        return discussListArray.count + 1;
        NSLog(@"iscussListArray.count=====%d",discussListArray.count);

    } else if (tableView.tag == 300) {
        return shareListArray.count + 1;
    }
    else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==100) {
        return userListArray.count+1;
        //回退到此暂停
    }else if (tableView.tag == 200)
    {
        if (section==0) {
            return 1;
        }else
        {
            NSArray *listArray1 = [[discussListArray objectAtIndex:section-1] objectForKey:@"commentList"];
            return listArray1.count + 2;
        }
    }else
    {
        if (section==0) {
            return 1;
        }else
        {
            NSArray *listArray = [[shareListArray objectAtIndex:section-1] objectForKey:@"commentList"];
            return listArray.count + 2;
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==100)
    {
        if (indexPath.row==0) {
            return 44;
        }else
        {
            return 88;
        }
    }else if (tableView.tag==200)
    {
        if (indexPath.section==0) {
            return 44;
        }else
        {//有问题 if (kScreenHeight
            if (indexPath.row==0)
            {
                NSDictionary *dic = [discussListArray objectAtIndex:indexPath.section-1];
                CGFloat tentHeight = [[dic objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                
                CGFloat height = 46;
                if (kScreenHeight<481) {
                    height += (tentHeight + 26);
                }else
                {
                    height += (tentHeight + 26);
                }
                return height;
            }else if (indexPath.row==1)
            {
                CGFloat height = 44;
                return height;
            }else
            {//有问题 if (kScreenHeight
                NSDictionary *dic = [[[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"] objectAtIndex:indexPath.row-2];
                
                CGFloat tHeight = [[dic objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                
                CGFloat height = 0;
                if (kScreenHeight<481) {
                    height += (tHeight + 44);
                }else
                {
                    height += (tHeight + 44);
                    
                }
                return height;
            }
        }
        
    }else
    {
        if (indexPath.section==0) {
            return 44;
        }else
        {
            if (indexPath.row==0)
            {//有问题 if (kScreenHeight
                CGFloat height = 46;
                NSDictionary *dic = [shareListArray objectAtIndex:indexPath.section-1];
                CGFloat tentHeight = [[dic objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                if (kScreenHeight<481) {
                    height += (tentHeight + 26);
                }else
                {
                    height += (tentHeight + 26);
                    
                }
                return height;
            }else if (indexPath.row==1)
            {
                CGFloat height = 44;
                return height;
            }else
            {
                NSArray *mentListArray = [[shareListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
                NSDictionary *dic = [mentListArray objectAtIndex:indexPath.row-2];
                CGFloat entHeigh = [[dic objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                
                CGFloat height = 0;
                if (kScreenHeight<481) {
                    height += (entHeigh + 44);
                }else
                {
                    height += (entHeigh + 44);
                }
                
                return height;
                
            }
            
        }
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [pingView removeFromSuperview];
    if (tableView.tag==100) {
        if (indexPath.row==0)
        {
            GetJoinNumViewController *getVC = [[GetJoinNumViewController alloc] init];
            getVC.activityId = idString;
            getVC.displayPhone = @"显示";
            [self.navigationController pushViewController:getVC animated:YES];
        }
    }else if (tableView.tag==200)
    {
        if (indexPath.section==0&&indexPath.row==0)
        {
            GetDiscussNumViewController *getVC = [[GetDiscussNumViewController alloc] init];
            getVC.activityId = idString;
            [self.navigationController pushViewController:getVC animated:YES];
        }
        
    }else if (tableView.tag==300)
    {
        if (indexPath.section==0&&indexPath.row==0)
        {
            GetShareLisViewController *getVC = [[GetShareLisViewController alloc] init];
            getVC.activityId = idString;
            [self.navigationController pushViewController:getVC animated:YES];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==100) {
        if (indexPath.row==0) {
//            static NSString *cellIdentifier = @"cellIdentiifer";
//            PeopleNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            PeopleNumTableViewCell *cell;
            if (!cell)
            {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PeopleNumTableViewCell" owner:nil options:nil];
                
                cell = (PeopleNumTableViewCell *)[array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userLabel.text = [NSString stringWithFormat:@"参加人数（%@）",numString];
            return cell;
            
        }else
        {
//            static NSString *cellIdentifier = @"cellIdentiifer1";
//            JoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            JoinTableViewCell *cell;
            if (!cell)
            {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"JoinTableViewCell" owner:nil options:nil];
                
                cell = (JoinTableViewCell *)[array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSDictionary *userListDic = [userListArray objectAtIndex:indexPath.row-1];
            NSString *ImageStr=[[userListArray objectAtIndex:indexPath.row-1] objectForKey:@"userPic"];
            NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
            [cell.userPic setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maomao.png"]];
            cell.time.text = [NSString stringWithFormat:@"%@",[userListDic objectForKey:@"time"]];
            cell.actNum.text = [NSString stringWithFormat:@"已参加%@次活动",[userListDic objectForKey:@"actNum"]];
            if ([self.displayPhone isEqualToString:@"显示"])
            {
                cell.actNum.hidden = YES;
                UIImageView *phoneImag = [[UIImageView alloc]initWithFrame:CGRectMake(60, 35, 14, 14)];
                phoneImag.image = [UIImage imageNamed:@"电话_.png"];
                UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 32, 140, 20)];
                phoneLabel.font = [UIFont systemFontOfSize:14];
                phoneLabel.textColor = RGBA(102, 102, 102, 1);
                phoneLabel.text = [userListDic objectForKey:@"userPhone"];
                [cell.contentView addSubview:phoneImag];
                [cell.contentView addSubview:phoneLabel];
            }
            
            cell.content.text = [NSString stringWithFormat:@"%@",[userListDic objectForKey:@"content"]];
            cell.level.text = [NSString stringWithFormat:@"%@",[userListDic objectForKey:@"name"]];
            //开始
            CGSize titleSize = [cell.level.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(130, 20)];
            UIImageView *sexbg  = [[UIImageView alloc] initWithFrame:CGRectMake(titleSize.width+5, 4, 27, 12)];
            [cell.sexView addSubview:sexbg];
            UIImageView *sexArrow  = [[UIImageView alloc] initWithFrame:CGRectMake(sexbg.frame.origin.x+3, 7, 6, 6)];
            [cell.sexView addSubview:sexArrow];
            UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(sexArrow.frame.origin.x +sexArrow.frame.size.width, 4, 18, 12)];
            ageLabel.textColor = [UIColor whiteColor];
            ageLabel.textAlignment = NSTextAlignmentCenter;
            ageLabel.font = [UIFont systemFontOfSize:10.0];
            [cell.sexView addSubview:ageLabel];
            ageLabel.text = [userListDic objectForKey:@"age"];
            
            if ([[userListDic objectForKey:@"sex"] isEqualToString:@"0"]) {
                sexbg.image = [UIImage imageNamed:@"女.png"];
                sexArrow.image = [UIImage imageNamed:@"女箭头.png"];
                
            }else
            {
                sexbg.image = [UIImage imageNamed:@"男.png"];
                sexArrow.image = [UIImage imageNamed:@"男箭头.png"];
            }
            //结束
            return cell;
            
        }
    }else if (tableView.tag==200)
    {
        if (indexPath.section==0) {
//            static NSString *cellIdentifier = @"cellIdentiifer";
//            PeopleNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            PeopleNumTableViewCell *cell;
            if (!cell)
            {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PeopleNumTableViewCell" owner:nil options:nil];
                
                cell = (PeopleNumTableViewCell *)[array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSLog(@"discussNumString======%@",discussNumString);
            cell.userLabel.text = [NSString stringWithFormat:@"参与讨论（%@）",discussNumString];
            return cell;
            
        }else
        {
            if (indexPath.row==0)
            {
                static NSString *cellIdentifier = @"cellIdentiifer";
//                PinglunCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                PinglunCell *cell;
                if (!cell)
                {
                    cell = [[PinglunCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSDictionary *dic = [discussListArray objectAtIndex:indexPath.section-1];
                
                NSString *ImageStr=[dic objectForKey:@"userPic"];
                NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
                [cell.userPic setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maomao.png"]];
                
                cell.level.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                //开始
                CGSize titleSize = [cell.level.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(130, 20)];
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
                contentHeight = [cell.content.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                //delType   逻辑需要修改
                NSLog(@"contentHeight====5===%f",contentHeight);
                if ([[dic objectForKey:@"delType"] isEqualToString:@"0"]) {
                    cell.deleteBtn.hidden=YES;
                    cell.deletImage.hidden = YES;
                }
                cell.deleteBtn.hidden=YES;
                cell.deletImage.hidden = YES;
                
                //conten
                cell.content.frame = CGRectMake(60, 34, 190, contentHeight);
                
                //坐标问题
                cell.pinglunBtn.frame = CGRectMake(265, contentHeight+35, 49, 45);
                cell.pingImage.frame = CGRectMake(291, contentHeight+45, 19, 15);
                cell.imageLine.frame = CGRectMake(0, contentHeight+71.5, 320, 0.5);
                
                cell.pinglunBtn.tag = indexPath.section - 1;
                
                
                [cell.pinglunBtn addTarget:self action:@selector(pinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            }else if (indexPath.row==1)
            {
//                static NSString *cellIdentifier = @"cellIdentiifer";
//                DianZanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                DianZanTableViewCell *cell;
                if (!cell)
                {
                    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DianZanTableViewCell" owner:nil options:nil];
                    
                    cell = (DianZanTableViewCell *)[array objectAtIndex:0];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                NSDictionary *dic = [discussListArray objectAtIndex:indexPath.section-1];
//                commentListArray = [[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
                
                cell.dianZanNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"zanString"]];
                
                return cell;
            }else
            {
                static NSString *cellIdentifier = @"cellIdentiifer";
//                TalkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                TalkCell *cell;
                if (!cell)
                {
                    cell = [[TalkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    
                }
                
                if (indexPath.row==2) {
                    cell.talkImag.hidden = NO;
                }

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                commentListArray = [NSMutableArray arrayWithCapacity:0];

                NSArray *entListArray = [[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
                
                NSDictionary *dic = [entListArray objectAtIndex:indexPath.row-2];
                
                NSString *ImageStr=[dic objectForKey:@"userPic"];
                NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
                [cell.userPic setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maomao.png"]];
                
                cell.level.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                
                //开始
                CGSize titleSize = [cell.level.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(130, 20)];
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
                
                contentHeight = [cell.content.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                
                cell.content.frame = CGRectMake(80, 34, 200, contentHeight);
                cell.imageLine.frame = CGRectMake(30, cell.content.frame.size.height+43.5, 320, 0.5);
                
                //讨论评论
                NSString *commendId = [dic objectForKey:@"id"];
                NSLog(@"commendId====%@",commendId);
                
                NSString *commenddelType = [dic objectForKey:@"delType"];
                if ([commenddelType isEqualToString:@"1"]) {
                    cell.deleteBtn.tag = indexPath.row-2+1000000;
                    
                    NSLog(@"cell.deleteBtn.tag====%d",cell.deleteBtn.tag);
                    [cell.deleteBtn addTarget:self action:@selector(deleteTalkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                }else
                {
                    cell.deleteBtn.hidden = YES;
                    cell.deletImage.hidden = YES;
                }
                
                
                return cell;
                
                
            }
            
        }
        
    }else
    {
        if (indexPath.section==0) {
//            static NSString *cellIdentifier = @"cellIdentiifer";
//            PeopleNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            PeopleNumTableViewCell *cell;
            if (!cell)
            {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PeopleNumTableViewCell" owner:nil options:nil];
                
                cell = (PeopleNumTableViewCell *)[array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSLog(@"shareNumString===%@",shareNumString);
            cell.userLabel.text = [NSString stringWithFormat:@"分享（%@）",shareNumString];
            return cell;
            
        }else
        {
            //            shareCommentListArray = [[shareListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
            
            //            NSLog(@"shareCommentListArray====%d",shareCommentListArray.count);
            if (indexPath.row==0)
            {
                static NSString *cellIdentifier = @"cellIdentiifer";
//                PinglunCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                PinglunCell *cell;
                if (!cell)
                {
                    cell = [[PinglunCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSDictionary *dic = [shareListArray objectAtIndex:indexPath.section-1];
                
                NSString *ImageStr=[dic objectForKey:@"userPic"];
                NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
                [cell.userPic setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maomao.png"]];
                
                cell.level.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                //开始
                CGSize titleSize = [cell.level.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(130, 20)];
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
                shareContentHeight = [cell.content.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                ////有问题 delType  <null>指针为空时需要判断处理
                if ([[dic objectForKey:@"delType"] isEqualToString:@"0"]) {
                    cell.deleteBtn.hidden=YES;
                    cell.deletImage.hidden = YES;
                }
                //                cell.deleteBtn.hidden=YES;
                //                cell.deletImage.hidden = YES;
                
                cell.content.frame = CGRectMake(60, 34, 190, shareContentHeight);
                // 坐标 问题
                cell.pinglunBtn.frame = CGRectMake(265, shareContentHeight+35, 49, 45);
                cell.pingImage.frame = CGRectMake(291, shareContentHeight+45, 19, 15);
                cell.imageLine.frame = CGRectMake(0, shareContentHeight+71.5, 320, 0.5);
                
                // 先隐藏，最后开发
                cell.deleteBtn.hidden = YES;
                cell.deletImage.hidden = YES;
                
                cell.pinglunBtn.tag = indexPath.section - 1;
                
                [cell.pinglunBtn addTarget:self action:@selector(sharePinglunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else if (indexPath.row==1)
            {
//                static NSString *cellIdentifier = @"cellIdentiifer";
//                DianZanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                DianZanTableViewCell *cell;
                if (!cell)
                {
                    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DianZanTableViewCell" owner:nil options:nil];
                    
                    cell = (DianZanTableViewCell *)[array objectAtIndex:0];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                NSDictionary *dic = [shareListArray objectAtIndex:indexPath.section-1];
                
                cell.dianZanNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"zanString"]];
                
                return cell;
            }else
            {
                static NSString *cellIdentifier = @"cellIdentiifer";
//                TalkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                TalkCell *cell;
                if (!cell)
                {
                    cell = [[TalkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    
                }
                
                if (indexPath.row==2) {
                    cell.talkImag.hidden = NO;
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
                NSDictionary *dic = [[[shareListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"] objectAtIndex:indexPath.row-2];
                
                NSString *ImageStr=[dic objectForKey:@"userPic"];
                NSURL *imageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommunityImageServer,ImageStr]];
                [cell.userPic setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maomao.png"]];
                
                cell.level.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                //开始
                CGSize titleSize = [cell.level.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(130, 20)];
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
                NSString *delTypeSt = [dic objectForKey:@"delType"];
                if ([delTypeSt isEqualToString:@"0"]) {
                    cell.deleteBtn.hidden=YES;
                    cell.deletImage.hidden = YES;
                }
                
                
                cell.time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]];
                cell.content.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
                
                shareContentHeight = [cell.content.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                
                cell.content.frame = CGRectMake(80, 34, 200, shareContentHeight);
                cell.imageLine.frame = CGRectMake(30, cell.content.frame.size.height+43.5, 320, 0.5);
                //                NSArray *arrayl = [[shareListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
                //                idSting_mhp = [[arrayl objectAtIndex:indexPath.row-2] objectForKey:@"id"];
                //                NSLog(@"idSt===%@=%d",idSting_mhp,[idSting_mhp intValue]);
                //                cell.deleteBtn.tag = [idSting_mhp intValue];
                [cell.deleteBtn addTarget:self action:@selector(MHPeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
                
                
            }
            
        }
        
    }
}

-(void)MHPeleteBtnClick:(UIButton*)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    //然后使用indexPathForCell方法，就得到indexPath了~
    NSIndexPath *indexPath = [shareTable indexPathForCell:cell];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要删除此条评论吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    NSArray *array1 = [[shareListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"];
    
    deletePingString = [[array1 objectAtIndex:indexPath.row-2] objectForKey:@"id"];
    NSLog(@"deletePingString===%@====",deletePingString);
    
    alert.tag = 1001;
    alert.delegate = self;
    [alert show];
    
}
- (void)sharePinglunBtnClick:(UIButton *)btn
{
    CGFloat zanHeight = 44;
    //lineHeight 第N个讨论表格总高度
    CGFloat lineHeight = 44;
    for (int i=0; i<btn.tag + 1; i++)
    {
        CGFloat sectionHeight = [[[shareListArray objectAtIndex:i] objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height +70;
        lineHeight = lineHeight + sectionHeight +zanHeight;
        NSLog(@"lineHeight==1112=%f",lineHeight);
        NSArray *commentListA = [[shareListArray objectAtIndex:i] objectForKey:@"commentList"];
        int k = [commentListA count];
        //此处判断很重要
        if (k >0) {
            for (int j=0; j<k; j++)
            {
                NSString *content = [[commentListA objectAtIndex:j] objectForKey:@"content"];
                CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(238, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                CGFloat cellHeight1 = cellHeight + 44;
                lineHeight = lineHeight + cellHeight1;
                NSLog(@"lineHeight==222=%f",lineHeight);
                
            }
            
        }
    }
    
    NSArray *duoyuArray = [[shareListArray objectAtIndex:btn.tag] objectForKey:@"commentList"];
    int q = [duoyuArray count];
    if (q >0) {
        for (int j=0; j<q; j++)
        {
            NSString *content = [[duoyuArray objectAtIndex:j] objectForKey:@"content"];
            CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(238, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
            CGFloat duoyuHeight = cellHeight + 44;
            lineHeight = lineHeight - duoyuHeight;
            NSLog(@"lineHeight==222=%f",lineHeight);
            
        }
        
    }
    
    
    
    NSLog(@"123123123=====");
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"PinglunView" owner:self options:nil];
    pingView = [array objectAtIndex:0];
    pingView.frame = CGRectMake(103,lineHeight+shareTable.frame.origin.y-44-35, 180, 39);
    //判断是否点赞
    
    pingView.zanBtn.tag = btn.tag;
    pingView.pingBtn.tag = btn.tag;
    
    [pingView.zanBtn addTarget:self action:@selector(shareZanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pingView.pingBtn addTarget:self action:@selector(sharePingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [myScrollview addSubview:pingView];
    zanFlagString = [[shareListArray objectAtIndex:btn.tag] objectForKey:@"zanFlag"];
    NSLog(@"zanFlagString===%@",zanFlagString);
    if ([zanFlagString isEqualToString:@"1"]) {
        //        pingView.zanLabel.text = @"赞";
        [pingView.zanBtn setBackgroundImage:[UIImage imageNamed:@"zan.png"] forState:UIControlStateNormal];
    }else
    {
        //        pingView.zanLabel.text = @"取消赞";
        [pingView.zanBtn setBackgroundImage:[UIImage imageNamed:@"quxiaozan.png"] forState:UIControlStateNormal];
        
    }
    
}//111111111111111   111111
#pragma mark-AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (alertView.tag==1000)
        {
            [self cancleHomedown];
        }else if (alertView.tag>100000 && alertView.tag<10000000)
        {
            //            NSLog(@"alertView.tag====%d",alertView.tag);
            
            [self pngLunDeleteBtnClick:alertView];
            
        }
        else if (alertView.tag>10000000)
        {
            //            NSLog(@"alertView.tag====%d",alertView.tag);
            
            //            [self sharetalkDeleteBtnClick:alertView];
            
        }else if (alertView.tag==1001)
        {
            
            [self sharetalkDeleteBtnClick:alertView];
            
        }
        
        
        else
        {
            [self confirmDeleteBtnClick:alertView];
        }
    }
}

- (void)deleteBtnClick:(UIButton *)btn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要删除此条评论吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = btn.tag;
    NSLog(@"btn.tag====%d",btn.tag);
    alert.delegate = self;
    [alert show];
    
}
- (void)deleteTalkBtnClick:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)btn.superview.superview;
    //然后使用indexPathForCell方法，就得到indexPath了~
    NSIndexPath *indexPath = [talkTable indexPathForCell:cell];
    
    talkidstring = [[[[discussListArray objectAtIndex:indexPath.section-1] objectForKey:@"commentList"] objectAtIndex:indexPath.row-2] objectForKey:@"id"];


    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要删除此条评论吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = btn.tag;
    NSLog(@"btn.tag====%d",btn.tag);
    alert.delegate = self;
    [alert show];
    
} //00000

- (void)pngLunDeleteBtnClick:(UIAlertView *)aler
{
    NSLog(@"idstr==11=");
//    NSString *idstring = [[commentListArray objectAtIndex:aler.tag-1000000] objectForKey:@"id"];
//    NSLog(@"idstr===%@",idstring);
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:talkidstring,@"commentId", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:DeleteComment];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        
        request.tag=900;
        request.delegate=self;
        [request startAsynchronous];
    }
    [pingView removeFromSuperview];
    
}


- (void)sharetalkDeleteBtnClick:(UIAlertView *)aler
{
    NSLog(@"deletePingString===%@",deletePingString);
    //    NSLog(@"idString===%d",shareCommentListArray.count);
    
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
        
        request.tag=1000;
        request.delegate=self;
        [request startAsynchronous];
    }
    [pingView removeFromSuperview];
    
}

- (void)confirmDeleteBtnClick:(UIAlertView *)aler
{
    NSString *idstring = [[discussListArray objectAtIndex:aler.tag] objectForKey:@"id"];
    NSLog(@"idString===%@",idstring);
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"discussId", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:Deletediscuss];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        
        request.tag=800;
        request.delegate=self;
        [request startAsynchronous];
    }
    [pingView removeFromSuperview];
    
}


- (void)pinglunBtnClick:(UIButton *)btn
{
    CGFloat zanHeight = 44;
    //lineHeight 第N个讨论表格总高度
    CGFloat lineHeight = 44;
    for (int i=0; i<btn.tag + 1; i++)
    {
        CGFloat sectionHeight = [[[discussListArray objectAtIndex:i] objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:NSLineBreakByCharWrapping].height +70;
        lineHeight = lineHeight + sectionHeight +zanHeight;
        NSLog(@"lineHeight==1112=%f",lineHeight);
        NSArray *commentListA = [[discussListArray objectAtIndex:i] objectForKey:@"commentList"];
        int k = [commentListA count];
        //此处判断很重要
        if (k >0) {
            for (int j=0; j<k; j++)
            {
                NSString *content = [[commentListA objectAtIndex:j] objectForKey:@"content"];
                CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(238, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
                CGFloat cellHeight1 = cellHeight + 44;
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
            CGFloat cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(238, 1000) lineBreakMode:NSLineBreakByCharWrapping].height;
            CGFloat duoyuHeight = cellHeight + 44;
            lineHeight = lineHeight - duoyuHeight;
            NSLog(@"lineHeight==222=%f",lineHeight);
            
        }
        
    }
    
    
    
    NSLog(@"123123123=====");
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"PinglunView" owner:self options:nil];
    pingView = [array objectAtIndex:0];
    pingView.frame = CGRectMake(103,lineHeight+talkTable.frame.origin.y-44-35, 180, 39);
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
    [message_field becomeFirstResponder];
    message_field.placeholder=@"请输入评论";
    [send_view addSubview:message_field];
    
    
//    [pingView removeFromSuperview];
    
}
- (void)sharePingBtnClick:(UIButton *)btn
{
    send_view =[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49, 320, 49)];
    send_view.backgroundColor=RGBA(231, 231, 231, 231);
    [self.view addSubview:send_view];
    UIButton *sendbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sendbtn.frame=CGRectMake(240, 6, 74, 34);
    sendbtn.layer.cornerRadius = 4;
    sendbtn.layer.masksToBounds = YES;
    //    sendbtn.backgroundColor = [UIColor blueColor];
    [sendbtn setTitle:@"发送" forState:UIControlStateNormal];
    sendbtn.backgroundColor = RGBA(0, 122, 255, 1);
    
    [sendbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendbtn addTarget:self action:@selector(shareSendbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [send_view addSubview:sendbtn];
    
    message_field=[[UITextField alloc] initWithFrame:CGRectMake(5, 6, 220, 36)];
    message_field.borderStyle=UITextBorderStyleRoundedRect;
    message_field.delegate=self;
    [message_field becomeFirstResponder];
    message_field.placeholder=@"请输入评论";
    [send_view addSubview:message_field];
    [pingView removeFromSuperview];
    
}
- (void)shareSendbtnClick
{
    [self sharePinglunRequest:pingView.pingBtn];
    
    [message_field resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [send_view removeFromSuperview];
    [UIView commitAnimations];
    
}


- (void)sendbtnClick
{
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
- (void)sharePinglunRequest:(UIButton *)btn
{
    NSString *idstring = [[shareListArray objectAtIndex:btn.tag] objectForKey:@"id"];
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
        
        request.tag=500;
        
        request.delegate=self;
        [request startAsynchronous];
    }
    
}

- (void)pinglunRequest:(UIButton *)btn
{
    NSString *idstring = [[discussListArray objectAtIndex:btn.tag] objectForKey:@"id"];
    NSString *contentString = message_field.text;
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"discussId",contentString,@"content", nil];
    
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:Talkaddcomment];
        
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
- (void)zanBtnClick:(UIButton *)btn
{
    [pingView removeFromSuperview];

    NSString *idstring = [[discussListArray objectAtIndex:btn.tag] objectForKey:@"id"];
    NSLog(@"idString===%@",idstring);
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"discussId", nil];
    
    if ([zanFlagString isEqualToString:@"1"]) {
        user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"discussId", nil];
    }else
    {
        user = [[NSDictionary alloc]initWithObjectsAndKeys:idstring,@"id", nil];
    }
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:TalkDianzan];
        if ([zanFlagString isEqualToString:@"1"]) {
            url = [NSURL URLWithString:TalkDianzan];
        }else
        {
            url = [NSURL URLWithString:TalkDeleteDianzan];
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
    
}

- (void)shareZanBtnClick:(UIButton *)btn
{
    NSString *idstring = [[shareListArray objectAtIndex:btn.tag] objectForKey:@"id"];
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
        
        request.tag=400;
        request.delegate=self;
        [request startAsynchronous];
    }
    [pingView removeFromSuperview];
    
}
- (void)hotFreeToday:(ActivityDetailTitleView *)titleView
{
    NSString *hot=[detailDic objectForKey:@"hot"];
    NSString *free=[detailDic objectForKey:@"free"];
    NSString *today=[detailDic objectForKey:@"today"];
    NSString *price=[detailDic objectForKey:@"price"];
    NSLog(@"hot==%@free==%@today==%@price==%@",hot,free,today,price);
    
    
    acDtitleView.hotBtn.hidden = YES;
    acDtitleView.freeBtn.hidden = YES;
    acDtitleView.todayBtn.hidden = YES;
    
    //%@元/人 标签自适应
    acDtitleView.hotBtn.backgroundColor = hongRGBA;
    acDtitleView.freeBtn.backgroundColor = lanRGBA;
    acDtitleView.todayBtn.backgroundColor = lvRGBA;
    
    NSString *moneyS = [NSString stringWithFormat:@"%@元/人",price];
    NSString *moneyLongS = [NSString stringWithFormat:@"%@元/人人",price];
    CGSize moneySize = [moneyLongS sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 19)];
    CGFloat moneyWide = moneySize.width;
    
    UILabel *hotLa = [[UILabel alloc] init];
    hotLa.textAlignment = NSTextAlignmentCenter;
    hotLa.text = @"热门";
    hotLa.font = [UIFont systemFontOfSize:12.0f];
    hotLa.layer.cornerRadius = 2;
    hotLa.backgroundColor = hongRGBA;
    [acDtitleView addSubview:hotLa];
    
    
    UILabel *moneyLa = [[UILabel alloc] init];
    moneyLa.textAlignment = NSTextAlignmentCenter;
    moneyLa.text = moneyS;
    moneyLa.font = [UIFont systemFontOfSize:12.0f];
    moneyLa.layer.cornerRadius = 2;
    moneyLa.layer.masksToBounds = YES;
    moneyLa.backgroundColor = qianRGBA;
    [acDtitleView addSubview:moneyLa];
    
    UILabel *todayLa = [[UILabel alloc] init];
    todayLa.textAlignment = NSTextAlignmentCenter;
    todayLa.text = @"今天";
    todayLa.font = [UIFont systemFontOfSize:12.0f];
    todayLa.layer.cornerRadius = 2;
    todayLa.backgroundColor = hongRGBA;
    [acDtitleView addSubview:todayLa];
    
    
    if ([hot isEqualToString:@"1"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        acDtitleView.hotBtn.hidden = NO;
        acDtitleView.freeBtn.hidden = NO;
        acDtitleView.todayBtn.hidden = NO;
        [acDtitleView.hotBtn setTitle:@"热门" forState:UIControlStateNormal];
        [acDtitleView.freeBtn setTitle:@"免费" forState:UIControlStateNormal];
        [acDtitleView.todayBtn setTitle:@"今天" forState:UIControlStateNormal];
        
    }else if ([hot isEqualToString:@"0"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        acDtitleView.hotBtn.hidden = NO;
        acDtitleView.freeBtn.hidden = NO;
        acDtitleView.hotBtn.backgroundColor = lanRGBA;
        acDtitleView.freeBtn.backgroundColor = lvRGBA;
        [acDtitleView.hotBtn setTitle:@"免费" forState:UIControlStateNormal];
        [acDtitleView.freeBtn setTitle:@"今天" forState:UIControlStateNormal];
        
    }else if ([hot isEqualToString:@"1"]&&![price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        
        hotLa.frame = CGRectMake(126, 134, 40, 19);
        moneyLa.frame = CGRectMake(176, 134, moneyWide, 19);
        todayLa.frame = CGRectMake(186+moneyWide, 134, 40, 19);
        
        
    }else if ([hot isEqualToString:@"1"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"0"]) {
        acDtitleView.hotBtn.hidden = NO;
        acDtitleView.freeBtn.hidden = NO;
        [acDtitleView.hotBtn setTitle:@"热门" forState:UIControlStateNormal];
        [acDtitleView.freeBtn setTitle:@"免费" forState:UIControlStateNormal];
        
    }else if ([hot isEqualToString:@"0"]&&![price isEqualToString:@"0"]&&[today isEqualToString:@"1"]) {
        [acDtitleView.hotBtn setTitle:[NSString stringWithFormat:@"%@元/人",price] forState:UIControlStateNormal];
        [acDtitleView.freeBtn setTitle:@"今天" forState:UIControlStateNormal];
        
        moneyLa.frame = CGRectMake(126, 134, moneyWide, 19);
        todayLa.frame = CGRectMake(136+moneyWide, 134, 40, 19);
        
        
    }else if ([hot isEqualToString:@"1"]&&![price isEqualToString:@"0"]&&[today isEqualToString:@"0"]) {
        
        hotLa.frame = CGRectMake(126, 134, 40, 19);
        moneyLa.frame = CGRectMake(176, 134, moneyWide, 19);
        
    }else if ([hot isEqualToString:@"0"]&&[price isEqualToString:@"0"]&&[today isEqualToString:@"0"]) {
        acDtitleView.hotBtn.hidden = NO;
        acDtitleView.hotBtn.backgroundColor = lanRGBA;
        [acDtitleView.hotBtn setTitle:@"免费" forState:UIControlStateNormal];
        
    }else {
        
        moneyLa.frame = CGRectMake(126, 134, moneyWide, 19);
    }
    //%@元/人 标签自适应
    
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


//打电话
- (void)telBtn
{
    //NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //结束电话之后会进入联系人列表
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",acDtitleView.telepLabel.text]; //而这个方法则打电话前先弹框,打完电话之后回到程序中
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    
}

- (void)detailBtnPush{
    AcDetailThirdViewController *controller = [[AcDetailThirdViewController alloc] init];
    controller.idStr = self.idStr;
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end