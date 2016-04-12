//
//  HomeViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/1.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#define BoundWidth [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height
#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "FamousDoctorSearchTableViewController.h"
#import "HLHospitalContactViewController.h"
#import "HLPDFCatagoryController.h"
#import "QRCodeReaderViewController.h"
#import "WebViewInfoViewController.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic ,strong) UIImageView *imaeView; /*imageView*/
@property (nonatomic ,strong) UIScrollView *scrollView; /*scrollView*/
@property (nonatomic ,strong) UICollectionView *collectionView; /*collectionView*/
@property (nonatomic ,strong) NSMutableArray *dataSource; /*dataSource*/
@property (nonatomic ,strong) UITableView *tableView; /*tableView*/
@property (nonatomic ,strong) NSMutableArray *source; /*source*/
@property (nonatomic ,strong) SDCycleScrollView *sdcycle; /*sdcycle*/
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.sdcycle];
    [self.scrollView addSubview:self.collectionView];
    [self.scrollView addSubview:self.tableView];
}

#pragma mark - UICollectionViewDelegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    if (cell==nil) {
        cell=[[UICollectionViewCell alloc]init];
    }else
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.backgroundColor=[UIColor whiteColor];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    NSDictionary *dic=[self.dataSource objectAtIndex:indexPath.row];
    imageView.image=[UIImage imageNamed:[dic valueForKey:@"image"]];
    [cell.contentView addSubview:imageView];
    
    [imageView setCenter:CGPointMake(cell.contentView.center.x, cell.contentView.center.y-10)];
    
    UILabel *nameLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, (BoundWidth-2)/3, 20)];
    [nameLable setTextAlignment:NSTextAlignmentCenter];
    nameLable.text=[dic valueForKey:@"name"];
    nameLable.font = [UIFont systemFontOfSize:13];
//    nameLable.font=[UIFont fontWithName:@"Lato-Regular" size:11];
    [cell.contentView addSubview:nameLable];
    nameLable.center=CGPointMake(cell.contentView.center.x, cell.contentView.center.y+34);
    

    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        FamousDoctorSearchTableViewController *vc = [[FamousDoctorSearchTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1){
        HLHospitalContactViewController *vc = [[HLHospitalContactViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2){
        HLPDFCatagoryController *vc = [[HLPDFCatagoryController alloc] initWithStyle:UITableViewStylePlain];
         vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3){
        [self showQRcode];
    }
}

-(void)showQRcode{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    //    然后判断用户的权限
    
    
    
    if (authStatus == AVAuthorizationStatusDenied)
    {
        
        
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"母子健康手册无法获取系统相机权限。需要您授权后才能使用扫一扫功能。是否要跳转设置？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"授权" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];           [[UIApplication sharedApplication] openURL:url];
                
            }
        }];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [vc addAction:actionOK];
        [vc addAction:actionCancel];
        
        [self presentViewController:vc animated:YES completion:^{
            
        }];
        
        
        return;
    }
    
    
    NSArray *types = @[AVMetadataObjectTypeQRCode];
    QRCodeReaderViewController *reader        = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"扫描结束");
        }];
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    else
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    NSDictionary *dic=[self.source objectAtIndex:indexPath.row];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 64, 64)];

    imageView.image = [UIImage imageNamed:[dic objectForKey:@"imageArray"]];
    [cell.contentView addSubview:imageView];
    imageView.layer.cornerRadius = 10.0;
    imageView.layer.masksToBounds = YES;
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(108, 8, BoundWidth-116, 20)];

    titleLabel.text = [dic objectForKey:@"titleArray"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:titleLabel];
    
    UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(108, 36, BoundWidth-116, 36)];
    contentLabel.textColor=[UIColor lightGrayColor];
    contentLabel.font = [UIFont systemFontOfSize:10];
    contentLabel.text = [dic objectForKey:@"contentArray"];
    contentLabel.numberOfLines=2;
    [cell.contentView addSubview:contentLabel];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            WebViewInfoViewController *vc = [[WebViewInfoViewController alloc] init];
            vc.webName = @"pageOne.html";
            vc.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            WebViewInfoViewController *vc = [[WebViewInfoViewController alloc] init];
            vc.webName = @"pageTwo.html";
            vc.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            WebViewInfoViewController *vc = [[WebViewInfoViewController alloc] init];
            vc.webName = @"pageThree.html";
            vc.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            WebViewInfoViewController *vc = [[WebViewInfoViewController alloc] init];
            vc.webName = @"pageFour.html";
            vc.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            WebViewInfoViewController *vc = [[WebViewInfoViewController alloc] init];
            vc.webName = @"pageFive.html";
            vc.hidesBottomBarWhenPushed= YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark-懒加载
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
        NSArray *imageArray=@[@"famousDoc",@"hospitalDoc",@"doctorChat",@"scanCode"];
        NSArray *nameArray=@[@"名医搜索",@"院内名医",@"医生论坛",@"扫一扫"];
        
        for (int i=0; i<4; i++) {
            NSDictionary *dic=@{@"image":[imageArray objectAtIndex:i],@"name":[nameArray objectAtIndex:i]};
            [_dataSource addObject:dic];
        }
    }
    return _dataSource;
    
}

