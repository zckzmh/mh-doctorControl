//
//  HLContactsProileSecitonCell.m
//  ContactsDemo
//
//  Created by Damon on 15/12/3.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "HLContactsProileSecitonCell.h"

#import "UIColor+HEX.h"
#import "NSObject+TextSize.h"
#import "UIView+Frame.h"

@interface HLContactsProileSecitonCell ()

@property (nonatomic, weak) UILabel *sectionNameLabel;/**< 分组名称 Label */

@end

@implementation HLContactsProileSecitonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithHexString:@"FF38ADFF"];
        label.text = @"   个人信息";
        label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.height);
        label.backgroundColor = [UIColor whiteColor];

        self.sectionNameLabel = label;
        [self addSubview:label];
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setSectionName:(NSString *)sectionName{

    _sectionName = sectionName;

}







@end
