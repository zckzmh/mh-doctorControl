//
//  HLProfileViewController.h
//  ContactsDemo
//
//  Created by Damon on 15/12/2.
//  Copyright © 2015年 damonwong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLContactDoctor;

@interface HLProfileViewController : UIViewController

@property (nonatomic, strong) HLContactDoctor *HLContactDoctor;/**< 医生 */
@property (nonatomic, strong) NSString *HLContactDoctorGroupName;/**< 科室名 */

@end
