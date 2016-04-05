//
//  OpenServiceTableViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/3.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "OpenServiceTableViewController.h"

@interface OpenServiceTableViewController ()

@end

@implementation OpenServiceTableViewController
static NSString *openServiceID = @"openServiceID";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:openServiceID];
    self.tableView.scrollEnabled = NO;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:openServiceID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:{
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 25, 25)];
            imageView1.image = [UIImage imageNamed:@"iconfont-weixin"];
            UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 100, 10)];
            titleLabel1.text = @"在线咨询";
            titleLabel1.font = [UIFont systemFontOfSize:15];
            UILabel *itemLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(43, 25, 200, 20)];
            itemLabel1.text = @"与医生通过文、图片、语音交流病情";
            itemLabel1.font = [UIFont systemFontOfSize:12];
            itemLabel1.textColor = [UIColor grayColor];
            [cell.contentView addSubview:imageView1];
            [cell.contentView addSubview:titleLabel1];
            [cell.contentView addSubview:itemLabel1];
            break;
        }
        case 1:{
            UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 25, 25)];
            imageView2.image = [UIImage imageNamed:@"iconfont-dianhua"];
            UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 100, 10)];
            titleLabel2.text = @"电话咨询";
            titleLabel2.font = [UIFont systemFontOfSize:15];
            UILabel *itemLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(43, 25, 200, 20)];
            itemLabel2.text = @"在选定的时间电话咨询病情";
            itemLabel2.font = [UIFont systemFontOfSize:12];
            itemLabel2.textColor = [UIColor grayColor];
            [cell.contentView addSubview:imageView2];
            [cell.contentView addSubview:titleLabel2];
            [cell.contentView addSubview:itemLabel2];
            break;
        }
        case 2:{
            UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 25, 25)];
            imageView3.image = [UIImage imageNamed:@"iconfont-date"];
            UILabel *titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 100, 10)];
            titleLabel3.text = @"门诊预约";
            titleLabel3.font = [UIFont systemFontOfSize:15];
            UILabel *itemLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(43, 25, 200, 20)];
            itemLabel3.text = @"预约专家到医院挂号就诊";
            itemLabel3.font = [UIFont systemFontOfSize:12];
            itemLabel3.textColor = [UIColor grayColor];
            [cell.contentView addSubview:imageView3];
            [cell.contentView addSubview:titleLabel3];
            [cell.contentView addSubview:itemLabel3];
            break;
        }
        default:
            break;
    }
    return cell;
}




@end
