//
//  DoctorGroup.m
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import "HLContactDoctorGroup.h"
#import "HLContactDoctor.h"

@implementation HLContactDoctorGroup


//-(id)init{
//    if (self=[super init]) {
//
//        self.doctors =
//        @property (nonatomic, copy) NSString *name;
//
//        @property (nonatomic, assign, getter = isOpened) BOOL opened;
//    }
//    return self;
//}
//-(id)initWithDic:(NSDictionary *)dic{
//    if (self=[super init]) {
//
//        self.hospital=[dic objectForKey:@"hospital"];
//        self.department=[dic objectForKey:@"department"];
//        self.huanxinId=[dic objectForKey:@"huanxinId"];
//        self.hospitalCode=[dic objectForKey:@"hospitalCode"];
//        self.technicalTitle=[dic objectForKey:@"technicalTitle"];
//        self.departmentCode=[dic objectForKey:@"departmentCode"];
//        self.avatar=[dic objectForKey:@"avatar"];
//        self.introduce=[dic objectForKey:@"introduce"];
//    }
//    return self;
//}

//-(NSString *)description
//{
//    return [NSString stringWithFormat:@"hospital=:%@,department=%@,huanxinId=:%@,hositalCode=%@,technicalTitle=:%@,departmentCode=%@,avatar=:%@,introduce=%@",_hospital,_department,_huanxinId,_hospitalCode,_technicalTitle,_departmentCode,_avatar,_introduce];
//
//}


+ (instancetype)hl_ContactDoctorGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];

        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in self.HLContactDoctors) {
            HLContactDoctor *doctor = [HLContactDoctor HLContactDoctorWithDict:dict];
            [tempArray addObject:doctor];
        }
        self.HLContactDoctors = tempArray;
    }
    return self;
}

@end
