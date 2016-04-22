//
//  PatientCommentTableViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/3.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth  [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "PatientCommentTableViewController.h"
#import "FMDatabase.h"
#import "DoctorInfoModel.h"
@interface PatientCommentTableViewController ()
@property (nonatomic ,strong) NSMutableArray *dataSource; /*dataSource*/
@end

@implementation PatientCommentTableViewController
static NSString *patientCommentID = @"patientCommentID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:patientCommentID];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    [self getUserDatabase];
    [self.tableView reloadData];
}
-(void)getUserDatabase{
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from commentDoc"];
    while ([rs next]) {
        DoctorInfoModel *model = [[DoctorInfoModel alloc] init];
        model.dname = [rs stringForColumn:@"dname"];
        model.username = [rs stringForColumn:@"username"];
        model.comment = [rs stringForColumn:@"comment"];
        model.starRank = [rs intForColumn:@"starRank"];
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
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorInfoModel *model = [self.dataSource objectAtIndex:indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:patientCommentID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 50, 20)];
    nameLable1.text = [NSString stringWithFormat:@"%@ * ",[model.username substringToIndex:1] ];
            nameLable1.font = [UIFont systemFontOfSize:14];
            UILabel *commentLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 200, 20)];
            commentLable1.text = model.comment;
            commentLable1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:nameLable1];
            [cell.contentView addSubview:commentLable1];
            CGFloat imageViewX = BoundWidth*0.7;

            for (int i = 0; i < model.starRank; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 10, 15, 15)];
                imageView.image = [UIImage imageNamed:@"iconfont-star"];
                [cell.contentView addSubview:imageView];
                imageViewX = imageViewX + 15;
            }
    return cell;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
