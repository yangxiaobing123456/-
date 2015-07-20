//
//  WYJF_WYNewController.m
//  Community
//
//  Created by wutao on 15-1-14.
//  Copyright (c) 2015年 Hua Men. All rights reserved.
//

#import "WYJF_WYNewController.h"

@interface WYJF_WYNewController ()

@end

@implementation WYJF_WYNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"缴费确认";

    qianbaoBool=NO;
    jifenBool = NO;
    yinlianBool = YES;

    //创建一个手势
    UITapGestureRecognizer *gestureRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:gestureRecgnizer];

    wuyeScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    if (self.view.frame.size.height<500) {
        wuyeScrollView.contentSize = CGSizeMake(320, 568);
    }
    [self.view addSubview:wuyeScrollView];
    // Do any additional setup after loading the view.
    titleArray = [NSArray arrayWithObjects:@"小区：",@"幢号：",@"单元：",@"房号：",@"缴费时间：",@"缴费金额：", nil];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4.5, 320, 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    lineLabel.alpha = 1;
    [wuyeScrollView addSubview:lineLabel];

    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, 320, 300) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.tag = 100;
    //取消表格的滑动效果
    listTableView.userInteractionEnabled = NO;
    [wuyeScrollView addSubview:listTableView];
    UILabel *lineLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 304.5, 15, 0.5)];
    lineLabel2.backgroundColor = [UIColor lightGrayColor];
    lineLabel2.alpha = 0.5;
    [wuyeScrollView addSubview:lineLabel2];

    
    
    
    [self customBackButton:self];
    
    [self loadRoomInfo];
    
    [self showListQianBao];
    
    [self submmitFee];

    
}

//获取积分
-(void)showListQianBao{
    //[[CommunityIndicator sharedInstance] startLoading];
    //sleep(5);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId", nil];
    
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:maShangQiang];
        
        ASIHTTPRequest *requestm = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [requestm addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [requestm addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        [requestm addRequestHeader:@"Authorization" value:str];
        [requestm setRequestMethod:@"POST"];
        [requestm setPostBody:tempJsonData];
        requestm.tag=101;
        requestm.delegate=self;
        [requestm startAsynchronous];
        
    }
}
//---
-(void)requestFailed:(ASIHTTPRequest *)request
{
    wallet = [NSString stringWithFormat:@"%d",0];
    integral = [NSString stringWithFormat:@"%d",0];

    [[CommunityIndicator sharedInstance]hideIndicator:YES];
    [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"服务器挂了sorry!"];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==101)
    {
        NSLog(@"--tag==101--%@",request.responseString);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:Nil];
        
        wallet = [dic objectForKey:@"wallet"];
        integral = [dic objectForKey:@"integral"];
        myView.jifenLabel.text = [NSString stringWithFormat:@"现有益钱包%@元",wallet];
        myView.jifeMoneyLabel.text = [NSString stringWithFormat:@"现有益积分%@分",integral];
        NSLog(@"--wallet11--%@-%@-",wallet,integral);


    }
    
}

