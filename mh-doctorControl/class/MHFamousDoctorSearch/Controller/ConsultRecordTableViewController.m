//
//  ConsultRecordTableViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/3.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "ConsultRecordTableViewController.h"

@interface ConsultRecordTableViewController ()

@end

@implementation ConsultRecordTableViewController
static NSString *consultRecordID = @"consultRecordID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:consultRecordID];
}



#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:consultRecordID forIndexPath:indexPath];
    
    return cell;
}

@end
