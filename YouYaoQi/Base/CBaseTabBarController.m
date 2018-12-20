//
//  CBaseTabBarController.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/27.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CBaseTabBarController.h"
#import "CBaseNavigationController.h"
#import "CBaseViewController.h"
#import "UpdateViewController.h"
#import "DiscoverViewController.h"
#import "LibraryViewController.h"
#import "MineViewController.h"
#import "UIImage+YExt.h"


@interface CBaseTabBarController ()

@end

@implementation CBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setControllers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skinNoti:) name:kNotificationChangeSkin object:nil];
}

- (void)skinNoti:(NSNotification *)noti {
    
    NSDictionary *obj = noti.object;
    if (obj == nil) {
        
        
        NSArray *imgArray = @[@"tab_today_103x54_",
                              @"tab_find_103x54_",
                              @"tab_book_103x54_",
                              @"tab_mine_103x54_"];
        NSArray *selectImgArray = @[@"tab_today_selected_103x54_",
                                    @"tab_find_selected_103x54_",
                                    @"tab_book_selected_103x54_",
                                    @"tab_mine_selected_103x54_"];
        for (int i = 0; i < self.tabBar.items.count; i ++) {
            UITabBarItem * barItem = self.tabBar.items[i];
            UIImage *img = [UIImage imageNamed:imgArray[i]];
            UIImage *img_select = [UIImage imageNamed:selectImgArray[i]];
            
            barItem.title = nil;
            barItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
            barItem.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            barItem.selectedImage = [img_select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        self.tabBar.backgroundImage = nil;
        [self.tabBar setShadowImage:nil];
        self.tabBar.backgroundColor = [UIColor whiteColor];
        
        
    }else{
        NSString *path = obj[@"path"];
        NSDictionary *dic = obj[@"packageDic"];
        [self setSkin:path packageDic:dic];
    }
}

- (void)setSkin:(NSString *)path packageDic:(NSDictionary *)dic {
    
    NSData *data0 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Today"][@"tabImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img0 = [[UIImage imageWithData:data0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSData *data_select0 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Today"][@"tabSelectImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img_select0 = [[UIImage imageWithData:data_select0] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSData *data1 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"tabImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img1 = [[UIImage imageWithData:data1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSData *data_select1 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"tabSelectImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img_select1 = [[UIImage imageWithData:data_select1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSData *data2 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Bookshelf"][@"tabImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img2 = [[UIImage imageWithData:data2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSData *data_select2 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Bookshelf"][@"tabSelectImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img_select2 = [[UIImage imageWithData:data_select2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSData *data3 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Mine"][@"tabImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img3 = [[UIImage imageWithData:data3] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSData *data_select3 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Mine"][@"tabSelectImage"] stringByAppendingString:@"@3x.png"]]];
    UIImage *img_select3 = [[UIImage imageWithData:data_select3] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSArray *imageArray = @[img0,img1,img2,img3];
    NSArray *selectedImageArray = @[img_select0,img_select1,img_select2,img_select3];
    for (int i = 0; i < self.tabBar.items.count; i ++) {
        UITabBarItem * barItem = self.tabBar.items[i];
        UIImage *img = imageArray[i];
        UIImage *img_select = selectedImageArray[i];
        CGFloat w = (SCREEN_WIDTH)/self.tabBar.items.count+1;
        CGFloat h = img.size.height/img.size.width*w;
        CGFloat h_select = img_select.size.height/img_select.size.width*w;
        barItem.title = nil;
        barItem.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
        barItem.image = [[UIImage originImage:img scaleToSize:CGSizeMake(w, h)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        barItem.selectedImage = [[UIImage originImage:img_select scaleToSize:CGSizeMake(w, h_select)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    //    NSData *data_bg = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Global"][@"tabBarbottomBgImageX"] stringByAppendingString:@"@3x.png"]]];
    //    UIImage *img_bg = [[UIImage imageWithData:data_bg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    UIImage *jjj = [[UIImage originImage:img_bg scaleToSize:CGSizeMake(SCREEN_WIDTH, img_bg.size.height/img_bg.size.width*SCREEN_WIDTH)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.backgroundImage = [UIImage new];
    [self.tabBar setShadowImage:[UIImage new]];
    self.tabBar.backgroundColor = [UIColor clearColor];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setControllers {
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    NSMutableArray *navArray = [NSMutableArray array];
    NSArray *array = @[[UpdateViewController new],
                       [DiscoverViewController new],
                       [LibraryViewController new],
                       [MineViewController new]];
    
    if ([DefaultsUtil getSkin] == nil) {
        
        NSArray *imgArray = @[@"tab_today_103x54_",
                              @"tab_find_103x54_",
                              @"tab_book_103x54_",
                              @"tab_mine_103x54_"];
        NSArray *selectImgArray = @[@"tab_today_selected_103x54_",
                                    @"tab_find_selected_103x54_",
                                    @"tab_book_selected_103x54_",
                                    @"tab_mine_selected_103x54_"];
        for (int i = 0; i<array.count; i++) {
            
            CBaseViewController *vc = array[i];
            CBaseNavigationController *nav = [[CBaseNavigationController alloc] initWithRootViewController:vc];
            nav.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
            nav.tabBarItem.image = [[UIImage imageNamed:imgArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImgArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.tabBar.backgroundColor = [UIColor whiteColor];
            [navArray addObject:nav];
        }
        
    }else{
        
        NSString *path = [GlobalUtil getSkinFolderPath];
        NSDictionary *dic = [GlobalUtil getSkinConfigFile];
        
        for (int i = 0; i<array.count; i++) {
            
            CBaseViewController *vc = array[i];
            CBaseNavigationController *nav = [[CBaseNavigationController alloc] initWithRootViewController:vc];
            [navArray addObject:nav];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setSkin:path packageDic:dic];

        });
    }
    
    
    
    self.viewControllers = navArray;
    self.selectedIndex = 1;
}


@end
