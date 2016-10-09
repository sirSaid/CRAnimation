//
//  CRViewController.m
//  CRAnimation
//
//  Created by BearRan on 10/07/2016.
//  Copyright (c) 2016 BearRan. All rights reserved.
//

#import "CRViewController.h"
#import "CRDemoInfoModel.h"

static NSString *__kCRDemoStorage       = @"动效仓库";
static NSString *__kCRDemoCombination   = @"组合动效";

@interface CRViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray  *dataArrayTitle;
@property (strong, nonatomic) NSMutableArray  *dataArrayDemoModel;
@property (strong, nonatomic) UITableView     *mainTableView;

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self dataReady];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)dataReady
{
    //  动效仓库
    
    if (1) {
        CRDemoInfoModel *demoInfoModel = [CRDemoInfoModel new];
        demoInfoModel.demoName = @"CRCardAnimationView";
        demoInfoModel.demoSummary = @"卡片切换动效";
        [self addDemoModel:demoInfoModel withGroupName:__kCRDemoStorage];
    }
    
    if (1) {
        CRDemoInfoModel *demoInfoModel = [CRDemoInfoModel new];
        demoInfoModel.demoName = @"CRImageGradientView";
        demoInfoModel.demoSummary = @"ImageView过渡切换动效";
        demoInfoModel.demoVCName = @"CRImageGradientDemoVC";
        [self addDemoModel:demoInfoModel withGroupName:__kCRDemoStorage];
    }
    
    //  组合动效
    
    if (1) {
        CRDemoInfoModel *demoInfoModel = [CRDemoInfoModel new];
        demoInfoModel.demoName = @"音乐切换动效";
        demoInfoModel.demoSummary = @"CRCardAnimationView和CRImageGradientView的组合动效";
        [self addDemoModel:demoInfoModel withGroupName:__kCRDemoCombination];
    }
}

- (void)addDemoModel:(CRDemoInfoModel *)infoModel withGroupName:(NSString *)groupName
{
    if (!_dataArrayTitle) {
        _dataArrayTitle = [[NSMutableArray alloc] initWithArray:@[
                                                                  __kCRDemoStorage,
                                                                  __kCRDemoCombination,
                                                                  ]];
    }
    
    if (!_dataArrayDemoModel) {
        _dataArrayDemoModel = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [_dataArrayTitle count]; i++) {
            NSMutableArray *subMutableArray = [NSMutableArray new];
            [_dataArrayDemoModel addObject:subMutableArray];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    if (infoModel) {
        //  添加新的Demo数据模型
        NSInteger index = [weakSelf.dataArrayTitle indexOfObject:groupName];
        NSMutableArray *subMutableArray = weakSelf.dataArrayDemoModel[index];
        [subMutableArray addObject:infoModel];
        _dataArrayDemoModel[index] = subMutableArray;
    }
}

- (void)createUI
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArrayDemoModel count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArrayDemoModel[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    CRDemoInfoModel *demoInfoModel = _dataArrayDemoModel[indexPath.section][indexPath.row];
    cell.textLabel.text = demoInfoModel.demoName;
    cell.detailTextLabel.text = demoInfoModel.demoSummary;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRDemoInfoModel *demoInfoModel = _dataArrayDemoModel[indexPath.section][indexPath.row];
    
    if (demoInfoModel.demoVCName) {
        CRBaseViewController *destinationVC = [[NSClassFromString(demoInfoModel.demoVCName) alloc] init];
        [self.navigationController pushViewController:destinationVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.text = _dataArrayTitle[section];
    titleLable.font = [UIFont systemFontOfSize:14];
    [titleLable sizeToFit];
    [titleView addSubview:titleLable];
    [titleLable BearSetRelativeLayoutWithDirection:kDIR_LEFT destinationView:nil parentRelation:YES distance:15 center:YES];
    
    return titleView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
