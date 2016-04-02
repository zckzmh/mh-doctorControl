//
//  DoctorInfoTableViewCell.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/2.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "DoctorInfoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DoctorInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *officeLabel;

@end
@implementation DoctorInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width/2;
}
-(void)setDoctorModel:(DoctorInfoModel *)doctorModel{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:doctorModel.imagePath]
                          placeholderImage:[UIImage imageNamed:@"iconfont-portrait"]];
    self.nameLabel.text = doctorModel.dname;
    self.positionLabel.text = doctorModel.dposition;
    self.hospitalLabel.text = doctorModel.dhospital;
    self.officeLabel.text = doctorModel.doffice;

}


@end
