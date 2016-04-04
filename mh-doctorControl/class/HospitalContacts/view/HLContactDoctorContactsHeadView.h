//
//  HLContactDoctorContactsHeadView.h
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLContactDoctorGroup,HLContactDoctorContactsHeadView;

@protocol HLContactDoctorContactsHeadViewDelegate <NSObject>

@optional

- (void)clickHeadView:(HLContactDoctorContactsHeadView *)HLContactDoctorContactsHeadView;

@end

@interface HLContactDoctorContactsHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) HLContactDoctorGroup *HLContactDoctorGroup;

@property (nonatomic, weak) id<HLContactDoctorContactsHeadViewDelegate> delegate;



+ (instancetype)HLContactDoctorContactsHeadViewWithTableView:(UITableView *)tableView;

@end






