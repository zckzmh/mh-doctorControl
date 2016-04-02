//
//  HanyuPinyinOutputFormat.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/28.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "HanyuPinyinOutputFormat.h"

@implementation HanyuPinyinOutputFormat


- (id)init {
    if (self = [super init]) {
        [self restoreDefault];
    }
    return self;
}

- (void)restoreDefault {
    self.vCharType = VCharTypeWithUAndColon;
    self.caseType = CaseTypeLowercase;
    self.toneType = ToneTypeWithToneNumber;
}
@end
