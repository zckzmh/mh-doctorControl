//
//  HLPDFCatagory.h
//  heletalk-doctor
//
//  Created by Damon on 16/1/7.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLPDFCatagory : NSObject

@property (nonatomic, strong) NSArray *HLPDFArticles;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

+ (instancetype)hl_PDFCatagoryWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
