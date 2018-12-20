//
//  CBaseViewController.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/27.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CBaseViewController.h"

@interface CBaseViewController ()

@end

@implementation CBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}

- (void)setIsCustomNav:(BOOL)isCustomNav {
    _isCustomNav = isCustomNav;
    
    if (isCustomNav) {
        NavBarView *nav = [[NavBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IS_IPHONEX ? 84.0 : 60.0)];
        [self.view addSubview:nav];
        self.navView = nav;
        [self.navView.btn_left addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)leftAction {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
