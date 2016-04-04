//
//  HLContactsProileBaseCell.m
//  ContactsDemo
//
//  Created by Damon on 15/12/3.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "HLContactsProileBaseCell.h"
#import "UIColor+HEX.h"
//#import "UIView+Frame.h"


@interface HLContactsProileBaseCell ()

@property (nonatomic, strong) UIImageView *phone;/**< 手机 */
@property (nonatomic, strong) UIImageView *contact;/**< 通讯录 */

@end

@implementation HLContactsProileBaseCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.textColor = [UIColor colorWithHexString:@"#ff929292"];

        self.phone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contacts_cell_phone"]];
        [self.phone sizeToFit];
        self.contact = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contact_cell_contact"]];

        [self.contact sizeToFit];


//        self.phone.center = CGPointMake(200,10);
//        self.contact.center = CGPointMake(240, 10);



        [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.contact];

    }

    return self;
}

-(void)layoutSubviews{

    [super layoutSubviews];

    CGRect rect = self.detailTextLabel.frame;
    rect.origin.y = CGRectGetMaxY(self.textLabel.frame) + 5;
    self.detailTextLabel.frame = rect;

    self.contact.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 30, self.contentView.center.y);
    self.phone.center = CGPointMake(self.contact.frame.origin.x - 30, self.contentView.center.y);


}

-(void)setPhoneNumber:(BOOL)phoneNumber{

    _phoneNumber = phoneNumber;

    self.phone.hidden = !phoneNumber;
    self.contact.hidden = !phoneNumber;
}
@end
