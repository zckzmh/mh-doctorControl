//
//  LoginViewController.m
//  lz-movieticket
//
//  Created by minghanzhao on 16/3/14.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "LoginViewController.h"
#import "FMDataBase.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@end

@implementation LoginViewController
{
    NSString *userpassword;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 8.0;
}
- (IBAction)loginAccount:(id)sender {
    if ([self.passwordLabel.text isEqualToString:[self getUserDatabase]]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.nameLabel.text forKey:@"name"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else{
        UIAlertController *exitOrNot = [UIAlertController alertControllerWithTitle:nil message:@"用户名或密码有误!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *downloadAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [exitOrNot addAction:downloadAction];
        [self presentViewController:exitOrNot animated:YES completion:^{
            
        }];
    }
}

-(NSString *)getUserDatabase{
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from userInfo where name = ?",self.nameLabel.text];
    while ([rs next]) {
        NSLog(@"%@",
              [rs stringForColumn:@"name"]);
        userpassword = [rs stringForColumn:@"password"];
        
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
    
    return userpassword;
}

- (IBAction)dismissVIew:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
