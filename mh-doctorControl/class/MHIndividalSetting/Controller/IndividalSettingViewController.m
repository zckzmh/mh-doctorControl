//
//  IndividalSettingViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "IndividalSettingViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FMDataBase.h"
@interface IndividalSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView; /*tableView*/
@end

@implementation IndividalSettingViewController
{
    NSString *headImageURL;
    NSString *name;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    name = [userDefaultes stringForKey:@"name"];
    [self getUserDatabase];
    [self.tableView reloadData];
}
-(void)getUserDatabase{
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from userInfo where name = ?",name];
    while ([rs next]) {
        NSLog(@"%@",
              [rs stringForColumn:@"name"]);
        headImageURL = [rs stringForColumn:@"imagepath"];
   
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    else
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(15,8, 55, 55)];
        imageView.tag=105;
        
        imageView.layer.cornerRadius = 27.5;
        imageView.layer.masksToBounds = YES;
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [cell.contentView addSubview:imageView];
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(95, 15, 100, 20)];
        
        
        label.tag = 2;
        [cell.contentView addSubview:label];
        
        UILabel *label1 =[[UILabel alloc]initWithFrame:CGRectMake(95, 38, 150, 20)];
        
        label1.tag = 3;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:label1];
        label.font = [UIFont systemFontOfSize:14];
        label1.font = [UIFont systemFontOfSize:13];
        if (name.length > 0) {
            label.text = name;
            label1.text = @"已登录";
        }
        else{
            label.text = @"未登录";
            label1.text = @"";
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:headImageURL]
                     placeholderImage:[UIImage imageNamed:@"contacts_head_icon"]];
    }
    else if (indexPath.section == 1){
        cell.textLabel.text = @"修改密码";
        
    }
    else if(indexPath.section == 2){
        cell.textLabel.text =@"关于";
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
        UIViewController *vc = sb.instantiateInitialViewController;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return  _tableView;
}

@end
