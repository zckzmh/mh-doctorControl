//
//  DoctorIntroduceViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/19.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth  [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "DoctorIntroduceViewController.h"

@interface DoctorIntroduceViewController ()
@property (nonatomic ,strong) UITextView *textView; /*textView*/
@property (nonatomic ,strong) UILabel *sickLabel; /*sickLabel*/
@property (nonatomic ,strong) UILabel *cureLabel; /*cureLabel*/
@property (nonatomic ,strong) UITextView *cureTextView; /*cureTextView*/

@end

@implementation DoctorIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"医生简介";
//    if (![self.transferModel.pSituation isEqual:[NSNull null]]) {
//        self.textView.text = self.transferModel.pSituation;
//    }
//    if (![self.transferModel.pCure isEqual:[NSNull null]]) {
//        self.cureTextView.text = self.transferModel.pCure;
//    }
    //    CGFloat heigh = [self.textView sizeThatFits:CGSizeMake(BoundWidth-20, CGFLOAT_MAX)].height;
    //    if (heigh>self.textView.frame.size.height) {
    //        self.textView.frame = CGRectMake(10, 10, BoundWidth-20, heigh);
    //    }
    //
    //    if (heigh > BoundHeight-140){
    //
    //        self.textView.frame = CGRectMake(10, 10, BoundWidth-20, BoundHeight-140);
    //    }
    self.textView.text = self.model.dgoodat;
     self.cureTextView.text = self.model.dintroduce;
    [self.view addSubview:self.sickLabel];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.cureLabel];
    [self.view addSubview:self.cureTextView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
    //    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:199/255.0 blue:255/255.0 alpha:1.0];
    self.navigationController.navigationBar.clipsToBounds = NO;
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backPage)];
    [backBtnItem setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem = backBtnItem;

}
-(void)backPage{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-懒加载
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 30+64, BoundWidth-20, (BoundHeight-64)/5)];
        _textView.layer.borderColor = [UIColor colorWithRed:211/255.0 green:212/255.0 blue:213/255.0 alpha:0.8].CGColor;
        _textView.layer.borderWidth = 1.0;
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.scrollEnabled = YES;
        _textView.editable = NO;
    }
    return _textView;
}
-(UILabel *)sickLabel{
    if (!_sickLabel) {
        _sickLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5+64, BoundWidth/2, 20)];
        _sickLabel.text = @"擅长疾病";
        _sickLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [_sickLabel setTextColor:[UIColor blackColor]];
    }
    return _sickLabel;
}

-(UILabel *)cureLabel{
    if (!_cureLabel) {
        _cureLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y+(BoundHeight-64)/5+20, BoundWidth/2, 20)];
        _cureLabel.text = @"医生介绍";
        _cureLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [_cureLabel setTextColor:[UIColor blackColor]];
    }
    return _cureLabel;
}
-(UITextView *)cureTextView{
    if (!_cureTextView) {
        _cureTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y+(BoundHeight-64)/5+45, BoundWidth-20, (BoundHeight-64)/3)];
        _cureTextView.layer.borderColor = [UIColor colorWithRed:211/255.0 green:212/255.0 blue:213/255.0 alpha:0.8].CGColor;
        _cureTextView.layer.borderWidth = 1.0;
        _cureTextView.font = [UIFont systemFontOfSize:13];
        _cureTextView.scrollEnabled = YES;
        _cureTextView.editable = NO;
    }
    return _cureTextView;
}
@end
