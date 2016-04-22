//
//  CommentDoctorViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/19.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth  [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "CommentDoctorViewController.h"
#import "FMDataBase.h"
#import "MBProgressHUD+Add.h"
@interface CommentDoctorViewController ()
@property (nonatomic ,strong) UILabel *commentLabel; /*commentLabel*/
@property (nonatomic ,strong) UILabel *adviceLabel; /*adviceLabel*/
@property (nonatomic ,strong) NSMutableArray *btnArray; /*btnArray*/
@property (nonatomic ,strong) UITextView *cureTextView; /*cureTextView*/
@property (nonatomic ,strong) UIButton *submitBtn; /*submitBtn*/
@end

@implementation CommentDoctorViewController
{
    NSString *name;
    NSInteger starRank;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.commentLabel];
    [self.view addSubview:self.adviceLabel];
    [self.view addSubview:self.cureTextView];
    [self.view addSubview:self.submitBtn];
    CGFloat imageViewX = BoundWidth*0.5;
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(imageViewX, 80, 25, 25)];
        button.tag = i;
        [button addTarget:self action:@selector(chooseStar:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"iconfont-starblock"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"iconfont-star"] forState:UIControlStateSelected];
//        button.selected = YES;
        [self.btnArray addObject:button];
        [self.view addSubview:button];
        imageViewX = imageViewX + 30;
    }
    
    [self.submitBtn addTarget:self action:@selector(addUserComment) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    name = [userDefaultes stringForKey:@"name"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    [leftBtn setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem = leftBtn;
}
-(void)chooseStar:(UIButton *)sender{
    for (int i = 0; i < sender.tag +1; i++) {
        UIButton *btton = [self.btnArray objectAtIndex:i];
        btton.selected = YES;
    }
    for (int m = (int)sender.tag +1; m<5; m++) {
        UIButton *btton = [self.btnArray objectAtIndex:m];
        btton.selected = NO;
    }
    starRank = sender.tag + 1;
}
-(void)dismissVC{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)addUserComment{
    [self getUserDatabase];
}
-(void)getUserDatabase{
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
//    FMResultSet *rs = [db executeQuery:@"select * from userInfo"];
//    while ([rs next]) {
//        NSLog(@"%@",
//              [rs stringForColumn:@"name"]);
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:[rs stringForColumn:@"name"] forKey:@"name"];
//    }
    //        if ([db open])
    //        {
    //            //4.创表
                BOOL result = [db executeUpdate:@"INSERT INTO commentDoc (dname,comment,starRank,username) VALUES (?,?,?,?);",self.doctModel.dname,self.cureTextView.text,@(starRank),name];
    //
    //            BOOL result = [db executeUpdate:@"CREATE TABLE myTeam(id integer not NULL primary key,userid integer,dname varchar,foreign key (userid) references userInfo(userid),foreign key (dname) references doctorInfo(dname));"];
                if (result)
                {
                    NSLog(@"创建表成功");
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }
                else{
                    UIAlertController *exitOrNot = [UIAlertController alertControllerWithTitle:nil message:@"添加评论失败!" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *downloadAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                 
                    [exitOrNot addAction:downloadAction];
                    [self presentViewController:exitOrNot animated:YES completion:^{
                        
                    }];
                }
    
    [db close];
    
    
}
#pragma mark-懒加载
-(UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 100, 30)];
        _commentLabel.text = @"对医生的评价";
        _commentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _commentLabel;
}
-(UILabel *)adviceLabel{
    if (!_adviceLabel) {
        _adviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 100, 30)];
        _adviceLabel.text = @"意见或建议";
        _adviceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _adviceLabel;
}
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
-(UITextView *)cureTextView{
    if (!_cureTextView) {
        _cureTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.adviceLabel.frame.origin.x, self.adviceLabel.frame.origin.y+30, BoundWidth-20, (BoundHeight-64)/3)];
        _cureTextView.layer.borderColor = [UIColor colorWithRed:211/255.0 green:212/255.0 blue:213/255.0 alpha:0.8].CGColor;
        _cureTextView.layer.borderWidth = 1.0;
        _cureTextView.font = [UIFont systemFontOfSize:13];
    
    }
    return _cureTextView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(BoundWidth*0.3/2, BoundHeight*0.6, BoundWidth*0.7, 40)];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [UIColor colorWithRed:75/255.0 green:216/255.0 blue:220/255.0 alpha:1.0];

    }
    return _submitBtn;
}
@end
