//
//  HLPDFCatagory.m
//  heletalk-doctor
//
//  Created by Damon on 16/1/7.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import "HLPDFCatagory.h"

#import "HLPDFArticle.h"

@implementation HLPDFCatagory


+ (instancetype)hl_PDFCatagoryWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];

        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in self.HLPDFArticles) {
            HLPDFArticle *doctor = [HLPDFArticle PDFArticleWithDict:dict];
            [tempArray addObject:doctor];
        }
        self.HLPDFArticles = tempArray;
    }
    return self;
}

@end
