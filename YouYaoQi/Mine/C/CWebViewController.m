//
//  CWebViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/18.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CWebViewController.h"
#import <WebKit/WebKit.h>

@interface CWebViewController ()<UINavigationControllerDelegate,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView      *         wkWebView;

@end

@implementation CWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isCustomNav = YES;
    self.navView.lb_left.text = self.leftText;
    self.navView.lb_navTitle.text = self.navText;
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    
}

#pragma mark - delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[CWebViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - lazy

- (WKWebView *)wkWebView {
    return C_LAZY(_wkWebView, ({
        WKWebView *web = [[WKWebView alloc] initWithFrame:CGRectMake(0, Nav_Custom_Height, SCREEN_WIDTH, SCREEN_HEIGHT-Nav_Custom_Height)];
        web.UIDelegate = self;
        web.navigationDelegate = self;
        [self.view addSubview:web];
        web;
    }));
}


@end
