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
#import "InfoChooseViewController.h"
@interface DoctorFunctionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView; /*tableView*/
@property (nonatomic ,strong) InfoChooseViewController *infoVC; /*infoVC*/
@property (nonatomic ,strong) UIView *endView; /*endView*/
@property (nonatomic ,strong) UIButton *addprivateDocBtn; /*addprivateDocBtn*/
@property (nonatomic ,strong) UIButton *commentDocBtn; /*commentDocBtn*/
@property (nonatomic ,strong) UIView *middleView; /*middleView*/
@end

@implementation DoctorFunctionViewController
static NSString *doctorInfoID = @"doctorInfoID";
static NSString *doctorIntroduceID = @"doctorIntroduceID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.endView];
    [self.endView addSubview:self.addprivateDocBtn];
    [self.endView addSubview:self.commentDocBtn];
    [self.endView addSubview:self.middleView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DoctorInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:doctorInfoID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:doctorIntroduceID];
    self.tableView.tableFooterView = self.infoVC.view;
    [self addChildViewController:self.infoVC];
    [self.infoVC didMoveToParentViewController:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:199/255.0 blue:255/255.0 alpha:1.0];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backPage)];
    [backBtnItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backBtnItem;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
-(void)backPage{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-UITableViewDelegate

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.doctorModel = self.doctorModel;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:doctorIntroduceID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:0 green:199/255.0 blue:255/255.0 alpha:1.0];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.doctorModel.dgoodat;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    if (indexPath.row == 1) {
//        InfoChooseViewController *vc = [[InfoChooseViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight-44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(InfoChooseViewController *)infoVC{
    if (!_infoVC) {
        _infoVC = [[InfoChooseViewController alloc] init];
    }
    return _infoVC;
}
-(UIView *)endView{
    if (!_endView) {
        _endView = [[UIView alloc] initWithFrame:CGRectMake(0, BoundHeight-40, BoundWidth, 40)];
        _endView.backgroundColor = [UIColor whiteColor];
    }
    return _endView;
}
-(UIButton *)addprivateDocBtn{
    if (!_addprivateDocBtn) {
        _addprivateDocBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BoundWidth/2-1, 40)];
//        _addprivateDocBtn.backgroundColor = [UIColor blueColor];
        [_addprivateDocBtn setTitle:@"＋添加私人医生" forState:UIControlStateNormal];
        _addprivateDocBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addprivateDocBtn setTitleColor:[UIColor colorWithRed:0 green:199/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    return _addprivateDocBtn;
}
-(UIButton *)commentDocBtn{
    if (!_commentDocBtn) {
        _commentDocBtn = [[UIButton alloc] initWithFrame:CGRectMake(BoundWidth/2, 0, BoundWidth/2, 40)];
        [_commentDocBtn setTitle:@"评价医生" forState:UIControlStateNormal];
        _commentDocBtn.titleLabel.font = [UIFont systemFontOfSize:15];
          [_commentDocBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    return _commentDocBtn;
}
-(UIView *)middleView{
    if (!_middleView) {
        _middleView = [[UIView alloc] initWithFrame:CGRectMake(BoundWidth/2-1, 5, 1, 30)];
        _middleView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    }
    return _middleView;
}
@end
