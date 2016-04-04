//
//  TableViewController.m
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

// model
#import "HLContactDoctorGroup.h"
#import "HLContactDoctor.h"
// view
#import "HLContactsTableViewCell.h"
#import "HLContactDoctorContactsHeadView.h"
// view controller
#import "HLProfileViewController.h"
#import "HLHospitalContactViewController.h"
// 分类
#import "UIImage+Image.h"

@interface HLHospitalContactViewController ()<HLContactDoctorContactsHeadViewDelegate>

@property (nonatomic, strong) NSArray *HLContactDoctorsData;/**< 通讯录总和 */


@end

@implementation HLHospitalContactViewController

#pragma mark -
#pragma mark - Global Static and Const value in file

static NSString *HLContactDoctorCellIdentifier = @"HLContactDoctorCell";

#pragma mark -
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[HLContactsTableViewCell class] forCellReuseIdentifier:HLContactDoctorCellIdentifier];

    [self hl_loadData];



}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.title = @"院内通讯录";

    self.tableView.sectionHeaderHeight = 50;
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    UIColor *navColor = [UIColor colorWithWhite:1 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];

}


#pragma mark -
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.HLContactDoctorsData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    HLContactDoctorGroup *HLContactDoctorGroup = self.HLContactDoctorsData[section];
    NSInteger count = HLContactDoctorGroup.isOpened ? HLContactDoctorGroup.HLContactDoctors.count : 0;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HLContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HLContactDoctorCellIdentifier];

    HLContactDoctorGroup *HLContactDoctorGroup = self.HLContactDoctorsData[indexPath.section];
    HLContactDoctor *HLContactDoctor = HLContactDoctorGroup.HLContactDoctors[indexPath.row];

    cell.imageView.image = [UIImage imageNamed:HLContactDoctor.icon];
    cell.textLabel.text = HLContactDoctor.name;
    cell.detailTextLabel.text = HLContactDoctor.tel;

    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    HLContactDoctorContactsHeadView *headView = [HLContactDoctorContactsHeadView HLContactDoctorContactsHeadViewWithTableView:tableView];

    headView.delegate = self;
    headView.HLContactDoctorGroup = self.HLContactDoctorsData[section];

    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLContactDoctorGroup *HLContactDoctorGroup = self.HLContactDoctorsData[indexPath.section];
    HLContactDoctor *HLContactDoctor = HLContactDoctorGroup.HLContactDoctors[indexPath.row];
    HLProfileViewController *viewController = [[HLProfileViewController alloc] init];

    viewController.HLContactDoctor = HLContactDoctor;
    viewController.HLContactDoctorGroupName = HLContactDoctorGroup.name;
    [self.navigationController pushViewController:viewController animated:YES];
}



#pragma mark -
#pragma mark - HLContactDoctorContactsHeadViewDelegate

- (void)clickHeadView:(HLContactDoctorContactsHeadView *)HLContactDoctorContactsHeadView
{

    [self.tableView reloadData];

}

#pragma mark -
#pragma mark - Event Response

#pragma mark -
#pragma mark - Private Methods

- (void)hl_loadData
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"HLContactDoctors.plist" withExtension:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];

    NSMutableArray *fgArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArray) {

        HLContactDoctorGroup *doctorGroup = [HLContactDoctorGroup hl_ContactDoctorGroupWithDict:dict];

        [fgArray addObject:doctorGroup];
    }

    self.HLContactDoctorsData = fgArray;
}

#pragma mark -
#pragma mark - Getter and Setter
@end
