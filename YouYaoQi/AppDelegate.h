//
//  AppDelegate.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

