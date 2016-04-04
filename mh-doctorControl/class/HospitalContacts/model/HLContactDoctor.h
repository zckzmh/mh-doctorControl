//
//  HLContactDoctor.h
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLContactDoctor : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *name;


+ (instancetype)HLContactDoctorWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
