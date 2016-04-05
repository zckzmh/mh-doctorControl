//
//  HLPDFArticle.m
//  heletalk-doctor
//
//  Created by Damon on 16/1/7.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import "HLPDFArticle.h"

@implementation HLPDFArticle


+ (instancetype)PDFArticleWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
