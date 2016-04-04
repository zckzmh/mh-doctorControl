//
//  HLContactProileHeadView.m
//  ContactsDemo
//
//  Created by Damon on 15/12/3.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "HLContactProileHeadView.h"
#import "NSObject+TextSize.h"


@interface HLContactProileHeadView ()

//@property (nonatomic, weak) UIImageView *backgroundImageView;/**< 背景图*/
@property (nonatomic, weak) UIImageView *pofileIcon;/**< 头像*/
@property (nonatomic, weak) UILabel *nameLabel;/**< 姓名*/

@end

@implementation HLContactProileHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {


        // 76 193 232
        self.backgroundColor  = [UIColor colorWithRed:76/255.0 green:193/255.0 blue:232/255.0 alpha:1];

        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contacts_head_icon"]];

        [self addSubview:image];

        self.pofileIcon = image;

        self.pofileIcon.frame = CGRectMake(0, 0, 70, 70);
        self.pofileIcon.layer.cornerRadius = self.pofileIcon.bounds.size.width * 0.5;
        self.pofileIcon.clipsToBounds = YES;
        self.pofileIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        self.pofileIcon.layer.borderWidth = 3;


        
    }
    return self;
}

-(void)setHLContactDoctorName:(NSString *)HLContactDoctorName{

    _HLContactDoctorName = HLContactDoctorName;

    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = _HLContactDoctorName;
    CGSize size =  [NSObject sizeWithString:label.text font:label.font];
    label.bounds = CGRectMake(0, 0, 0, size.height);
    self.nameLabel = label;
    [self addSubview:label];

}

-(void)layoutSubviews{

    [super layoutSubviews];

    self.pofileIcon.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 + 10);

    CGRect rectLabel = self.nameLabel.frame;
    rectLabel.origin.y = CGRectGetMaxY(self.pofileIcon.frame) + 5;
    rectLabel.size.width = self.bounds.size.width;
    self.nameLabel.frame = rectLabel;

}

@end
