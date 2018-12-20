//
//  LibraryViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "LibraryViewController.h"

@interface LibraryViewController ()<UINavigationControllerDelegate>

@end

@implementation LibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.delegate = self;
    
    UIImageView *img = [UIImageView new];
    img.image = [UIImage imageNamed:@"bookshelf_notlogin_414x736_"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[LibraryViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}

@end
