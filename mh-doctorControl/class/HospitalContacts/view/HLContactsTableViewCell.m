//
//  HLContactsTableViewCell.m
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "HLContactsTableViewCell.h"
#import "UIColor+HEX.h"

@interface HLContactsTableViewCell ()

@property (strong, nonatomic) UIView *bottomLineView;

@end

@implementation HLContactsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#ff929292"];
//        self.acces

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        // Initialization code
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];


        [self.contentView addSubview:_bottomLineView];

        self.textLabel.backgroundColor = [UIColor clearColor];
    }

    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.imageView.frame = CGRectMake(10, 8, 34, 34);
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;

    CGRect rect = self.detailTextLabel.frame;
    rect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    rect.origin.y = CGRectGetMaxY(self.textLabel.frame) + 5;
    self.detailTextLabel.frame = rect;

    CGRect rectLabel = self.textLabel.frame;
    rectLabel.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    self.textLabel.frame = rectLabel;

    _bottomLineView.frame = CGRectMake(0, self.contentView.frame.size.height - 1, [[UIScreen mainScreen]bounds].size.width, 1);

    CGRect rectline = self.bottomLineView.frame;
    rectline.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    self.bottomLineView.frame = rectline;

}
@end
