//
//  shouHuoAddViewController.m
//  Community
//
//  Created by HuaMen on 14-10-13.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "shouHuoAddViewController.h"
#import "selectSHaddViewController.h"

@interface shouHuoAddViewController ()

@end

@implementation shouHuoAddViewController
- (id)init
{
    self = [super init];
    if (self) {
        dataDic=[[NSMutableDictionary alloc]init];
        selectSHaddViewController *sv=[[selectSHaddViewController alloc]init];
        sv.delegate=self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName:) name:@"selectSHDZ" object:nil];
        
    }
    return self;
}
-(void)changeName:(NSNotification *)notice{
    NSLog(@"OK");
    NSDictionary *dic=[notice userInfo];
    NSLog(@"dic====%@",[dic allKeys]);
    if ([[[dic allKeys]objectAtIndex:0]isEqualToString:@"sheng123"]) {
        NSLog(@"!!!");
        [shengField setText:[dic objectForKey:@"sheng"]];
        [dataDic setObject:[dic objectForKey:@"sheng123"] forKey:@"sheng"];

        
    }if ([[[dic allKeys]objectAtIndex:0]isEqualToString:@"shi"]) {
        [shiField setText:[dic objectForKey:@"shi"]];
        [dataDic setObject:[dic objectForKey:@"shi123"] forKey:@"shi"];
    }if ([[[dic allKeys]objectAtIndex:0]isEqualToString:@"qu"]) {
        [quField setText:[dic objectForKey:@"qu"]];
        [dataDic setObject:[dic objectForKey:@"qu123"] forKey:@"qu"];
    }if ([[[dic allKeys]objectAtIndex:0]isEqualToString:@"jiedao"]) {
        [jiedaoField setText:[dic objectForKey:@"jiedao"]];
        [dataDic setObject:[dic objectForKey:@"jiedao123"] forKey:@"jiedao"];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"添加收货地址";
// 姓名
    float  fieldBgH = 44.0f;
    UIImageView *phoneFieldBg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 130, fieldBgH)];
    phoneFieldBg.image = [UIImage imageNamed:@"enter_box"];
    [self.view addSubview:phoneFieldBg];
    
    
   
    
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 130, fieldBgH)];
    nameField.backgroundColor = [UIColor clearColor];
    nameField.font = [UIFont systemFontOfSize:20.0f];
    nameField.delegate=self;
    nameField.textColor = [UIColor grayColor];
//    nameField.keyboardType = UIKeyboardTypeNumberPad;
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.returnKeyType = UIReturnKeyNext;
    nameField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [nameField setPlaceholder:@"姓名"];
    [self.view addSubview:nameField];
    
   
    
//    
    UIImageView *phoneFieldBg1 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 10, 130, fieldBgH)];
    phoneFieldBg1.image = [UIImage imageNamed:@"enter_box"];
    [self.view addSubview:phoneFieldBg1];
    
    
    telField = [[UITextField alloc] initWithFrame:CGRectMake(165, 10, 130, fieldBgH)];
    telField.backgroundColor = [UIColor clearColor];
    telField.font = [UIFont systemFontOfSize:20.0f];
    telField.delegate=self;
    telField.textColor = [UIColor grayColor];
