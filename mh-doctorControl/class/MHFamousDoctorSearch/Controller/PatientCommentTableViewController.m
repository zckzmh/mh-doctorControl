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

@interface PatientCommentTableViewController ()

@end

@implementation PatientCommentTableViewController
static NSString *patientCommentID = @"patientCommentID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:patientCommentID];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:patientCommentID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            UILabel *nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 50, 20)];
            nameLable1.text = @"郑*";
            nameLable1.font = [UIFont systemFontOfSize:14];
            UILabel *commentLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
            commentLable1.text = @"谢谢";
            commentLable1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:nameLable1];
            [cell.contentView addSubview:commentLable1];
            CGFloat imageViewX = BoundWidth*0.7;
            for (int i = 0; i < 5; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 10, 15, 15)];
                imageView.image = [UIImage imageNamed:@"iconfont-star"];
                [cell.contentView addSubview:imageView];
                imageViewX = imageViewX + 15;
            }
            break;
        }
        case 1:
        {
            UILabel *nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 50, 20)];
            nameLable1.text = @"马*";
            nameLable1.font = [UIFont systemFontOfSize:14];
            UILabel *commentLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
            commentLable1.text = @"谢谢";
            commentLable1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:nameLable1];
            [cell.contentView addSubview:commentLable1];
            CGFloat imageViewX = BoundWidth*0.7;
            for (int i = 0; i < 5; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 10, 15, 15)];
                imageView.image = [UIImage imageNamed:@"iconfont-star"];
                [cell.contentView addSubview:imageView];
                imageViewX = imageViewX + 15;
            }
            break;
        }
        case 2:
        {
            UILabel *nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 50, 20)];
            nameLable1.text = @"王*";
            nameLable1.font = [UIFont systemFontOfSize:14];
            UILabel *commentLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
            commentLable1.text = @"专业负责";
            commentLable1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:nameLable1];
            [cell.contentView addSubview:commentLable1];
            CGFloat imageViewX = BoundWidth*0.7;
            for (int i = 0; i < 5; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 10, 15, 15)];
                imageView.image = [UIImage imageNamed:@"iconfont-star"];
                [cell.contentView addSubview:imageView];
                imageViewX = imageViewX + 15;
            }
            break;
        }
        case 3:
        {
            UILabel *nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 50, 20)];
            nameLable1.text = @"姜**";
            nameLable1.font = [UIFont systemFontOfSize:14];
            UILabel *commentLable1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
            commentLable1.text = @"对患者非常负责";
            commentLable1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:nameLable1];
            [cell.contentView addSubview:commentLable1];
            CGFloat imageViewX = BoundWidth*0.7;
            for (int i = 0; i < 5; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, 10, 15, 15)];
                imageView.image = [UIImage imageNamed:@"iconfont-star"];
                [cell.contentView addSubview:imageView];
                imageViewX = imageViewX + 15;
            }
            break;
        }
        default:
            break;
    }
    return cell;
}


@end
