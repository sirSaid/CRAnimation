//
//  CRBaseViewController.m
//  CRAnimation
//
//  Created by Bear on 16/10/9.
//  Copyright © 2016年 BearRan. All rights reserved.
//

#import "CRBaseViewController.h"


@interface CRBaseViewController ()
{
    UIButton    *_backBtn;
    UIView      *_topBarView;
}

@end

@implementation CRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
        
}

- (void)addTopBar
{
    if (!_topBarView) {
        _topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_HEIGHT, WIDTH, 40)];
        [self.view addSubview:_topBarView];
    }
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
        [_backBtn sizeToFit];
        [_backBtn addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView addSubview:_backBtn];
        [_backBtn BearSetRelativeLayoutWithDirection:kDIR_LEFT destinationView:nil parentRelation:YES distance:15 center:YES];
    }
}


- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