//    telField.keyboardType = UIKeyboardTypeNumberPad;
    telField.clearButtonMode = UITextFieldViewModeWhileEditing;
    telField.returnKeyType = UIReturnKeyNext;
    telField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [telField setPlaceholder:@"电话"];
    [self.view addSubview:telField];
    
    
    UIImageView *phoneFieldBg2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 60, 130, fieldBgH)];
    phoneFieldBg2.image = [UIImage imageNamed:@"enter_box"];
    [self.view addSubview:phoneFieldBg2];
    
    
    shengField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 130, fieldBgH)];
    shengField.backgroundColor = [UIColor clearColor];
    shengField.font = [UIFont systemFontOfSize:20.0f];
    shengField.delegate=self;
    shengField.textColor = [UIColor grayColor];
    //    nameField.keyboardType = UIKeyboardTypeNumberPad;
    shengField.clearButtonMode = UITextFieldViewModeWhileEditing;
    shengField.returnKeyType = UIReturnKeyNext;
    shengField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [shengField setPlaceholder:@"省"];
    [self.view addSubview:shengField];
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=shengField.frame;
    btn1.tag=10;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIImageView *phoneFieldBg3 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 60, 130, fieldBgH)];
    phoneFieldBg3.image = [UIImage imageNamed:@"enter_box"];
    [self.view addSubview:phoneFieldBg3];
    
    
    shiField = [[UITextField alloc] initWithFrame:CGRectMake(165, 60, 130, fieldBgH)];
    shiField.backgroundColor = [UIColor clearColor];
    shiField.font = [UIFont systemFontOfSize:20.0f];
    shiField.delegate=self;
    shiField.textColor = [UIColor grayColor];
    //    nameField.keyboardType = UIKeyboardTypeNumberPad;
    shiField.clearButtonMode = UITextFieldViewModeWhileEditing;
    shiField.returnKeyType = UIReturnKeyNext;
    shiField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [shiField setPlaceholder:@"市"];
    [self.view addSubview:shiField];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=shiField.frame;
    btn2.tag=20;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIImageView *phoneFieldBg4 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 60+55, 130, fieldBgH)];
    phoneFieldBg4.image = [UIImage imageNamed:@"enter_box"];
    [self.view addSubview:phoneFieldBg4];
    
    
    quField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60+55, 130, fieldBgH)];
    quField.backgroundColor = [UIColor clearColor];
    quField.font = [UIFont systemFontOfSize:20.0f];
    quField.delegate=self;
    quField.textColor = [UIColor grayColor];
    //    nameField.keyboardType = UIKeyboardTypeNumberPad;
    quField.clearButtonMode = UITextFieldViewModeWhileEditing;
    quField.returnKeyType = UIReturnKeyNext;
    quField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [quField setPlaceholder:@"区"];
    [self.view addSubview:quField];
    
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=quField.frame;
    btn3.tag=30;
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIImageView *phoneFieldBg5 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 60+55, 130, fieldBgH)];
    phoneFieldBg5.image = [UIImage imageNamed:@"enter_box"];
    [self.view addSubview:phoneFieldBg5];
    
    
    jiedaoField = [[UITextField alloc] initWithFrame:CGRectMake(165, 60+55, 130, fieldBgH)];
    jiedaoField.backgroundColor = [UIColor clearColor];
    jiedaoField.font = [UIFont systemFontOfSize:20.0f];
    jiedaoField.delegate=self;
    jiedaoField.textColor = [UIColor grayColor];
    //    nameField.keyboardType = UIKeyboardTypeNumberPad;
    jiedaoField.clearButtonMode = UITextFieldViewModeWhileEditing;
    jiedaoField.returnKeyType = UIReturnKeyNext;
    jiedaoField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [jiedaoField setPlaceholder:@"街道"];
    [self.view addSubview:jiedaoField];
    
    UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame=jiedaoField.frame;
    btn4.tag=40;
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    
    UIImageView *phoneFieldBg6 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 60+110, 300, fieldBgH)];
    phoneFieldBg6.image = [UIImage imageNamed:@"enter_box"];
    [self.view addSubview:phoneFieldBg6];
    
    
    detailField = [[UITextField alloc] initWithFrame:CGRectMake(12, 60+110, 300, fieldBgH)];
    detailField.backgroundColor = [UIColor clearColor];
    detailField.font = [UIFont systemFontOfSize:20.0f];
    detailField.delegate=self;
    detailField.textColor = [UIColor grayColor];
    //    nameField.keyboardType = UIKeyboardTypeNumberPad;
    detailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    detailField.returnKeyType = UIReturnKeyNext;
    detailField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [detailField setPlaceholder:@"详细地址"];
    [self.view addSubview:detailField];
    
    float buttonW = 100.0f, buttonH = 32.0f;
    UIButton *changePwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changePwdButton.frame = CGRectMake(35.0f,300.0f, buttonW, buttonH);
    [changePwdButton setTitle:@"确 认"
                     forState:UIControlStateNormal];
    [changePwdButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                          forState:UIControlStateNormal];
    [changePwdButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                               forState:UIControlStateNormal];
    [changePwdButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                               forState:UIControlStateHighlighted];
    [changePwdButton addTarget:self
                        action:@selector(sure)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePwdButton];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(185.0f, 300.0f, buttonW, buttonH);
    [logoutButton setTitle:@"取 消"
                  forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor colorWithHexValue:0xFF767477]
                       forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"凸起按钮"]
                            forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"button_highlighted_200W"]
                            forState:UIControlStateHighlighted];
    [logoutButton addTarget:self
                     action:@selector(logoutAction)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];

    
}
-(void)logoutAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)changeTitle:(NSDictionary *)aStr{
    NSLog(@"%@",aStr);
}
-(void)btnClick:(UIButton *)btn{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (btn.tag==10) {
        selectSHaddViewController *sv=[[selectSHaddViewController alloc]init];
        sv.title=@"省";
        sv.typeStr=@"sheng";
        sv.idStr=[defaults objectForKey:@"SHid"];
        [self.navigationController pushViewController:sv animated:YES];
    }if (btn.tag==20) {
        selectSHaddViewController *sv=[[selectSHaddViewController alloc]init];
        sv.typeStr=@"shi";
        sv.idStr=[defaults objectForKey:@"SHid"];
        sv.title=@"市";
        
        [self.navigationController pushViewController:sv animated:YES];
    }if (btn.tag==30) {
        selectSHaddViewController *sv=[[selectSHaddViewController alloc]init];
        sv.title=@"区";
        sv.typeStr=@"qu";
        sv.idStr=[defaults objectForKey:@"SHid"];
        [self.navigationController pushViewController:sv animated:YES];

    }if (btn.tag==40) {
        selectSHaddViewController *sv=[[selectSHaddViewController alloc]init];
        sv.title=@"街道";
        sv.typeStr=@"jiedao";
        sv.idStr=[defaults objectForKey:@"SHid"];
        [self.navigationController pushViewController:sv animated:YES];

    }
   
}
-(void)sure{
    if ([nameField.text isEqualToString:@""]||nameField.text==nil) {
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"请输入姓名"];
        return;
    }
    else if ([telField.text isEqualToString:@""]||telField.text==nil) {
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"请输入电话"];
        return;
    }
    else if ([shengField.text isEqualToString:@""]||shengField.text==nil) {
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"请输入省份"];
        return;
    }
    else if ([shiField.text isEqualToString:@""]||shiField.text==nil) {
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"请输入城市"];
        return;
    }else if ([quField.text isEqualToString:@""]||quField.text==nil){
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"请输入区县"];
        return;
        
    }
    else{
        NSDictionary *user=[[NSDictionary alloc]init];
        if (![jiedaoField.text isEqualToString:@""]||jiedaoField.text==nil) {
             user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",detailField.text,@"address",nameField.text,@"user",telField.text,@"phone",[dataDic objectForKey:@"sheng"],@"provinceId",[dataDic objectForKey:@"shi"],@"cityId",[dataDic objectForKey:@"qu"],@"districtId",[dataDic objectForKey:@"jiedao"],@"streetId", nil];
        }else{
             user = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",[AppSetting userId]],@"userId",detailField.text,@"address",nameField.text,@"user",telField.text,@"phone",[dataDic objectForKey:@"sheng"],@"provinceId",[dataDic objectForKey:@"shi"],@"cityId",[dataDic objectForKey:@"qu"],@"districtId",@"0",@"streetId", nil];
            
        }
   
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
        //        http://115.29.251.197:8080/duoyi/appPurchase/getAllPrucahses
        NSURL *url = [NSURL URLWithString:creatAddress];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request setValue:[self authorizationHttpHeaderString] forHTTPHeaderField:@"Authorization"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *str=[NSString stringWithFormat:@"Basic %@",[[[NSString stringWithFormat:@"u_%lld:%@",[AppSetting userId], [AppSetting userPassword]] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding]];
        [request addRequestHeader:@"Authorization" value:str];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        request.tag=100;
        request.delegate=self;
        [request startAsynchronous];
    }
    }

    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"faild===%@",request.error);
    [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"请求失败"];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
   
    NSDictionary *dic=[request.responseData objectFromJSONData];
    NSLog(@"%@",dic);
    NSString *result=[dic objectForKey:@"result"];
    if ([result isEqualToString:@"1"]) {
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    
        
    }else{
        [[CommunityIndicator sharedInstance]showNoteWithTextAutoHide:@"添加失败"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }

    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [detailField resignFirstResponder];
    return YES;
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
