//
//  DoctorInfoViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "DoctorInfoViewController.h"
#import "FocusViewController.h"
#import "TeamViewController.h"
@interface DoctorInfoViewController ()
@property (nonatomic ,assign) UIViewController *selectedViewController; /*selectedViewController*/
@property (nonatomic ,assign) NSInteger selectedViewControllerIndex; /*selectedViewControllerIndex*/
@property (nonatomic ,strong) UISegmentedControl *segmentedControl; /*segmentedControl*/
@property (nonatomic ,strong) FocusViewController *focusVc; /*focusVc*/
@property (nonatomic ,strong) TeamViewController *teamVc; /*teamVc*/
@property (nonatomic ,strong) NSMutableArray *vcArray; /*vcArray*/
@end

@implementation DoctorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.titleView = self.segmentedControl;
    NSArray *viewControllerArray = @[self.focusVc,self.teamVc];
    NSArray *titleArray = @[@"我的关注",@"我的团队"];
    
    
    for (int i = 0; i<2; i++) {
        NSDictionary *dic = @{@"title":[titleArray objectAtIndex:i],@"viewController":[viewControllerArray objectAtIndex:i]};
        [self.vcArray addObject:dic];
    }
    
    [self pushViewController:self.vcArray];
}
//
//- (void)setViewControllers:(NSArray *)viewControllers
//{
//    if ([_segmentedControl numberOfSegments] > 0) {
//        return;
//    }
//    for (int i = 0; i < [viewControllers count]; i++) {
//        [self pushViewController:viewControllers[i] title:[viewControllers[i] title]];
//    }
//    [_segmentedControl setSelectedSegmentIndex:0];
//    self.selectedViewControllerIndex = 0;
//}
-(void)pushViewController:(NSArray *)viewArray{
    
    for (int i = 0; i<2 ;i++) {
        NSDictionary *dic = [viewArray objectAtIndex:i];
        [self.segmentedControl insertSegmentWithTitle:[dic objectForKey:@"title"] atIndex:self.segmentedControl.numberOfSegments animated:NO];
        [self addChildViewController:[dic objectForKey:@"viewController"]];
        [self.segmentedControl sizeToFit];
    }
    [self.segmentedControl setSelectedSegmentIndex:0];
    self.selectedViewControllerIndex = 0;
}

- (void)segmentedControlSelected:(id)sender
{
    self.selectedViewControllerIndex = self.segmentedControl.selectedSegmentIndex;
}

- (void)setSelectedViewControllerIndex:(NSInteger)index
{
    if (!_selectedViewController) {
        _selectedViewController = self.childViewControllers[index];
            [_selectedViewController view].frame = self.view.frame;
        
        [self.view addSubview:_selectedViewController.view];
        [_selectedViewController didMoveToParentViewController:self];
    } else {
        
        [self transitionFromViewController:_selectedViewController toViewController:self.childViewControllers[index] duration:0.0f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
            _selectedViewController = self.childViewControllers[index];
            _selectedViewControllerIndex = index;
        }];
    }
}
#pragma mark-懒加载
-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] init];
        _segmentedControl.tintColor = [UIColor colorWithRed:94/255.0 green:222/255.0 blue:226/255.0 alpha:1.0];
        [_segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}
-(FocusViewController *)focusVc{
    if (!_focusVc) {
        _focusVc = [[FocusViewController alloc] init];
    }
    return _focusVc;
}
-(TeamViewController *)teamVc{
    if (!_teamVc) {
        _teamVc = [[TeamViewController alloc] init];
    }
    return _teamVc;
}
-(NSMutableArray *)vcArray{
    if (!_vcArray) {
        _vcArray = [[NSMutableArray alloc] init];
    }
    return _vcArray;
}

@end
