//
//  FaBuActivityViewController.m
//  Community
//
//  Created by HuaMen on 14-12-29.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "FaBuActivityViewController.h"
#import "MultiImageUploadView.h"
#import "activityTypeSelectViewController.h"
#import "timePickerViewController.h"

//限制只输入数字
#define NUMBERS  @"0123456789"

@interface FaBuActivityViewController ()<UITextFieldDelegate,MultiImageUploadViewDelegate>
{
    UIButton *typeBtn;
    UIButton *timeBtn;
    MultiImageUploadView *imageUploadView;
    NSString *idStr;
    NSString *timeStr;
    BOOL selectFeeArrow;
}

@end

@implementation FaBuActivityViewController
- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeType:) name:@"selectActivityType" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTime:) name:@"selectTime" object:nil];
        
    }
    return self;
}
-(void)changeType:(NSNotification *)notice{
    NSLog(@"OK------");
    NSDictionary *dic=[notice userInfo];
    if (!dic||dic==nil) {
        return;
    }
    NSLog(@"%@",dic);
    [typeBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
    idStr=[dic objectForKey:@"id"];
    
}
-(void)changeTime:(NSNotification *)notice{
    NSDictionary *dic=[notice userInfo];
    NSLog(@"OK------");

    if (!dic||dic==nil) {
        return;
    }
    NSLog(@"%@",dic);
    [timeBtn setTitle:[dic objectForKey:@"nowTime"] forState:UIControlStateNormal];
    timeStr=[dic objectForKey:@"nowTime"];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"selectActivityType"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"selectTime"
                                                  object:nil];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBarButtonItem];
    self.title = @"发布活动";
    bianjiBool =NO;
    //创建一个手势
    UITapGestureRecognizer *gestureRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    //添加到这个view上
    [self.view addGestureRecognizer:gestureRecgnizer];
    imageNameArray = [NSArray arrayWithObjects:@"拼车",@"拼旅游",@"拼k歌",@"拼商品",@"拼健身",@"拼广场舞",@"拼宠物",@"拼球类",@"拼跑步",@"拼棋牌",@"拼吃货",@"跳蚤市场",@"其他", nil];

    fabuScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    fabuScrollview.contentSize = CGSizeMake(320, 935);
//    fabuScrollview.backgroundColor = [UIColor redColor];
    [self.view addSubview:fabuScrollview];
    
    [self addXibView];
    
   
    
    
    
    idStr=@"";
    timeStr=@"";
    NSArray *arr=[NSArray arrayWithObjects:@"给你的活动取个响亮的名字",@"请输入具体地址",@"请输入电话号码",@"请用一句话描述您发布的内容", nil];
    for (int i=0; i<4; i++) {
        UITextField *text=[[UITextField alloc]initWithFrame:CGRectMake(40, 10+40*i, 240, 20)];
        text.borderStyle=UITextBorderStyleRoundedRect;
        text.delegate=self;
        text.tag=i+1;
        text.placeholder=[arr objectAtIndex:i];
//        [self.view addSubview:text];
        
    }
    typeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    typeBtn.frame=CGRectMake(40, 10+40*4, 240, 20);
    [typeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [typeBtn setTitle:@"请选择活动类型" forState:UIControlStateNormal];
   // [typeBtn addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
    typeBtn.titleLabel.textColor=[UIColor grayColor];
//    [self.view addSubview:typeBtn];
    
    timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame=CGRectMake(40, 10+40*5, 240, 20);
    [timeBtn setTitle:@"请选择活动时间" forState:UIControlStateNormal];
    //[timeBtn addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    [timeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [self.view addSubview:timeBtn];
    for (int j=0; j<6; j++) {
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10+40*j, 20, 20)];
        [self.view addSubview:image];
        
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40+40*j, 320, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
//        [self.view addSubview:line];
        
    }
    
    imageUploadView = [[MultiImageUploadView alloc] initWithFrame:CGRectMake(7.0f, 10+40*6, 290.0f, 64.0f)];
    imageUploadView.backgroundColor=[UIColor whiteColor];
    imageUploadView.controller = self;
    imageUploadView.type = 4;
    imageUploadView.delegate = self;
