//
//  HLPDFManager.m
//  heletalk-doctor
//
//  Created by Damon on 16/1/8.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import "HLPDFManager.h"

#import "AFNetworking.h"
#import "SVProgressHUD.h"
//#import "MyMD5.h"

#import "CommonCrypto/CommonDigest.h"


//(void (^)())fail
@interface HLPDFManager ()

@property (nonatomic, strong) NSProgress *downloadProgress;/**< 下载进度监听 */
@property (nonatomic, assign) CGFloat progressFloat;/**< 下载进度 */

@property (strong, nonatomic) NSString *diskCachePath;/**< 缓存文件路径 */
@property (nonatomic, strong) NSFileManager *fileManager;/**< 文件管理者 */

@property (nonatomic, copy) CompletionBlock completionBlock;/**< 完成回调 */

@end

@implementation HLPDFManager



#pragma - init method
+(HLPDFManager *)sharedHLPDFManager{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

#pragma - life cycle

- (id)init {

    return [self initWithNamespace:@"default"];
}

- (id)initWithNamespace:(NSString *)ns {

    if ((self = [super init])) {

        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];

        NSString *cachePath = [docDir stringByAppendingPathComponent:@"com.heletech.jmyy.pdf"];
        self.diskCachePath = cachePath;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        self.fileManager = fileManager;

        if (![fileManager fileExistsAtPath:self.diskCachePath]) {

            [fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
    }
    
    return self;
}

- (void)dealloc{

    [self.downloadProgress removeObserver:self forKeyPath:@"completedUnitCount"];
}




#pragma - private method
-(NSString *)cachedFileNameWithURL:(NSString *)url
{
    const char *cStr = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

#pragma - public method
- (NSString *)PDFCachePathWithURL:(NSString *)url{

    NSString *filename = [self cachedFileNameWithURL:url];
    return [self.diskCachePath stringByAppendingPathComponent:filename];
}

-(BOOL)fileExitWithURL:(NSString *)url{

    return [self.fileManager fileExistsAtPath:[self PDFCachePathWithURL:url]];
}

-(void)downloadPDFWithURL:(NSString *)url{

    [self downloadPDFWithURL:url completion:nil];

}

-(void)downloadPDFWithURL:(NSString *)url completion:(CompletionBlock)completion{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSProgress* progress = nil;
    
    self.downloadProgress = progress;
    // 4. 创建下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress *progress){} destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        return [NSURL fileURLWithPath:[self PDFCachePathWithURL:url]];

    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {


    }];

    [progress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
    [task resume];

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD showProgress:0 status:@"正在下载..."];
//    [SVProgressHUD showWithStatus:@"正在下载..."];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];

    self.completionBlock = completion;



}


#pragma - SVProgress showProgress private method
- (void)increaseProgress {
    [SVProgressHUD showWithStatus:@"正在下载..."];
//    [SVProgressHUD showProgress:self.progressFloat status:@"正在下载..."];
//    if(self.progressFloat < 1.0f)
//        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
//    else
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}
- (void)dismiss {
    [SVProgressHUD dismiss];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.completionBlock();
    });

}

#pragma - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if ([object isKindOfClass:[NSProgress class]]) {

        NSProgress *progress = (NSProgress *)object;
        self.progressFloat = 1.0 * progress.completedUnitCount / progress.totalUnitCount;
    }

}
@end
