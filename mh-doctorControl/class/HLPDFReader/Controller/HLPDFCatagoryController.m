//
//  HLPDFCatagoryController.m
//  heletalk-doctor
//
//  Created by Damon on 16/1/7.
//  Copyright © 2016年 heletech. All rights reserved.
//

//Model
#import "HLPDFCatagory.h"
#import "HLPDFArticle.h"

//view
#import "HLPDFCatagoryHeadView.h"

//controller
#import "HLSummaryController.h"
#import "HLPDFCatagoryController.h"



@interface HLPDFCatagoryController ()<HLPDFCatagoryHeadViewDelegate>

@property (nonatomic, strong) NSArray *pdfCatagorys;/**< 通讯录总和 */
@property (nonatomic, strong) UIView *tempView;/**< 通讯录总和 */


@end

@implementation HLPDFCatagoryController


#pragma mark -
#pragma mark - Global Static and Const value in file
//static NSString *HLPDFCatagoryCellIdentifier = @"pdfCatagoryCell";
static NSString *HLPDFArticleCellIdentifier = @"HLContactDoctorCell";

#pragma mark -
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.sectionHeaderHeight = 50;
    self.tableView.rowHeight = 50;
    self.title = @"临床指南";

//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HLPDFArticleCellIdentifier];

    [self loadData];



}

- (void)loadData
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"HLPDFCatagory.plist" withExtension:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];

    NSMutableArray *fgArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArray) {

        HLPDFCatagory *doctorGroup = [HLPDFCatagory hl_PDFCatagoryWithDict:dict];
        [fgArray addObject:doctorGroup];
    }

    self.pdfCatagorys = fgArray;
}


#pragma mark -
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.pdfCatagorys.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HLPDFCatagory *pdfCatagory = self.pdfCatagorys[section];
    NSInteger count = pdfCatagory.isOpened ? pdfCatagory.HLPDFArticles.count : 0;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HLPDFArticleCellIdentifier];

    HLPDFCatagory *pdfCatagory = self.pdfCatagorys[indexPath.section];
    HLPDFArticle *HLContactDoctor = pdfCatagory.HLPDFArticles[indexPath.row];
    
    cell.textLabel.text = HLContactDoctor.articlesName;
    cell.imageView.image = [UIImage imageNamed:@"pdfArticles_icon"];
    cell.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{


    HLPDFCatagoryHeadView *headView = [HLPDFCatagoryHeadView HLPDFCatagoryHeadViewWithTableView:tableView];

    headView.delegate = self;
    headView.pdfCatagory = self.pdfCatagorys[section];

    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HLPDFCatagory *pdfCatagory = self.pdfCatagorys[indexPath.section];
    HLPDFArticle *article = pdfCatagory.HLPDFArticles[indexPath.row];
    HLSummaryController *viewController = [[HLSummaryController alloc] init];
    viewController.article = article;

    [self.navigationController pushViewController:viewController animated:YES];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}



#pragma mark -
#pragma mark - HLContactDoctorContactsHeadViewDelegate

//- (void)clickHeadView:(HLContactDoctorContactsHeadView *)HLContactDoctorContactsHeadView
//{
//    [self.tableView reloadData];
//}

- (void)clickHeadView:(HLPDFCatagoryHeadView *)HLPDFCatagoryHeadView{

    [self.tableView reloadData];
}


@end
