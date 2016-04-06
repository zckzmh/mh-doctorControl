//
//  WebViewInfoViewController.m
//  mh-doctorControl
//
//  Created by minghanzhao on 16/4/6.
//  Copyright © 2016年 minghanzhao. All rights reserved.
//

#import "WebViewInfoViewController.h"

@interface WebViewInfoViewController ()<UIWebViewDelegate>
@property (nonatomic ,strong) UIWebView *webView; /*webView*/
@property(nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation WebViewInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"web/pageOne.html"];
    NSURL* url = [NSURL fileURLWithPath:filePath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webView loadRequest:request];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backPage)];
    [backBtnItem setTintColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}
-(void)backPage{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator setCenter:self.view.center];
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activityIndicator stopAnimating];
    
}

-(UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator)
        _activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    return _activityIndicator;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _webView.delegate = self;
    }
    return _webView;
}


@end
