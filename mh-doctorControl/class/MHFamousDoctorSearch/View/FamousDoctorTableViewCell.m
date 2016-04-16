//
//  FamousDoctorTableViewCell.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/30.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "FamousDoctorTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FMDatabase.h"
@interface FamousDoctorTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *officeLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodatLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;


@end
@implementation FamousDoctorTableViewCell
{
    NSString *name;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2.0;
    self.focusBtn.layer.borderWidth = 0.5;
    self.focusBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.focusBtn.layer.masksToBounds = YES;
    self.focusBtn.layer.cornerRadius = 9.0;

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    name = [userDefaultes stringForKey:@"name"];
}
- (IBAction)focusDoctor:(id)sender {
    
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
            if ([db open])
            {
                //4.创表
                BOOL result = [db executeUpdate:@"INSERT INTO myFocus (userid,dname) VALUES (?,?);",name,self.nameLabel.text];
    
//                BOOL result = [db executeUpdate:@"CREATE TABLE myTeam(id integer not NULL primary key,userid integer,dname varchar,foreign key (userid) references userInfo(userid),foreign key (dname) references doctorInfo(dname));"];
                if (result)
                {
                    NSLog(@"插入成功");
                }
    
    [db close];
    
            }
}
-(void)setDoctorModel:(DoctorInfoModel *)doctorModel{
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:doctorModel.imagePath]
                      placeholderImage:[UIImage imageNamed:@"iconfont-portrait"]];
    self.nameLabel.text = doctorModel.dname;
    self.positionLabel.text = doctorModel.dposition;
    self.addressLabel.text = doctorModel.dhospital;
    self.officeLabel.text = doctorModel.doffice;
    self.goodatLabel.text = doctorModel.dgoodat;
}
-(void)setKey:(NSString *)key{
    if ([key isEqualToString:@"1"]) {
        self.focusBtn.hidden = YES;
    }
}
@end
