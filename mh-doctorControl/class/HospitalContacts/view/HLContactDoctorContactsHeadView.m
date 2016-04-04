//
//  HLContactDoctorContactsHeadView.m
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "HLContactDoctorContactsHeadView.h"

#import "HLContactDoctorGroup.h"

@interface HLContactDoctorContactsHeadView ()

@property (nonatomic, weak) UIButton *bgButton;/**< 按钮 */


@end

@implementation HLContactDoctorContactsHeadView

+(instancetype)HLContactDoctorContactsHeadViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";

    HLContactDoctorContactsHeadView *headView = [[HLContactDoctorContactsHeadView alloc] initWithReuseIdentifier:headIdentifier];

//    headView.open = NO;


    return headView;
}


-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);

        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];


        self.bgButton = bgButton;

    }
    return self;
}


-(void)headBtnClick
{

    self.HLContactDoctorGroup.opened = !self.HLContactDoctorGroup.isOpened;
    if ([self.delegate respondsToSelector:@selector(clickHeadView:)]) {
        [self.delegate clickHeadView:self];
    }
    
}

-(void)setHLContactDoctorGroup:(HLContactDoctorGroup *)HLContactDoctorGroup{

    _HLContactDoctorGroup = HLContactDoctorGroup;
    [self.bgButton setTitle:self.HLContactDoctorGroup.name forState:UIControlStateNormal];
    self.bgButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
}




- (void)didMoveToSuperview
{
    self.bgButton.imageView.transform = self.HLContactDoctorGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _bgButton.frame = self.bounds;
}

@end
