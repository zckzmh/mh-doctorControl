//
//  TeamViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "TeamViewController.h"
#import "FamousDoctorTableViewCell.h"
#import "FMDatabase.h"
#import "DoctorInfoModel.h"
@interface TeamViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView; /*tableView*/
@property (nonatomic ,strong) NSMutableArray *dataSource; /*dataSource*/
@end

@implementation TeamViewController
static NSString *myTeamID = @"myTeamID";
- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"我的团队";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self getUserDatabase];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamousDoctorTableViewCell class]) bundle:nil] forCellReuseIdentifier:myTeamID];
    [self.view addSubview:self.tableView];
}
-(void)getUserDatabase{
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select doctorInfo.dname,doctorInfo.dposition,doctorInfo.dhospital,dgoodAt,imagePath,dintroduce,doffice from doctorInfo,myTeam where myTeam.dname = doctorInfo.dname"];
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
    FamousDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myTeamID];
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

#pragma mark-懒加载
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        
    }
    return  _dataSource;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BoundWidth, BoundHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
