//
//  AFNetPackage.h
//  heletalk-doctor
//
//  Created by fpp on 15/9/17.
//  Copyright (c) 2015年 heletech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef NS_ENUM(NSInteger, JMJianjieTypes) {
    
    JMJianJieYYJJ  = 1, /**< 医院简介 */
    JMJianJieKSJJ  = 2, /**< 科室简介 */
    JMJianJieYSYZ  = 4, /**< 饮食原则 */
    JMJianJieJMXW  = 5, /**< 京煤新闻 */
    JMJianJieZYZX  = 6, /**< 专业资讯 */
    JMJianJieLBT   = 7, /**< 轮播图 */
    
};

@interface AFNetPackage : NSObject

/**
 *
 *  检测网络状态
 *
 */
+ (void)netWorkStatus;



/**
 *
 *  JSON方式获取数据
 *
 */
+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;




/**
 *
 *  xml方式获取数据
 *
 */
+ (void)XMLDataWithUrl:(NSString *)urlStr success:(void (^)(id xml))success fail:(void (^)())fail;



/**
 *
 *  get提交json数据
 *
 */
+ (void)getJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;




/**
 *
 *  post提交json数据
 *
 */
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;



/**
 *
 *  下载文件
 *
 */
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail;


/**
 *
 *  文件上传－自定义上传文件名
 *
 */
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL fileName:(NSString *)fileName fileType:(NSString *)fileTye success:(void (^)(id responseObject))success fail:(void (^)())fail;



/**
 *
 *  文件上传－随机生成文件名
 *
 */
+ (void)postUploadWithUrl:(NSString *)urlStr fileUrl:(NSURL *)fileURL success:(void (^)(id responseObject))success fail:(void (^)())fail;
@end
