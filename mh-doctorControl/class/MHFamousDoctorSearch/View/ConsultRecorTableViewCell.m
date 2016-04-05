//
//  ConsultRecorTableViewCell.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/5.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "ConsultRecorTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ConsultRecorTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation ConsultRecorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
}

-(void)setHeadUrl:(NSString *)headUrl{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headUrl]
                          placeholderImage:[UIImage imageNamed:@"iconfont-portrait"]];
}
-(void)setDescribe:(NSString *)describe{
    self.describeLabel.text = describe;
}
-(void)setName:(NSString *)name{
    self.nameLabel.text = name;
}
@end