-(NSMutableArray *)source{
    if (!_source) {
        _source = [[NSMutableArray alloc] init];
        NSArray *itemImageArray = @[@"itemImageOne",@"itemImageTwo",@"itemImageThree",@"itemImageFour",@"itemImageFive"];
        NSString *titleStringOne = @"美国骨科医师协会(AAOS)2016年会开幕";
        NSString *titleStringTwo = @"大盘点：6种铂类化疗药的对比";
        NSString *titleStringThree = @"胡振杰教授：血液净化走进ICU助力感染久治";
        NSString *titleStringFour = @"自身免疫病也可以行肿瘤免疫治疗";
        NSString *titleStringFive = @"脓毒症诊断：那种评分标准更适合ICU";
        
        NSString *contenteStringOne = @"顺铂是多种实体瘤的一线用药，可作为放疗增敏剂。疗效可观，抗癌普广";
        NSString *contentStringTwo = @"长期以来，血液净化膜材的研究一直受到世界各国的重视。目前，已研发用于血液净化的高分子膜材";
        NSString *contentStringThree = @"美国骨科医师学会2016年会将于3月1日召开，美国奥兰多当地时间2月29日丁香园前方报道小分队抵达奥兰多橘郡会展中心，经过了媒体注册后。。。";
        NSString *contentStringFour = @"免疫结点抑制剂十一尅新型的抗肿瘤药物，其主要机制在于增强机体自身的肿瘤-特异性免疫";
        NSString *contentStringFive = @"脓毒症患者是挽留不很高，是一组由感染引起的综合征，其定义并不十分明确";
        
        NSArray *titleArray = @[titleStringOne,titleStringTwo,titleStringThree,titleStringFour,titleStringFive];
        NSArray *contentArray = @[contenteStringOne,contentStringTwo,contentStringThree,contentStringFour,contentStringFive];
        for (int i = 0; i<5; i++) {
            NSDictionary *dic = @{@"imageArray":[itemImageArray objectAtIndex:i],@"titleArray":[titleArray objectAtIndex:i],@"contentArray":[contentArray objectAtIndex:i]};
            [_source addObject:dic];
        }
    }
    return _source;
}
//-(UIImageView *)imaeView{
//    if (!_imaeView) {
//        _imaeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/3)];
//        _imaeView.image = [UIImage imageNamed:@"homePageThree"];
//    }
//    return _imaeView;
//}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
        _scrollView.scrollEnabled = YES;
        _scrollView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        _scrollView.contentInset = UIEdgeInsetsMake(0 , 0 , 64, 0);
        _scrollView.contentSize = CGSizeMake(BoundWidth, BoundWidth/3+BoundWidth/4+5*80-54);
    }
    return _scrollView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((BoundWidth-0.3)/4, (BoundWidth-0.3)/4);
        layout.minimumLineSpacing = 0.1;
        layout.minimumInteritemSpacing = 0.1;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width/3, BoundWidth, BoundWidth/4) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    }
    return _collectionView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BoundWidth/3+BoundWidth/4, BoundWidth, BoundHeight) style:UITableViewStyleGrouped];
        _tableView.rowHeight = 80;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
-(SDCycleScrollView *)sdcycle{
    if (!_sdcycle) {
        NSMutableArray *images = [[NSMutableArray alloc] init];
        [images addObject:[UIImage imageNamed:@"homePageOne"]];
        [images addObject:[UIImage imageNamed:@"homePageTwo"]];
        [images addObject:[UIImage imageNamed:@"homePageThree"]];
        _sdcycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BoundWidth, BoundWidth/3) imageNamesGroup:images];
        _sdcycle.autoScrollTimeInterval = 4.0;
    }
    return _sdcycle;
}

@end
