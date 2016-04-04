//
//  HLContactDoctorGroup.h
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLContactDoctorGroup : NSObject


@property (nonatomic, strong) NSArray *HLContactDoctors;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

+ (instancetype)hl_ContactDoctorGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
