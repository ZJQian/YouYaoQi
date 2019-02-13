//
//  CBaseViewController.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/27.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CBaseViewController.h"

@interface CBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation CBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}

- (void)setIsCustomNav:(BOOL)isCustomNav {
    _isCustomNav = isCustomNav;
    
    if (isCustomNav) {
        NavBarView *nav = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Nav_Custom_Height)];
        [self.view addSubview:nav];
        self.navView = nav;
        [self.navView.btn_left addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)leftAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[CBaseViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}

@end
