//
//  HLProfileViewController.m
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "HLProfileViewController.h"

#import "HLContactProileHeadView.h"
#import "HLContactsProileBaseCell.h"
#import "HLContactsProileSecitonCell.h"

#import "HLContactDoctor.h"

#import "UIView+Frame.h"
#import "UIImage+Image.h"
#import "NSObject+addressBook.h"

#import "MBProgressHUD+Add.h"

//#import "AFNetPackage.h"



#define kHeadViewH 200

@interface HLProfileViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UITableView *tableView; /**< 详情展示 tableView */
@property (nonatomic, strong) UIButton *backButton;/**< 返回按钮 */

@end

@implementation HLProfileViewController

#pragma mark -
#pragma mark - Global Static and Const value in file

static NSString *sectionCellIdentifier = @"sectionCell";
static NSString *proileBaseCellIdentifier = @"proileBaseCell";

#pragma mark -
#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"科室医生";

    [self.view addSubview:self.tableView];
    self.title = @"详情";
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self hl_setUp];
}

#pragma mark -
#pragma mark - setup methods

-(void)hl_setUp{

    //view will appear
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    //set up navacation
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

#pragma mark -
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HLContactsProileBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:proileBaseCellIdentifier];

    if (indexPath.row == 0) {
        cell.textLabel.text = self.HLContactDoctor.name;
        cell.phoneNumber = NO;
        cell.detailTextLabel.text = @"姓名";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = self.HLContactDoctor.tel;
        cell.phoneNumber = YES;
        cell.detailTextLabel.text = @"电话";
    }else if (indexPath.row == 2){
        cell.textLabel.text = self.HLContactDoctorGroupName;
        cell.phoneNumber = NO;
        cell.detailTextLabel.text = @"所属科室";
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 220;
    }
    return 36;
}

#pragma mark -
#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionCellIdentifier];
        return cell;
    }

    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 1) {

        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"拨打", @"保存到手机通讯录",@"申请添加为好友",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
}

#pragma mark -
#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {

            //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
            NSString *num = [[NSString alloc] initWithFormat:@"18648480828"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号

    } else if (buttonIndex == 1){

#pragma mark-warning 联系人重复添加问题。
        [NSObject hl_savePhoneNumber:self.HLContactDoctor.tel labelName:@"手机" name:self.HLContactDoctor.name alertViewDelegate:self completion:^(NSString *resultAsString) {
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
        }];
    } else if (buttonIndex == 2){

//        NSString *urlString=[NSString stringWithFormat:@"http://121.43.200.109:3003/babyTalk/api/searchFriend?identity=doctor&key=%@",self.HLContactDoctor.tel];
//        [AFNetPackage getJSONWithUrl:urlString parameters:nil success:^(id responseObject) {
//
//            NSDictionary *diction=[NSJSONSerialization JSONObjectWithData:responseObject
//                                                                  options:NSJSONReadingMutableLeaves
//                                                                    error:nil];
//            NSArray *tempArray = diction[@"data"];
//            NSDictionary *user = [tempArray firstObject];
//            NSString *username = user[@"huanxinId"];
//            NSString *urlString=[NSString stringWithFormat:UserInformationsUrl,@"doctor",LoginHuanxinId];
//            [AFNetPackage getJSONWithUrl:urlString parameters:nil success:^(id responseObject) {
//
//                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                NSDictionary *dic = [[dict objectForKey:@"data"]firstObject];
//                UserFriendInfo *selfInfo =[[UserFriendInfo alloc] initWithDic:dic];
//                EMError *error;
//                [[EaseMob sharedInstance].chatManager addBuddy:username message:[NSString stringWithFormat:@"我是%@",selfInfo.name] error:&error];
//
//                if (error) {
//                    [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
//                }
//                else{
//                    [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
//                }
//
//            } fail:^{
//                
//            }];
//        } fail:^{
//        }];


    }
}



#pragma mark -
#pragma mark - Private Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

#pragma mark -
#pragma mark - Getter and Setter

-(UITableView *)tableView{

    if (!_tableView) {

        //set up tableview
        UITableView *tabelView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];

        _tableView = tabelView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.bounces = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);

        // register cell
        [_tableView registerClass:[HLContactsProileSecitonCell class] forCellReuseIdentifier:sectionCellIdentifier];
        [_tableView registerClass:[HLContactsProileBaseCell class] forCellReuseIdentifier:proileBaseCellIdentifier];

        //add headView
        HLContactProileHeadView *temView = [[HLContactProileHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        temView.HLContactDoctorName = self.HLContactDoctor.name;
        [_tableView addSubview:temView];
        
    }
    return _tableView;
}



@end
