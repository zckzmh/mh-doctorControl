//
//  AppDelegate.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FMDatabase.h"
@interface AppDelegate ()
@property (nonatomic ,strong) MainViewController *mainVc; /*mainVc*/
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.mainVc;
    [self.window makeKeyAndVisible];
    [self getUserDatabase];
    return YES;
}

-(void)getUserDatabase{
    NSString *dbpath = @"/Users/minghanzhao/Desktop/毕业设计/mh-doctorControl/doctor.sqlite";
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from userInfo"];
    while ([rs next]) {
        NSLog(@"%@",
              [rs stringForColumn:@"name"]);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[rs stringForColumn:@"name"] forKey:@"name"];
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
-(MainViewController *)mainVc{
    if (!_mainVc) {
        _mainVc = [[MainViewController alloc] init];
    }
    return _mainVc;
}

@end
