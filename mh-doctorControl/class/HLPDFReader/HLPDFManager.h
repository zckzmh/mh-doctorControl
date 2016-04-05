//
//  HLPDFManager.h
//  heletalk-doctor
//
//  Created by Damon on 16/1/8.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)();

@interface HLPDFManager : NSObject

/**
 *  获得单例对象
 *
 *  @return 返回单例
 */
+(HLPDFManager *)sharedHLPDFManager;

/**
 *  根据下载路径，下载 pdf 文件，并缓存
 *
 *  @param url 下载路径
 */
-(void)downloadPDFWithURL:(NSString *)url;


/**
 *  根据下载路径，下载 pdf 文件，并缓存.带回调
 *
 *  @param url        下载路径
 *  @param completion 回调
 */
-(void)downloadPDFWithURL:(NSString *)url completion:(CompletionBlock)completion;


/**
 *  根据 url 获得缓存路径
 *
 *  @param url 下载链接
 *
 *  @return 缓存路径
 */
- (NSString *)PDFCachePathWithURL:(NSString *)url;

/**
 *  根据 url 判断文件是否已经下载
 *
 *  @param url 文件下载路径
 *
 *  @return 是否已经下载
 */
-(BOOL)fileExitWithURL:(NSString *)url;

@end
