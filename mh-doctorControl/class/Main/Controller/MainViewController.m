//
//  MainViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "DoctorInfoViewController.h"
#import "IndividalSettingViewController.h"

@interface MainViewController ()
@property (nonatomic ,strong) HomeViewController *homeVc; /*homeVc*/
@property (nonatomic ,strong) DoctorInfoViewController *doctorVc; /*doctorVc*/
@property (nonatomic ,strong) IndividalSettingViewController *individalVc; /*individalVc*/
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *homeVav    = [[UINavigationController alloc] initWithRootViewController:self.homeVc];
    UINavigationController *doctorNav  = [[UINavigationController alloc] initWithRootViewController:self.doctorVc];
    UINavigationController *indivalNav = [[UINavigationController alloc] initWithRootViewController:self.individalVc];
    self.viewControllers = @[homeVav,doctorNav,indivalNav];
    [self setupTabBar];
     
}

#pragma mark-private-method
- (void)setupTabBar
{
    UITabBar *tabBar = self.tabBar;
    [tabBar setTintColor:[UIColor colorWithRed:94/255.0 green:222/255.0 blue:226/255.0 alpha:1.0]];
    [tabBar setBarTintColor:[UIColor whiteColor]];
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
 
    
    [tabBarItem1 setImage:[UIImage imageNamed:@"shouye"]];
    [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"shouye_select"]];
    
    [tabBarItem2 setImage:[UIImage imageNamed:@"mydoctor"]];
    [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"mydoctor_select"]];
    
    [tabBarItem3 setImage:[UIImage imageNamed:@"wode"]];
    [tabBarItem3 setSelectedImage:[UIImage imageNamed:@"wode_select"]];
    
    tabBarItem1.title = @"首页";
    tabBarItem2.title = @"医生";
    tabBarItem3.title = @"我";
    
}

#pragma mark-懒加载
-(HomeViewController *)homeVc{
    if (!_homeVc) {
        _homeVc = [[HomeViewController alloc] init];
        _homeVc.title = @"首页";
    }
    return _homeVc;
}

-(DoctorInfoViewController *)doctorVc{
    if (!_doctorVc) {
        _doctorVc = [[DoctorInfoViewController alloc] init];
//        _doctorVc.title = @"医生";
    }
    return _doctorVc;
}
-(IndividalSettingViewController *)individalVc{
    if (!_individalVc) {
        _individalVc = [[IndividalSettingViewController alloc] init];
        _individalVc.title = @"我";
    }
    return  _individalVc;
}

@end
