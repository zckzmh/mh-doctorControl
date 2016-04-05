//
//  HLPDFArticle.h
//  heletalk-doctor
//
//  Created by Damon on 16/1/7.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLPDFArticle : NSObject


@property (nonatomic, copy) NSString *articlesName;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *url;


+ (instancetype)PDFArticleWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
