//
//  HanyuPinyinOutputFormat.h
//  mh-doctorControl
//
//  Created by minghanzhao on 16/3/28.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//
#ifndef _HanyuPinyinOutputFormat_H_
#define _HanyuPinyinOutputFormat_H_
#import <Foundation/Foundation.h>
typedef enum {
    ToneTypeWithToneNumber,
    ToneTypeWithoutTone,
    ToneTypeWithToneMark
}ToneType;

typedef enum {
    CaseTypeUppercase,
    CaseTypeLowercase
}CaseType;

typedef enum {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
}VCharType;

@interface HanyuPinyinOutputFormat : NSObject
@property(nonatomic, assign) VCharType vCharType;
@property(nonatomic, assign) CaseType caseType;
@property(nonatomic, assign) ToneType toneType;

- (id)init;
- (void)restoreDefault;
@end

#endif