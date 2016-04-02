//
//  DoctorFunctionViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth  [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "DoctorFunctionViewController.h"
#import "DoctorInfoTableViewCell.h"
@interface DoctorFunctionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView; /*tableView*/
@end

@implementation DoctorFunctionViewController
static NSString *doctorInfoID = @"doctorInfoID";
static NSString *doctorIntroduceID = @"doctorIntroduceID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DoctorInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:doctorInfoID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:doctorIntroduceID];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:199/255.0 blue:255/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 90;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DoctorInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doctorInfoID forIndexPath:indexPath];
        cell.doctorModel = self.doctorModel;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doctorIntroduceID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0 green:199/255.0 blue:255/255.0 alpha:1.0];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.doctorModel.dgoodat;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
