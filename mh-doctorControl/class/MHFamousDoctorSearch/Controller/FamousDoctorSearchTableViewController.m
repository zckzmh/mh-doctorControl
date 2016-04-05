//
//  FamousDoctorSearchTableViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/23.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "FamousDoctorSearchTableViewController.h"
#import "MHSearchBar.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "FamousDoctorTableViewCell.h"
#import "DoctorInfoModel.h"
#import "DoctorFunctionViewController.h"
@interface FamousDoctorSearchTableViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) MHSearchBar *searchBar;
@property (nonatomic ,strong) NSMutableArray *dataSource; /*dataSouce*/

@end

@implementation FamousDoctorSearchTableViewController
static NSString *famousDoctCellID = @"famousDoctCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = self.searchBar;
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_withtext"] style:UIBarButtonItemStylePlain target:self action:@selector(backPage)];
    [backBtnItem setTintColor:[UIColor grayColor]];
    [self.navigationItem setLeftBarButtonItem:backBtnItem];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamousDoctorTableViewCell class]) bundle:nil] forCellReuseIdentifier:famousDoctCellID];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
    
}
-(void)backPage{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    UIButton *button = [[UIButton alloc] init];
//    [button setTitle:@"取消" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    

    self.dataSource = nil;
    NSArray *resaultArray = [self.dataSource mutableCopy];
    [self.dataSource removeAllObjects];
    if (textField.text.length > 0 && ![ChineseInclude isIncludeChineseInString:textField.text]) {
        for (int i = 0; i < resaultArray.count; i++) {
            DoctorInfoModel *model = [resaultArray objectAtIndex:i];
            if ([ChineseInclude isIncludeChineseInString:model.dname]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:model.dname];
                NSRange titleReasult = [tempPinYinStr rangeOfString:textField.text options:NSCaseInsensitiveSearch];
                if (titleReasult.length > 0) {
                    [self.dataSource addObject:model];
                    continue;
                }
                NSString *tempPinYinHeader = [PinYinForObjc chineseConvertToPinYinHead:model.dname];
                NSRange titleHeaderReasult = [tempPinYinHeader rangeOfString:textField.text options:NSCaseInsensitiveSearch];
                if (titleHeaderReasult.length > 0) {
                    [self.dataSource addObject:model];
                    continue;
                }
            }
            else{
                NSRange titleResault = [model.dname rangeOfString:textField.text options:NSCaseInsensitiveSearch];
                if (titleResault.length > 0) {
                    [self.dataSource addObject:model];
                }
            }
        }
    }
    else if (textField.text.length > 0 && [ChineseInclude isIncludeChineseInString:textField.text]){
        for (DoctorInfoModel *tempModel in resaultArray) {
            NSRange titleResault = [tempModel.dname rangeOfString:textField.text options:NSCaseInsensitiveSearch];
            if (titleResault.length > 0) {
                [self.dataSource addObject:tempModel];
            }
        }
    }
    [self.tableView reloadData];
    return YES;
}
- (void)cancle
{

    self.navigationItem.rightBarButtonItem = nil;
    
    // 1.关闭键盘
    //    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
}

#pragma mark - 监听scorllerView的拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 1.关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FamousDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:famousDoctCellID forIndexPath:indexPath];
    DoctorInfoModel *model = [self.dataSource objectAtIndex:indexPath.section];
    cell.doctorModel = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorInfoModel *model = [self.dataSource objectAtIndex:indexPath.section];
        DoctorFunctionViewController *vc = [[DoctorFunctionViewController alloc] init];
        vc.doctorModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    
}
-(MHSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[MHSearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DoctorInfo" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *array = [data objectForKey:@"doctorItems"];
        for (NSDictionary *dic in array) {
            DoctorInfoModel *doctorModel = [[DoctorInfoModel alloc] init];
            doctorModel.imagePath = [dic objectForKey:@"imagePath"];
            doctorModel.dname = [dic objectForKey:@"dName"];
            doctorModel.dposition = [dic objectForKey:@"dposition"];
            doctorModel.dhospital = [dic objectForKey:@"dhospital"];
            doctorModel.doffice = [dic objectForKey:@"doffice"];
            doctorModel.dgoodat = [dic objectForKey:@"dgoodat"];
            doctorModel.dintroduce = [dic objectForKey:@"dintroduce"];
            [_dataSource addObject:doctorModel];
        }
        
    }
    return _dataSource;
}

@end
