//
//  WalletViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/13.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "WalletViewController.h"

@interface WalletViewController ()<UINavigationControllerDelegate>

@end

@implementation WalletViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isCustomNav = YES;
    self.navView.lb_left.text = @"我的";
    self.navView.lb_navTitle.text = @"我的钱包";
}


#pragma mark - delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[WalletViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}


@end
