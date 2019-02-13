//
//  MySubscribeViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2019/1/11.
//  Copyright © 2019 zjq. All rights reserved.
//

#import "MySubscribeViewController.h"

@interface MySubscribeViewController ()

@end

@implementation MySubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isCustomNav = YES;
    self.navView.lb_navTitle.text = @"已购漫画";
    self.navView.lb_left.text = @"我的";
}


@end
