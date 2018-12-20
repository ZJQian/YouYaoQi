//
//  CBaseNavigationController.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/27.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CBaseNavigationController.h"
#import "CBaseViewController.h"

@interface CBaseNavigationController ()

@end

@implementation CBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self.viewControllers count] > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
