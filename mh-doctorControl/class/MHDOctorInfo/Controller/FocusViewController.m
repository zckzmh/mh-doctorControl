//
//  FocusViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "FocusViewController.h"
#import "FMDatabase.h"
#import "DoctorInfoModel.h"
#import "FamousDoctorTableViewCell.h"
@interface FocusViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView; /*tableView*/
@property (nonatomic ,strong) NSMutableArray *dataSource; /*dataSource*/
@end

@implementation FocusViewController
{
    NSString *name;
}
static NSString *famousDcotorID = @"famousDcotorID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self getUserDatabase];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamousDoctorTableViewCell class]) bundle:nil] forCellReuseIdentifier:famousDcotorID];
    
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    name = [userDefaultes stringForKey:@"name"];
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    [self getUserDatabase];
    [self.tableView reloadData];
}
-(void)getUserDatabase{
    if (self.dataSource.count >0) {
        [self.dataSource removeAllObjects];
    }
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select doctorInfo.dname,doctorInfo.dposition,doctorInfo.dhospital,dgoodAt,imagePath,dintroduce,doffice from doctorInfo,myFocus where myFocus.dname = doctorInfo.dname and myFocus.userid = ?",name];
    while ([rs next]) {
        DoctorInfoModel *model = [[DoctorInfoModel alloc] init];
        model.dname = [rs stringForColumn:@"dname"];
        model.dposition = [rs stringForColumn:@"dposition"];
        model.dhospital = [rs stringForColumn:@"dhospital"];
        model.dgoodat = [rs stringForColumn:@"dgoodAt"];
        model.imagePath = [rs stringForColumn:@"imagePath"];
        model.dintroduce = [rs stringForColumn:@"dintroduce"];
        model.doffice = [rs stringForColumn:@"doffice"];
        [self.dataSource addObject:model];

    }
    //        if ([db open])
    //        {
    //            //4.创表
    //            BOOL result = [db executeUpdate:@"INSERT INTO allpeople (id, firstname) VALUES (?,?);",@(2),@"zhe"];
    //
    //            BOOL result = [db executeUpdate:@"CREATE TABLE myTeam(id integer not NULL primary key,userid integer,dname varchar,foreign key (userid) references userInfo(userid),foreign key (dname) references doctorInfo(dname));"];
    //            if (result)
    //            {
    //                NSLog(@"创建表成功");
    //            }
    
    [db close];
    
    
}

-(void)deleteUserDatabase:(NSString *)dname{
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];

    //        if ([db open])
    //        {
    //            //4.创表
                BOOL result = [db executeUpdate:@"DELETE FROM myFocus WHERE dname = ?",dname];
    //
    //            BOOL result = [db executeUpdate:@"CREATE TABLE myTeam(id integer not NULL primary key,userid integer,dname varchar,foreign key (userid) references userInfo(userid),foreign key (dname) references doctorInfo(dname));"];
                if (result)
                {
                    NSLog(@"删除成功");
                    [self getUserDatabase];
                    [self.tableView reloadData];
                }
    
    [db close];
    
    
}
#pragma mark - UITableViewDelegate
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamousDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:famousDcotorID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DoctorInfoModel *model = [self.dataSource objectAtIndex:indexPath.section];
    cell.doctorModel = model;
    cell.key = @"1";
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
 
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    DoctorInfoModel *model = [self.dataSource objectAtIndex:indexPath.section];
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        [self deleteUserDatabase:model.dname];
    }
    
}
#pragma mark-懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
