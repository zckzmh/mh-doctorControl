//
//  AppDelegate.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@interface AppDelegate ()
@property (nonatomic ,strong) MainViewController *mainVc; /*mainVc*/
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.mainVc;
    
    return YES;
}

-(MainViewController *)mainVc{
    if (!_mainVc) {
        _mainVc = [[MainViewController alloc] init];
    }
    return _mainVc;
}

@end