//    [self.view addSubview:imageUploadView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"凸起按钮"] forState:UIControlStateNormal];
    [btn setTitle:@"我要发布" forState:UIControlStateNormal];
    btn.frame=CGRectMake(100, 320, 120, 30);

    
}//1111
- (void)refreshVC
{
    bianjiBool = YES;
    idString = [self.fabuDic objectForKey:@"id"];
    
    fabuView.titleTextfield.text = [self.fabuDic objectForKey:@"title"];
    fabuView.xiangqingTextView.text = [self.fabuDic objectForKey:@"content"];
    fabuView.renshuTextfield.text = [self.fabuDic objectForKey:@"num"];
    fabuView.dianhuaTextfield.text = [self.fabuDic objectForKey:@"telephone"];
    
    NSString *priceString = [self.fabuDic objectForKey:@"price"];
    if ([priceString isEqualToString:@"0"])
    {
        fabuView.feeLabel.text = @"免费";
    }else{
        fabuView.feeLabel.text = priceString;
    }
    
    actTypeNum = [[self.fabuDic objectForKey:@"actyType"] intValue];
    
    fabuView.typeLabel.text = [imageNameArray objectAtIndex:actTypeNum-1];
    NSLog(@".typeLabel===%@",[imageNameArray objectAtIndex:actTypeNum-1]);
    fabuView.startLabel.text = [self.fabuDic objectForKey:@"starttime"];
    fabuView.endLabel.text = [self.fabuDic objectForKey:@"endtime"];
    fabuView.addressTextf.text = [self.fabuDic objectForKey:@"address"];

}

