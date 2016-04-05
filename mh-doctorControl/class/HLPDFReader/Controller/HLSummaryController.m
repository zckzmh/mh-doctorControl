//
//  HLSummaryController.m
//  heletalk-doctor
//
//  Created by Damon on 16/1/7.
//  Copyright © 2016年 heletech. All rights reserved.
//

#import "HLSummaryController.h"



#import "UIView+Frame.h"
#import "UIImage+Image.h"


#import "HLPDFCatagory.h"
#import "HLPDFArticle.h"

#import "HLPDFManager.h"
#import "ReaderViewController.h"

#import "SVProgressHUD.h"

#import "FUIButton.h"

#define kHeadViewH 200

#define kHeadViewMinH 64

#define kTabBarViewH 44

@interface HLSummaryController ()<ReaderViewControllerDelegate>


@property (nonatomic, strong) NSString *filePath;/**< 文件路径 */

@property (nonatomic, strong) NSProgress *donloadProgress;/**< 进度条 */

@property (nonatomic, assign) CGFloat progressFloat;/**< 下载进度 */

@property (nonatomic, strong) HLPDFManager *manger;/**<  */


@end

@implementation HLSummaryController

#pragma mark -
#pragma mark - Global Static and Const value in file



#pragma mark -
#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"快速导读";

    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *titleLabel =({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30+64, 0, 0)];
        label.text = @"标题";
        [label sizeToFit];
        label;
    });

    UILabel *titleNameLabel =({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + CGRectGetMaxY(titleLabel.frame), [UIScreen mainScreen].bounds.size.width - 40, 0)];

        label.numberOfLines = 0;

        label.text = [NSString stringWithFormat:@"《%@》",[self.article.articlesName stringByReplacingOccurrencesOfString:@" " withString:@""]];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        [label sizeToFit];
        label;
    });

    UIView *lineViewOne = ({

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 15 + CGRectGetMaxY(titleNameLabel.frame), [UIScreen mainScreen].bounds.size.width - 40, 1.0/3)];
        view.backgroundColor = [UIColor lightGrayColor];
        view;
    });

    UILabel *summaryLabel =({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30 + CGRectGetMaxY(titleNameLabel.frame), 0, 0)];
        label.text = @"摘要";
        [label sizeToFit];
        label;
    });


    UILabel *summaryContentLabel =({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + CGRectGetMaxY(summaryLabel.frame), [UIScreen mainScreen].bounds.size.width - 40, 0)];

        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentNatural;
        label.text = [NSString stringWithFormat:@"%@",[self.article.summary stringByReplacingOccurrencesOfString:@" " withString:@""]];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        [label sizeToFit];

        if(label.frame.size.height > 180){
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, 180);
        }
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        label;
    });

    UIView *lineViewTwo = ({

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 15 + CGRectGetMaxY(summaryContentLabel.frame), [UIScreen mainScreen].bounds.size.width - 40, 1.0/3)];
        view.backgroundColor = [UIColor lightGrayColor];
        view;
    });
    FUIButton *downLoadButton =({
        FUIButton *button = [[FUIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 - 120, 15 + CGRectGetMaxY(lineViewTwo.frame), 100, 40)];
        button.buttonColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:202/255.0 alpha:1];
        [button setImage:[UIImage imageNamed:@"pdfReader_downButton_icon"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, - 10, 0, 0);
        button.adjustsImageWhenHighlighted = NO;
        button.cornerRadius = 5;
        [button setTitle:@"下载" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hl_download) forControlEvents:UIControlEventTouchUpInside];

        button;
    });

    FUIButton *readButton =({
        FUIButton *button = [[FUIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 + 20, 15 + CGRectGetMaxY(lineViewTwo.frame), 100, 40)];
        button.buttonColor = [UIColor colorWithRed:85/255.0 green:187/255.0 blue:202/255.0 alpha:1];
        button.adjustsImageWhenHighlighted = NO;
        [button setImage:[UIImage imageNamed:@"pdfReader_readButton_icon"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, - 10, 0, 0);
        button.cornerRadius = 5;
        [button setTitle:@"阅读" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hl_openPDFReader) forControlEvents:UIControlEventTouchUpInside];
        button;
    });


    [self.view addSubview:titleLabel];
    [self.view addSubview:titleNameLabel];
    [self.view addSubview:lineViewOne];
    [self.view addSubview:summaryLabel];
    [self.view addSubview:summaryContentLabel];
    [self.view addSubview:lineViewTwo];
    [self.view addSubview:downLoadButton];
    [self.view addSubview:readButton];


}

- (void)conversionCharacterInterval:(NSInteger)maxInteger current:(NSString *)currentString withLabel:(UILabel *)label
{
    CGRect rect = [[currentString substringToIndex:1] boundingRectWithSize:CGSizeMake(200,label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: label.font}
                                                                   context:nil];


    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:currentString];
    float strLength = [self getLengthOfString:currentString];
    [attrString addAttribute:NSKernAttributeName value:@(((maxInteger - strLength) * rect.size.width)/(strLength - 1)) range:NSMakeRange(0, strLength)];
    label.attributedText = attrString;
}

-  (float)getLengthOfString:(NSString*)str {

    float strLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0 ; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            strLength++;
        }
        p++;
    }
    return strLength/2;
}

#pragma mark -
#pragma mark - setup methods




#pragma mark -
#pragma mark - UITableViewDelegate




-(void)hl_download{

    if ([[HLPDFManager sharedHLPDFManager] fileExitWithURL:self.article.url]) {

        UIAlertController *exitOrNot = [UIAlertController alertControllerWithTitle:nil message:@"文件已经存在，是否重新下载？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *downloadAction = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[HLPDFManager sharedHLPDFManager] downloadPDFWithURL:self.article.url completion:^{
                [self hl_openPDFReader];
            }];
        }];

        UIAlertAction *readAction = [UIAlertAction actionWithTitle:@"阅读" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self hl_openPDFReader];
        }];


        [exitOrNot addAction:downloadAction];
        [exitOrNot addAction:readAction];
        [self presentViewController:exitOrNot animated:YES completion:^{

        }];
    }else{

        [[HLPDFManager sharedHLPDFManager] downloadPDFWithURL:self.article.url completion:^{
            [self hl_openPDFReader];
        }];
    }


}

-(void)hl_openPDFReader{

    if ([[HLPDFManager sharedHLPDFManager] fileExitWithURL:self.article.url]) {

        NSString *phrase = nil;
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:[[HLPDFManager sharedHLPDFManager] PDFCachePathWithURL:self.article.url ] password:phrase];
        if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            readerViewController.delegate = self; // Set the ReaderViewController delegate to self
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:readerViewController animated:YES completion:NULL];
        }
        else // Log an error so that we know that something went wrong
        {
            [SVProgressHUD showErrorWithStatus:@"文件损坏，请重新下载!"];
        }

    }else{


        UIAlertController *exitOrNot = [UIAlertController alertControllerWithTitle:nil message:@"还没有下载文件，请先下载！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *downloadAction = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[HLPDFManager sharedHLPDFManager] downloadPDFWithURL:self.article.url completion:^{
                [self hl_openPDFReader];
            }];
        }];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];


        [exitOrNot addAction:downloadAction];
        [exitOrNot addAction:cancelAction];
        [self presentViewController:exitOrNot animated:YES completion:^{
            
        }];

    }


}

#pragma mark - ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}





@end
