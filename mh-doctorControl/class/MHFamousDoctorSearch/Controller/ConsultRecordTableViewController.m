//
//  ConsultRecordTableViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/3.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "ConsultRecordTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ConsultRecorTableViewCell.h"
@interface ConsultRecordTableViewController ()

@end

@implementation ConsultRecordTableViewController
static NSString *consultRecordID = @"consultRecordID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConsultRecorTableViewCell class]) bundle:nil] forCellReuseIdentifier:consultRecordID];
}



#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       ConsultRecorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:consultRecordID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
         
            cell.headUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1459866563&di=a49cee55a763b29bfab75d876176d354&src=http://p.3761.com/pic/71271413852950.jpg";
            cell.describe = @"今天早上三个多月的尼泊尔早上起床一只眼睛有眼屎，擦掉之后开始流眼泪，今天流了一天了怎么回事";
            cell.name = @"罗岩";
            break;
        }
        case 1:{
            cell.headUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1459866563&di=ac8418bf93cfc258ae21b39e0891b4ff&src=http://p.3761.com/pic/70691413852950.jpg";
            cell.describe = @"夜里玩手机造成眼睛干涩，有异物感，这是什么症状，了解症状，方便治疗";
            cell.name = @"宿梦苍";
            break;
        }
        default:
            break;
    }

    return cell;
}

@end
