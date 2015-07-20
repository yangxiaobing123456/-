//
//  shouHuoAddViewController.h
//  Community
//
//  Created by HuaMen on 14-10-13.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "CommunityViewController.h"
#import "selectSHaddViewController.h"

@interface shouHuoAddViewController : CommunityViewController<UITextFieldDelegate,ChangeDelegate>
{
    UITextField *nameField;
    UITextField *telField;
    UITextField *detailField;
    UITextField *shengField;
    UITextField *shiField;
    UITextField *quField;
    UITextField *jiedaoField;
    NSMutableDictionary *dataDic;
}

@end
