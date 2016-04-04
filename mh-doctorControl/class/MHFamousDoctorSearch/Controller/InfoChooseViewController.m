//
//  InfoChooseViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/3.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define screenW  [[UIScreen mainScreen]bounds].size.width
#define screenH [[UIScreen mainScreen]bounds].size.height
#import "InfoChooseViewController.h"
#import "OpenServiceTableViewController.h"
#import "ConsultRecordTableViewController.h"
#import "PatientCommentTableViewController.h"

@interface InfoChooseViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) OpenServiceTableViewController *seviceVC; /*serviceVC*/
@property (nonatomic ,strong) ConsultRecordTableViewController *consultVC; /*consultVC*/
@property (nonatomic ,strong) PatientCommentTableViewController *patientVC; /*patientVC*/
@property (nonatomic ,strong) UIScrollView *scrollVIew; /*scrollView*/
@property (nonatomic ,strong) UIView *buttonView; /*buttonView*/
@property (nonatomic ,strong) UIView *ktitleTagView; /*ktitleTagView*/
@property (nonatomic ,strong) NSMutableArray *kButtonArrays; /*kButtonArrays*/
@end

@implementation InfoChooseViewController
{
    UIButton *ktitleButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollVIew];
    [self.view addSubview:self.buttonView];
    
    [self titleScrollViewAddButton];
    [self addTableVIewVc];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//}
//#pragma UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if ([[self.scrollVIew class] isSubclassOfClass:[UITableView class]]) return;
//    else if(scrollView.contentOffset.x > screenW/2 && scrollView.contentOffset.x <= screenW/2 +screenW){
//        [self didSelectPage:1];
//    }
//    else if (scrollView.contentOffset.x <= screenW/2){
//        [self didSelectPage:0];
//    }
//    else if (scrollView.contentOffset.x > screenW/2 +screenW){
//        [self didSelectPage:2];
//    }
//}

#pragma mark-private method
-(void)titleScrollViewAddButton{
    NSArray *titleArr = @[@"开通服务",@"咨询记录",@"患者评价"];
    CGFloat titleButtony = 44;
    CGFloat titleButtonx = 0 ;
    for (int i = 0; i<3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(titleButtonx, 0, screenW/3, titleButtony)];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0 green:199/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        if (i == 0) {
            button.selected = YES;
        }
        button.tag = i;
        titleButtonx = screenW/3 * (i+1);
        [button addTarget:self action:@selector(checkTitleButtonSelectorScrollPage:) forControlEvents:UIControlEventTouchDown];
        [self.buttonView addSubview:button];
        [self.kButtonArrays addObject:button];
        
    }
    
}

-(void)checkTitleButtonSelectorScrollPage:(UIButton *)sender{
    int page = (int)sender.tag;
    
    [self didSelectPage:page];
    self.scrollVIew.contentOffset = CGPointMake(screenW * page, 0);
}

-(void)didSelectPage:(int)page{
    if (page == 1 || page == 2) {
        UIButton *btn = self.kButtonArrays[0];
        btn.selected = NO;
    }

    ktitleButton.selected = NO;
    UIButton *button = self.kButtonArrays[page];
    button.selected = YES;
    ktitleButton = button;
//    [UIView animateWithDuration:0.25 animations:^{
//        self.ktitleTagView.frame = CGRectMake(button.frame.origin.x+20, 42, screenW/3-40, 2);
//    }];
}
-(void)addTableVIewVc{
    self.seviceVC.view.frame = CGRectMake(0, 0, self.scrollVIew.frame.size.width, self.scrollVIew.frame.size.height);
    [self.scrollVIew addSubview:self.seviceVC.view];
    [self addChildViewController:self.seviceVC];
    [self.seviceVC didMoveToParentViewController:self];
    self.consultVC.view.frame = CGRectMake(screenW, 0, self.scrollVIew.frame.size.width, self.scrollVIew.frame.size.height);
    [self.scrollVIew addSubview:self.consultVC.view];
    [self addChildViewController:self.consultVC];
    
    [self.consultVC didMoveToParentViewController:self];
    self.patientVC.view.frame = CGRectMake(screenW * 2, 0, self.scrollVIew.frame.size.width, self.scrollVIew.frame.size.height);
    [self.scrollVIew addSubview:self.patientVC.view];
    [self addChildViewController:self.patientVC];
    
    [self.patientVC didMoveToParentViewController:self];
}

#pragma mark-懒加载

-(UIScrollView *)scrollVIew{
    if (!_scrollVIew) {
        _scrollVIew = [[UIScrollView alloc] initWithFrame:CGRectMake(0,44, screenW, screenH)];
        _scrollVIew.pagingEnabled = YES;
        _scrollVIew.delegate = self;
        _scrollVIew.bounces = NO;
        _scrollVIew.scrollEnabled = NO;
        _scrollVIew.contentSize = CGSizeMake(screenW * 3, 0);
        _scrollVIew.backgroundColor = [UIColor whiteColor];
    }
    return _scrollVIew;
}
-(UIView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 44)];
        _buttonView.backgroundColor = [UIColor whiteColor];
    }
    return _buttonView;
}

//-(UIView *)ktitleTagView{
//    if (!_ktitleTagView) {
//        _ktitleTagView = [[UIView alloc] initWithFrame:CGRectMake(20, 42, screenW/3-40, 2)];
//        _ktitleTagView.backgroundColor = [UIColor colorWithRed:255/255.0 green:73/255.0 blue:116/255.0 alpha:1.0];
//        
//    }
//    return _ktitleTagView;
//}
-(NSMutableArray *)kButtonArrays{
    if (!_kButtonArrays) {
        _kButtonArrays = [NSMutableArray array];
    }
    return _kButtonArrays;
}
-(OpenServiceTableViewController *)seviceVC{
    if (!_seviceVC) {
        _seviceVC = [[OpenServiceTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return _seviceVC;
}

-(ConsultRecordTableViewController *)consultVC{
    if (!_consultVC) {
        _consultVC = [[ConsultRecordTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return _consultVC;
}
-(PatientCommentTableViewController *)patientVC{
    if (!_patientVC) {
        _patientVC = [[PatientCommentTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
     }
    return _patientVC;
}
@end
