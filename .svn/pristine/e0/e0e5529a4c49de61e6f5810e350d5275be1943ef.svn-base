//
//  AboutUsController.m
//  Community
//
//  Created by SYZ on 14-3-7.
//  Copyright (c) 2014年 Hua Men. All rights reserved.
//

#import "AboutUsController.h"

@interface AboutUsController ()

@end

@implementation AboutUsController

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
	
    self.title = @"关于我们";
    
    UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 304.0f, kNavContentHeight)];
    blurView.backgroundColor = BlurColor;
    [self.view addSubview:blurView];
    
    UILabel * headerContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 320, 350)];
    headerContentLabel.textColor = [UIColor blackColor];
    headerContentLabel.backgroundColor = [UIColor clearColor];
    headerContentLabel.font = [UIFont systemFontOfSize:14.0f];
    headerContentLabel.numberOfLines = 0;
    headerContentLabel.text=@"“益社区”是南京向正物业管理服务有限公司在对社区服务新模式的探寻下，本着“科技创造价值”理念的同时，基于物业基础服务开发的一款线上社区生活服务类平台。行业内率先实行线上管家模式，将物业服务全过程做到专业化、透明化，同时确保服务全过程可跟踪、可追溯。在“益社区”的推动下，将会更有利于物业服务人员和业主的沟通，建立密切的线上线下联系。同时我们将线上线下结合，更加高效便捷，为社区业主带来更多、更好、更专业的增值生活服务体验。我们的宗旨是成为“社区服务资源集成商”，通过“益社区”来推动和引领物业服务行业的快速和规范化发展。";
    [self.view addSubview:headerContentLabel];
    
    UIImageView *topBgView = [[UIImageView alloc] initWithFrame:CGRectMake(130,0.0f, 60, 60.0f)];
    topBgView.image = [UIImage imageNamed:@"logo_000001"];
    [self.view addSubview:topBgView];
    
    
    UIImageView *erView = [[UIImageView alloc] initWithFrame:CGRectMake(130, self.view.bounds.size.height-200, 60, 60.0f)];
    erView.image = [UIImage imageNamed:@"二维码"];
    [self.view addSubview:erView];
    
    UILabel * abL = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, self.view.bounds.size.height-100,300, 20)];
    abL.textColor = [UIColor blackColor];
    abL.backgroundColor = [UIColor clearColor];
    abL.font = [UIFont systemFontOfSize:14.0f];
    abL.numberOfLines = 0;
    abL.textAlignment=NSTextAlignmentCenter;
    abL.text=@"扫一扫二维码，下载益社区";
    [self.view addSubview:abL];

    

//    CommunityMoreHeaderView *headerView = [[CommunityMoreHeaderView alloc] initWithFrame:CGRectMake(8.0f, 10.0f, 304.0f, 350.0f)];
//    headerView.backgroundColor = [UIColor clearColor];
//    [headerView setContent:@"“益社区”是南京多益物业管理服务有限公司在对社区服务新模式的探寻下，本着“科技创造价值”理念的同时，基于物业基础服务开发的一款线上社区生活服务类平台。行业内率先实行线上管家模式，将物业服务全过程做到专业化、透明化，同时确保服务全过程可跟踪、可追溯。在“益社区”的推动下，将会更有利于物业服务人员和业主的沟通，建立密切的线上线下联系。同时我们将线上线下结合，更加高效便捷，为社区业主带来更多、更好、更专业的增值生活服务体验。我们的宗旨是成为“社区服务资源集成商”，通过“益社区”来推动和引领物业服务行业的快速和规范化发展。"];
//    [self.view addSubview:headerView];
    
    [self customBackButton:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
