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

@interface FocusViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView; /*tableView*/
@end

@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
    cell.textLabel.text = @"我的关注";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
//    NSDictionary *dic=[self.source objectAtIndex:indexPath.row];
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 64, 64)];
//    
//    imageView.image = [UIImage imageNamed:[dic objectForKey:@"imageArray"]];
//    [cell.contentView addSubview:imageView];
//    imageView.layer.cornerRadius = 10.0;
//    imageView.layer.masksToBounds = YES;
//    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(108, 8, BoundWidth-116, 20)];
//    
//    titleLabel.text = [dic objectForKey:@"titleArray"];
//    titleLabel.font = [UIFont systemFontOfSize:14];
//    [cell.contentView addSubview:titleLabel];
//    
//    UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(108, 36, BoundWidth-116, 36)];
//    contentLabel.textColor=[UIColor lightGrayColor];
//    contentLabel.font = [UIFont systemFontOfSize:10];
//    contentLabel.text = [dic objectForKey:@"contentArray"];
//    contentLabel.numberOfLines=2;
//    [cell.contentView addSubview:contentLabel];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

@end
