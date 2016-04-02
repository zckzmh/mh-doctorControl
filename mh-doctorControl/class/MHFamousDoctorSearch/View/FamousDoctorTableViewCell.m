//
//  FamousDoctorTableViewCell.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/30.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "FamousDoctorTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FamousDoctorTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *officeLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodatLabel;


@end
@implementation FamousDoctorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2.0;

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

@end