#pragma mark-  xib 创建UIView
- (void)addXibView
{
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"Fabu_View" owner:self options:nil];
    fabuView = [array objectAtIndex:0];
    //xib坐标一定要和此处一致，不然控件不响应
    fabuView.frame = CGRectMake(0, 0, 320, 670);
    //delegate 必须在添加之前设置
    fabuView.titleTextfield.delegate = self;
    fabuView.renshuTextfield.delegate = self;
    fabuView.dianhuaTextfield.delegate = self;
    fabuView.addressTextf.delegate = self;
    fabuView.xiangqingTextView.delegate = self;

    [fabuScrollview addSubview:fabuView];
    
    if (self.fabuDic) {
        [self refreshVC];
    }
    [fabuView.fabuBtn addTarget:self action:@selector(fabuClick) forControlEvents:UIControlEventTouchUpInside];
    [fabuView.feeBtn addTarget:self action:@selector(feeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [fabuView.typeBtn addTarget:self action:@selector(typeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [fabuView.startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [fabuView.endBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}
//手势绑定的事件
- (void)tapClick
{
    [self.view endEditing:YES];
}


#pragma mark-BtnClick
- (void)startBtnClick:(UIButton *)btn
{
    selectFeeArrow = !selectFeeArrow;
    if (selectFeeArrow==YES) {
        fabuView.startImagev.image = [UIImage imageNamed:@"icon_up.png"];
    }else
    {
        fabuView.startImagev.image = [UIImage imageNamed:@"icon_right.png"];
    }
    
    if (btn.tag==100) {
        fabuView.startLabel.text = @"";
    }else
    {
        fabuView.endLabel.text = @"";
    }
//    fabuView.startLabel.text = @"";
    fabuView.startBtn.userInteractionEnabled = NO;
    
    //封装整个View
    timeView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 377.0f, 320.0f, 250.0f)];
    timeView.backgroundColor = [UIColor whiteColor];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 50.0f, 320.0f, 199.0f)];
    datePicker.tag = btn.tag;
//    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker setMinimumDate:[NSDate date]];

    //获得当前选择的日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *nowDe = [NSDate date];
    if (btn.tag==100) {
        fabuView.startLabel.text = [dateFormatter stringFromDate:nowDe];
    }else
    {
        fabuView.endLabel.text = @"";
    }

//    fabuView.startLabel.text = [dateFormatter stringFromDate:nowDe];
    
    [datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 249, 320, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    line1.alpha = 0.5;
    [timeView addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 49.0f)];
    line2.backgroundColor = [UIColor lightGrayColor];
    line2.text = @"选择时间";
    line2.textAlignment = NSTextAlignmentCenter;
    line2.font = [UIFont systemFontOfSize:20];
    [timeView addSubview:line2];
    
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmButton.frame = CGRectMake(205.0f, 0.0f, 139.50f, 49.0f);
    
    confirmButton.tag = 2;
    confirmButton.backgroundColor = [UIColor clearColor];
    [confirmButton setTitle:@"完成" forState:UIControlStateNormal];
    [confirmButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(dismissDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    [timeView addSubview:datePicker];
    [timeView addSubview:confirmButton];
    [fabuView addSubview:timeView];

    
}
- (void)datePickerDateChanged:(UIDatePicker *)paramDatePicker
{
    if ([paramDatePicker isEqual:datePicker])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

        strDate = [dateFormatter stringFromDate:paramDatePicker.date];
        if (datePicker.tag==100) {
            fabuView.startLabel.text = [dateFormatter stringFromDate:paramDatePicker.date];

        }else
        {
            fabuView.endLabel.text = [dateFormatter stringFromDate:paramDatePicker.date];

            
            endLabelS = [dateFormatter stringFromDate:paramDatePicker.date];


        }
        
        NSTimeInterval times=[[dateFormatter dateFromString:fabuView.endLabel.text] timeIntervalSinceDate:[dateFormatter dateFromString:fabuView.startLabel.text]];
        days=(int)times;
        NSLog(@"days===%d",days);

        
    }
}
- (void)dismissDatePicker:(UIButton *)btn
{
    if ([fabuView.startLabel.text isEqualToString:@""]||[fabuView.endLabel.text isEqualToString:@""]) {
        NSLog(@"继续选择");
    }else
    {
        if (days< 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"结束时间必须大于开始时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;

        }
    }
    
    fabuView.startBtn.userInteractionEnabled = YES;
    timeView.hidden = YES;
    
    selectFeeArrow = !selectFeeArrow;

    if (selectFeeArrow==YES) {
        fabuView.startImagev.image = [UIImage imageNamed:@"icon_up.png"];
    }else
    {
        fabuView.startImagev.image = [UIImage imageNamed:@"icon_right.png"];
    }

    
}

- (void)feeBtnClick
{
    fabuView.feeBtn.userInteractionEnabled = NO;
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"Fee_View" owner:self options:nil];
    feeView = [array objectAtIndex:0];
    //xib坐标一定要和此处一致，不然控件不响应
    feeView.frame = CGRectMake(0, 290, 320, 180);
    [fabuScrollview addSubview:feeView];

    [feeView.finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [feeView.freeFeeBtn addTarget:self action:@selector(freeFeeBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [feeView.feeBtn addTarget:self action:@selector(needFeeBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
    feeView.feeTextField.delegate = self;
}
- (void)finishBtnClick
{
    if (freeBool==YES) {
       fabuView.feeBtn.userInteractionEnabled = YES;
       fabuView.feeLabel.text = @"免费";

    }

    [feeView removeFromSuperview];
    fabuView.feeBtn.userInteractionEnabled = YES;

}
- (void)freeFeeBtnClick
{
    feeView.freeFeeBtn.backgroundColor = [UIColor lightGrayColor];
    feeView.feeBtn.backgroundColor = [UIColor whiteColor];
    freeBool = YES;
//    [feeView.freeFeeBtn setSelected:YES];
}
- (void)needFeeBtnClick
{
    freeBool = NO;
    feeView.freeFeeBtn.backgroundColor = [UIColor whiteColor];
    feeView.feeBtn.backgroundColor = [UIColor lightGrayColor];
}

- (void)typeBtnClick
{
    fabuView.typeBtn.userInteractionEnabled = NO;

    CGFloat btnW=72;
    CGFloat btnH=70;
    typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 320, 360)];
    typeView.backgroundColor = [UIColor whiteColor];
    [fabuView addSubview:typeView];
    
    for (int i=0; i<13; i++)
    {
        CGFloat btnIntervalX = (320-72*4)/5;
        CGFloat btnIntervalY = 20.0;
        CGFloat fX = btnIntervalX +(btnW + btnIntervalX)*(i%4);
        CGFloat fY = (btnH + btnIntervalY)*(i/4);

        UIButton *littleTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        littleTypeBtn.frame = CGRectMake(fX, fY, 72, 70);
        [littleTypeBtn setBackgroundImage:[UIImage imageNamed:[imageNameArray objectAtIndex:i]] forState:UIControlStateNormal];
        littleTypeBtn.tag= i;
        [littleTypeBtn addTarget:self action:@selector(dismisslittleTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [typeView addSubview:littleTypeBtn];
        
        littleTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(littleTypeBtn.frame.origin.x, littleTypeBtn.frame.origin.y+70, littleTypeBtn.frame.size.width, 20)];
        littleTypeLabel.text = [imageNameArray objectAtIndex:i];
        littleTypeLabel.textAlignment = NSTextAlignmentCenter;
        [typeView addSubview:littleTypeLabel];


        
    }
    
}
- (void)dismisslittleTypeBtn:(UIButton *)btn
{
//    fabuView.typeLabel.text = [NSString stringWithFormat:@"%@",[imageNameArray objectAtIndex:i]];
    fabuView.typeLabel.text = [NSString stringWithFormat:@"%@",[imageNameArray objectAtIndex:btn.tag]];
    fabuView.typeLabel.tag = btn.tag + 1;
    [typeView removeFromSuperview];
    fabuView.typeBtn.userInteractionEnabled = YES;

}

#pragma mark--request
- (void)fabuClick
{
    if ([fabuView.titleTextfield.text isEqualToString:@""]||[fabuView.xiangqingTextView.text isEqualToString:@""]||[fabuView.renshuTextfield.text isEqualToString:@""]||[fabuView.dianhuaTextfield.text isEqualToString:@""]||[fabuView.feeLabel.text isEqualToString:@""]||[fabuView.typeLabel.text isEqualToString:@""]||[fabuView.startLabel.text isEqualToString:@""]||[fabuView.endLabel.text isEqualToString:@""]||[fabuView.addressTextf.text isEqualToString:@""]) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"请完善活动信息" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        //        alertview.tag = 1000;
        //        alertview.delegate = self;
        [alertview show];
        return;
        
    }

    //防止连续发布两次
    fabuView.fabuBtn.userInteractionEnabled = NO;
    
    if ([fabuView.feeLabel.text isEqualToString:@"免费"] ) {
        fabuView.feeLabel.text = @"0";
    }
   NSDictionary *User = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",fabuView.typeLabel.tag],@"actyType",fabuView.titleTextfield.text,@"title",fabuView.startLabel.text,@"time",fabuView.endLabel.text,@"endtime",fabuView.addressTextf.text,@"address",fabuView.dianhuaTextfield.text,@"telephone",fabuView.xiangqingTextView.text,@"content",fabuView.feeLabel.text,@"price",fabuView.renshuTextfield.text,@"num", nil];
    NSString *urlStr = fabuhuodong;
    
    if (self.fabuDic) {
        User = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",actTypeNum],@"actyType",fabuView.titleTextfield.text,@"title",fabuView.startLabel.text,@"time",fabuView.endLabel.text,@"endtime",fabuView.addressTextf.text,@"address",fabuView.dianhuaTextfield.text,@"telephone",fabuView.xiangqingTextView.text,@"content",fabuView.feeLabel.text,@"price",fabuView.renshuTextfield.text,@"num",idString,@"activityId", nil];
        urlStr = updateActivity;
    }
    
    if ([NSJSONSerialization isValidJSONObject:User])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:User options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSLog(@"urlStr====%@",url);
        NSLog(@"bianjiBool===%d",bianjiBool);

        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        NSLog(@"userId===%lld",[AppSetting userId]);
        [request addRequestHeader:@"Authorization" value:str];
        
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
    }
 
}


#pragma mark-UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{
    NSLog(@"----------");
    if([string isEqualToString:@"\n"]){
        return YES;
    }
//    NSString * toBeString =[textField.text stringByReplacingCharactersInRange:range withString:string];
    if(textField.tag==10&&range.location >9){
        return NO;
    }
    if(textField.tag==20){

        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        return canChange;
        
        //此处判断不起作用
        if (range.location >3) {
            return NO;
            
        }

    }
    
    
    if(textField.tag==30){
        
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        return canChange;

        //此处判断不起作用
        if (range.location>10) {
            return NO;

        }
    }
    
    if (textField.tag==40&&range.location>9) {
        return NO;
    }
    if (textField.tag==100&&range.location>3) {
        return NO;
    }

    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==30) {
//       fabuScrollview.contentOffset = CGPointMake(0, 310);
    }
    fabuScrollview.contentSize = CGSizeMake(320, 975);

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{

    if (textField.tag==30) {
        fabuScrollview.contentOffset = CGPointMake(0, 200);
    }

    fabuScrollview.contentSize = CGSizeMake(320, 835);
    if (textField.tag==100) {
        fabuView.feeLabel.text = feeView.feeTextField.text;
    }
    if(textField.tag==10){
        if([textField.text length] >10){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"标题10字以内" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            textField.text = @"";
            return ;
        }
    }
    if(textField.tag==20){
        if([textField.text length] >4){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"人数不能超过4位数" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            textField.text = @"";
            return ;
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[textField.text componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL canChange = [textField.text isEqualToString:filtered];
        if (!canChange) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"人数输入不规范" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            textField.text = @"";
        }

    }
    if(textField.tag==30){
        if([textField.text length] >11){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"电话号码不能超过11位数" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [alert show];
            textField.text = @"";

            return ;
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[textField.text componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL canChange = [textField.text isEqualToString:filtered];
        if (!canChange) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"电话号码输入不规范" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            textField.text = @"";
        }
    }
    if(textField.tag==40){
        if([textField.text length] >10){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"地址长度不可以超过10" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [alert show];
            textField.text = @"";

            return ;
        }
    }
 
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    fabuView.xiangqingLabel.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.tag==11){
        if([textView.text length] >50){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"地址长度不可以超过50" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            textView.text = @"";
            return ;
        }
    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    NSLog(@"----------");
    if([text isEqualToString:@"\n"]){
        return YES;
    }
    NSString * toBeString =[textView.text stringByReplacingCharactersInRange:range withString:text];
    if(textView.tag==11){
        if([toBeString length] >50){
            textView.text=[toBeString substringToIndex:50];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"详情长度不能超过50字" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [alert show];
            return NO;
        }
    }

    return YES;
}
//-(void)selectTime{
//    timePickerViewController *av=[[timePickerViewController alloc]init];
//    [self.navigationController pushViewController:av animated:YES];
//
//}
//-(void)select{
//    activityTypeSelectViewController *av=[[activityTypeSelectViewController alloc]init];
//    [self.navigationController pushViewController:av animated:YES];
//    
//}
//-(void)btnClick{
//    [self fabu];
//    
//}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [[textField viewWithTag:1]resignFirstResponder];
//    [[textField viewWithTag:2]resignFirstResponder];
//    [[textField viewWithTag:3]resignFirstResponder];
//    [[textField viewWithTag:4]resignFirstResponder];
//    return YES;
//}
//- (void)hideKeyboard
//{
//}
//-(void)fabu{
//    UITextField *textField1=(UITextField *)[self.view viewWithTag:1];
//    UITextField *textField2=(UITextField *)[self.view viewWithTag:2];
//    UITextField *textField3=(UITextField *)[self.view viewWithTag:3];
//    UITextField *textField4=(UITextField *)[self.view viewWithTag:4];
//    NSString *pictureURL = @"";
//    if (imageUploadView.URLArray.count > 0) {
//        for (int i = 0; i < imageUploadView.URLArray.count; i ++) {
//            pictureURL = [pictureURL stringByAppendingString:imageUploadView.URLArray[i]];
//            if (i != imageUploadView.URLArray.count - 1) {
//                pictureURL = [pictureURL stringByAppendingString:@"#"];
//            }
//        }
//    }
//
//    
//    NSDictionary *user = [[NSDictionary alloc]initWithObjectsAndKeys:idStr,@"actyType",textField1.text,@"title",timeStr,@"time",textField2.text,@"address",textField3.text,@"telephone",textField4.text,@"content",pictureURL,@"pic", nil];
//    if ([NSJSONSerialization isValidJSONObject:user])
//    {
//        NSError *error;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
//        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
//        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
//        NSURL *url = [NSURL URLWithString:fabuhuodong];
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
//        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
//        [request addRequestHeader:@"Accept" value:@"application/json"];
//        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
//        NSLog(@"%lld",[AppSetting userId]);
//        [request addRequestHeader:@"Authorization" value:str];
//        [request setRequestMethod:@"POST"];
//        [request setPostBody:tempJsonData];
// //       request.tag=100;
//        request.delegate=self;
//        [request startAsynchronous];
//    }
//}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"网络不给力啊"];
    fabuView.fabuBtn.userInteractionEnabled = YES;

}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag==100) {
        fabuView.fabuBtn.userInteractionEnabled = YES;

        NSLog(@"OK!!");
        NSLog(@"str==%@",request.responseString);
        NSDictionary *dic=[request.responseData objectFromJSONData];
        NSLog(@"dic==%@",dic);
        NSString *result=[dic objectForKey:@"result"];
        if ([result isEqualToString:@"1"]) {
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"活动发布成功"];
            //成功以后 发出通知
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"id",@"",@"name", nil];
            NSNotification *notice=[NSNotification notificationWithName:@"refreshFabuActivity" object:nil userInfo:dic];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [[CommunityIndicator sharedInstance] showNoteWithTextAutoHide:@"活动发布失败"];
        }
    }
    
}




#pragma mark-  UIBarButtonItem
- (void)addBarButtonItem
{
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    leftBarBtn.frame=CGRectMake(0, 0, 12, 20);
    //leftBarBtn.tag = 101;
    [leftBarBtn addTarget:self action:@selector(rightBarBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)rightBarBtnSelect:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
