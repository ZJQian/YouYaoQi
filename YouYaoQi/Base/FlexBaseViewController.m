//
//  FlexBaseViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2019/2/12.
//  Copyright © 2019 zjq. All rights reserved.
//

#import "FlexBaseViewController.h"

@interface FlexBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation FlexBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShow = [viewController isKindOfClass:[FlexBaseViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}


@end