- (void)submmitFee
{
//    self.title = @"缴费确认";
//    buttonFee.hidden = YES;
//    [buttonFee removeFromSuperview];

    [self setAllFrame];
    
    wuyeScrollView.contentSize = CGSizeMake(320, 900);
    wuyeScrollView.contentOffset = CGPointMake(0, 255);

}
- (void)setAllFrame
{
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 319.5, 320, 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    lineLabel.alpha = 0.5;
    [wuyeScrollView addSubview:lineLabel];

    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"WYJF_moneyView" owner:self options:nil];
    myView = [array objectAtIndex:0];
    //xib坐标一定要和此处一致，不然控件不响应
    myView.frame = CGRectMake(0, 320, 320, 520);
    [wuyeScrollView addSubview:myView];
    
    if ([self isBlankString:wallet]) {
        wallet = [NSString stringWithFormat:@"%d",0];
    }
    if ([self isBlankString:integral]) {
        integral = [NSString stringWithFormat:@"%d",0];
    }

    
    myView.jifenLabel.text = [NSString stringWithFormat:@"现有益钱包%@元",wallet];
    myView.jifeMoneyLabel.text = [NSString stringWithFormat:@"现有益积分%@分",integral];
    NSLog(@"--wallet--%@-%@-",wallet,integral);
    myView.textField1.delegate = self;
    myView.textField2.delegate = self;

    myView.payLabel.text = [NSString stringWithFormat:@"%.2f",self.money -[myView.textField1.text floatValue] - [strT floatValue]];


    myView.confirmBtn.alpha = 0.5;
    [myView.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [myView.qianbaoBtn addTarget:self action:@selector(qianbaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [myView.jifenBtn addTarget:self action:@selector(jifenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [myView.yinlianBtn addTarget:self action:@selector(yinlianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //Btn 确认支付
    [myView.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];


}
//判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    else if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (void)addAlertView
{
    if ([myView.textField1.text floatValue]>[wallet floatValue]) {
        [myView.textField1 setText:@""];
        [myView.textField2 setText:@""];
        //[myView.textField1.text floatValue]=[wallet floatValue];
       // myView.textField1.text = [NSString stringWithFormat:@"%f",[wallet floatValue]];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择合适的益钱包金额" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alert show];
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"输入金额错误！"];
        return;
        
    }
    if ([myView.textField2.text floatValue]>[integral floatValue]) {
        //myView.textField1.text = [NSString stringWithFormat:@"%f",[integral floatValue]];
        [myView.textField1 setText:@""];
        [myView.textField2 setText:@""];
         [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"输入积分错误！"];

//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择合适的益积分" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alert show];
        return;
        
    }
 
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==0) {
        return;
    }
}
//确认支付
-(void)commitBtnClick
{
    if ([self isBlankString:myView.textField1.text]||!qianbaoBool) {
        myView.textField1.text = @"0";
    }
    if ([self isBlankString:myView.textField2.text]||!jifenBool) {
        myView.textField2.text = @"0";
    }

//    if (!qianbaoBool) {
//        myView.textField1.text = @"0";
//    }
//    if (!jifenBool) {
//        myView.textField2.text = @"0";
//
//    }
    
    if ([myView.textField1.text floatValue]>[wallet floatValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择合适的益钱包金额" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;

    }
    if ([myView.textField2.text floatValue]>[integral floatValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择合适的益积分" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;

    }

    

    [self caculateHowMuchMoney];

//    WYJF_PayController *payController = [WYJF_PayController new];
//    [self.navigationController pushViewController:payController animated:YES];
    if (yinlianBool==NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选中支付方式" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self uppay];
    }
}
//支付  roomFeeStr
- (void)uppay
{
    [[CommunityIndicator sharedInstance] startLoading];
    [self caculateHowMuchMoney];
    
    [self canclePayMoney];
    
    int nowFeeTime = [self.timestring intValue];
    NSString *value4 =[NSString stringWithFormat:@"%d",nowFeeTime/10000];
    NSString *value5 =[NSString stringWithFormat:@"%d",nowFeeTime%10000/100];
    NSString *value6 =[NSString stringWithFormat:@"%d",nowFeeTime%10000%100];
    if ([value5 intValue]<10) {
        value5 = [NSString stringWithFormat:@"0%@",value5];
    }
    if ([value6 intValue]<10) {
        value6 = [NSString stringWithFormat:@"0%@",value6];
    }
    
    self.endStr = [NSString stringWithFormat:@"%@%@%@",value4,value5,value6];

    NSString *str=[NSString stringWithFormat:@"%0.2f",self.money];
    NSString *subStr=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
    
//    double payD = [self.roomFeeStr doubleValue]*100;
//    int payInt = (int)payD;
// [NSString stringWithFormat:@"%d",payInt],@"pay",
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld",_room.roomId],@"id",
                          [NSString stringWithFormat:@"%d", _month],@"month",
                          @"3",@"payType",
                          [NSString stringWithFormat:@"%@", subStr],@"pai",
                          self.startStr,@"startMonth",
                          [NSString stringWithFormat:@"%@", myView.textField1.text],@"wallet",
                          self.endStr,@"endMonth",
                          [NSString stringWithFormat:@"%@", myView.textField2.text],@"integral",
                          [NSString stringWithFormat:@"%d",1],@"productType",nil];
    

    NSLog(@"dict====%@",dict);
    
    [[HttpClientManager sharedInstance] getOrderNumberWithDict:dict
                                                      complete:^(BOOL success, GetOrderNumberResponse *resp) {
                                                          if (success && resp.result == RESPONSE_SUCCESS) {
                                                              [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                              
                                                              UPPayViewController *controller = [UPPayViewController new];
                                                              controller.tradeNumber = resp.tradeNumber;
                                                              controller.orderNumber=[NSString stringWithFormat:@"%lld",resp.no];
                                                              [self.navigationController pushViewController:controller animated:YES];
                                                          } else {
                                                              [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"生成订单错误,请重试"];
                                                          }
                                                      }];
}

- (void)canclePayMoney
{
    if ([myView.payLabel.text floatValue]<0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请重新选择支付金额" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
}
#pragma mark--buttonClick
-(void)confirmBtnClick
{
    //NSLog(@"策四测试测试");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"积分使用规则" message:@"益积分与现金按照100:1的比例" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)qianbaoBtnClick
{
    qianbaoBool = !qianbaoBool;
    
    if (qianbaoBool==YES) {
        myView.qianbaoImage.image = [UIImage imageNamed:@"物业2.png"];
        [self addAlertView];
        if ([myView.textField1.text floatValue]>[wallet floatValue]) {
            myView.textField1.text =@"0";
            [self caculateHowMuchMoney];

        }

        
    }else{
        myView.qianbaoImage.image = [UIImage imageNamed:@"物业3.png"];
        [self caculateHowMuchMoney];

    }

    [self caculateHowMuchMoney];
}
-(void)jifenBtnClick
{
    jifenBool = !jifenBool;
    

    if (jifenBool==YES) {
        myView.jifenImage.image = [UIImage imageNamed:@"物业2.png"];
        [self addAlertView];

        NSString *strT1 = [NSString stringWithFormat:@"%d",[myView.textField2.text intValue]/100];
        NSString *strT2 = [NSString stringWithFormat:@"%d",[myView.textField2.text intValue]%100];
        if ([strT2 intValue]<10) {
            strT = [NSString stringWithFormat:@"%@.0%@",strT1,strT2];
            myView.jifenChange.text = [NSString stringWithFormat:@"-¥%@元",strT];
            
        }else{
            strT = [NSString stringWithFormat:@"%@.%@",strT1,strT2];
            myView.jifenChange.text = [NSString stringWithFormat:@"-¥%@元",strT];
            
        }


    }else{
        myView.jifenImage.image = [UIImage imageNamed:@"物业3.png"];
        strT = @"0.00";
        myView.jifenChange.text = @"-¥0.00";
    }
    [self caculateHowMuchMoney];

}
-(void)yinlianBtnClick
{
    yinlianBool = !yinlianBool;

    if (yinlianBool==YES) {
        myView.yinlianImage.image = [UIImage imageNamed:@"物业4.png"];
    }else{
        myView.yinlianImage.image = [UIImage imageNamed:@"物业3.png"];
        
    }
}
#pragma mark--计算钱
- (void)caculateHowMuchMoney
{
    if (qianbaoBool==YES && jifenBool==YES)
    {
        myView.payLabel.text = [NSString stringWithFormat:@"%.2f",self.money - [myView.textField1.text floatValue]- [strT floatValue]];
    }else if (qianbaoBool==NO && jifenBool==NO)
    {
        myView.payLabel.text = [NSString stringWithFormat:@"%.2f",self.money];
    }else if (qianbaoBool==YES && jifenBool==NO)
    {
        myView.payLabel.text = [NSString stringWithFormat:@"%.2f",self.money - [myView.textField1.text floatValue]];
    }else
    {
        myView.payLabel.text = [NSString stringWithFormat:@"%.2f",self.money - [strT floatValue]];
    }
}


- (void)loadRoomInfo
{
    [[CommunityIndicator sharedInstance] startLoading];
    
    UserInfo *user = [[CommunityDbManager sharedInstance] queryUserInfo:[AppSetting userId]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%lld", user.roomId], @"id",
                          [NSString stringWithFormat:@"%d", 0], @"updateTime", nil];
    [[HttpClientManager sharedInstance] getRoomInfoWithDict:dict
                                                   complete:^(BOOL success, GetRoomInfoResponse *resp) {
                                                       
                                                       if (success && resp.result == RESPONSE_SUCCESS) {
                                                           [[CommunityIndicator sharedInstance] hideIndicator:YES];
                                                           _room = resp.info;
                                                           [self loadRoomInfo:_room];
                                                       } else {
                                                           [self loadRoomInfo:nil];
                                                           if (resp) {
                                                               [HttpResponseNotification getRoomInfoHttpResponse:resp.result];
                                                           } else {
                                                               [HttpResponseNotification getRoomInfoHttpResponse:RESPONSE_ERROR];
                                                           }
                                                       }
                                                   }];
}

- (void)loadRoomInfo:(RoomInfo *)roomNew
{
    _room = roomNew;
    if (!_room) {
        return;
    }
    
    communityNameLabel = _room.communityName;
    buildingNameLabel = _room.buildingName;
    unitNameLabel = _room.unitName;
    roomNameLabel = _room.roomName;
    roomInfoArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",communityNameLabel],[NSString stringWithFormat:@"%@",buildingNameLabel],[NSString stringWithFormat:@"%@",unitNameLabel],[NSString stringWithFormat:@"%@",roomNameLabel], nil];
    [listTableView reloadData];
    areaLabel.text = [NSString stringWithFormat:@"%.2f㎡", _room.totalArea];
    if (_room.propertyType == 1) {
        propertyTypeLabel.text = @"普通物业";
    } else if (_room.propertyType == 2) {
        propertyTypeLabel.text = @"别墅住宅";
    } else if (_room.propertyType == 3) {
        propertyTypeLabel.text = @"写字楼";
    }
    if (_room.roomDiscount >= 1.0) {
        discountLabel.textAlignment = NSTextAlignmentLeft;
        discountLabel.font = [UIFont systemFontOfSize:18.0f];
        discountLabel.text = @"       方便、快捷、简单\n             就在益社区iPhone客户端";
    } else {
        discountLabel.textAlignment = NSTextAlignmentCenter;
        discountLabel.font = [UIFont systemFontOfSize:24.0f];
        discountLabel.text = [NSString stringWithFormat:@"现在缴费享  %.1f  折优惠!", _room.roomDiscount * 10];
    }
    //只显示到月
    lastFeeLabel.text = [NSString stringWithFormat:@"您的物业费已经缴纳至 %d", _room.lastPropertyFee / 100];
    unitPriceLabel.text = [NSString stringWithFormat:@"￥ %.2f 元/㎡", _room.unitPrice / 100];
}

#pragma mark--UITextField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==101 && [textField.text floatValue]>[wallet floatValue]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择合适的金额" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alert show];
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"输入金额有误！"];
        myView.textField1.text=@"";
        
    }else if(textField.tag==102 && [textField.text floatValue]>[integral floatValue]){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择合适的积分值" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//        [alert show];
         [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"输入积分有误！"];
        myView.textField2.text=@"";
        
    }else if ([self isBlankString:textField.text]==YES){
        textField.text = @"0";
        strT = @"0.00";
        myView.jifenChange.text = @"-¥0.00";
    }else if (textField.tag==102)
    {
        if (jifenBool==YES) {
            NSString *strT1 = [NSString stringWithFormat:@"%d",[textField.text intValue]/100];
            NSString *strT2 = [NSString stringWithFormat:@"%d",[textField.text intValue]%100];
            if ([strT2 intValue]<10) {
                strT = [NSString stringWithFormat:@"%@.0%@",strT1,strT2];
                myView.jifenChange.text = [NSString stringWithFormat:@"-¥%@元",strT];
                
            }else{
                strT = [NSString stringWithFormat:@"%@.%@",strT1,strT2];
                myView.jifenChange.text = [NSString stringWithFormat:@"-¥%@元",strT];
                
            }
            
        }
        
        
    }
    
    [self caculateHowMuchMoney];
}

#pragma mark-UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==100)
    {
        return 6;
    }else{
        return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            //cell.textLabel.text = @"标题";
            cell.textLabel.textColor = [UIColor blackColor];
            //cell.detailTextLabel.text = @"副标题";
            cell.detailTextLabel.textColor = [UIColor blackColor];
            
            
        }
        cell.textLabel.alpha = 0.7;
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:indexPath.row]];
        if (indexPath.row<4)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[roomInfoArray objectAtIndex:indexPath.row]];
        }else if (indexPath.row==4)
        {//_room.lastPropertyFee   self.timestring
            int value1 =_room.lastPropertyFee/10000;
            int value2 =_room.lastPropertyFee%10000/100;
            int value3 =_room.lastPropertyFee%10000%100;
            
            int nowFeeTime = [self.timestring intValue];
            int value4 =nowFeeTime/10000;
            int value5 =nowFeeTime%10000/100;
            int value6 =nowFeeTime%10000%100;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0f];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d/%d/%d至%d/%d/%d",value1,value2,value3,value4,value5,value6];
            self.startStr = [NSString stringWithFormat:@"%d%d%d",value1,value2,value3];
            if (value5<10) {
                value5 = [[NSString stringWithFormat:@"0%d",value5] intValue];
            }
            if (value6<10) {
                value6 = [[NSString stringWithFormat:@"0%d",value6] intValue];
            }

            self.endStr = [NSString stringWithFormat:@"%d%d%d",value4,value5,value6];

        }else
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f元",self.money];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
 
- (void)tapClick
{
    [self.view endEditing:YES];
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
