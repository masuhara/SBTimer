//
//  InfoViewController.m
//  SBTimer
//
//  Created by Master on 2015/04/13.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController () <UIWebViewDelegate>

@end

@implementation InfoViewController {
    IBOutlet UIWebView *infoWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    infoWebView.delegate = self;
    infoWebView.scalesPageToFit = YES;
    

    NSURL *url = [NSURL URLWithString:@"http://app.jmad.ne.jp/iphone_app/info/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [infoWebView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
