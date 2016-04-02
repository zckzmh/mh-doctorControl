//
//  DoctorInfoModel.h
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/30.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorInfoModel : NSObject
@property (nonatomic ,strong) NSString *imagePath; /*图片路径*/
@property (nonatomic ,strong) NSString *dname; /*医生姓名*/
@property (nonatomic ,strong) NSString *dposition; /*医生职位*/
@property (nonatomic ,strong) NSString *dhospital; /*医院*/
@property (nonatomic ,strong) NSString *doffice; /*科室*/
@property (nonatomic ,strong) NSString *dgoodat; /*擅长*/
@property (nonatomic ,strong) NSString *dintroduce; /*<##>*/
@end
