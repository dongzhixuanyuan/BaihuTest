//
//  SceneDelegate.m
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "SceneDelegate.h"
#import "HomeTabBarController.h"
#import "IndexViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.window = [[UIWindow alloc]initWithWindowScene:(UIWindowScene *)scene];
    UITabBarController *tabController = [[UITabBarController alloc]init];
    for (int i = 0; i < 4; i++) {
        UIViewController *vc = [[UIViewController alloc]init];
        switch (i) {
            case 0:
                vc = [[IndexViewController alloc]init];
                vc.view.backgroundColor = [UIColor redColor];
                vc.tabBarItem.title = @"微信";
                vc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_mainframe"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_mainframeHL"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                vc.tabBarItem.badgeValue = @"100";
                vc.tabBarItem.badgeColor = [UIColor greenColor];
                break;
            case 1:
                vc.view.backgroundColor = [UIColor orangeColor];
                vc.tabBarItem.title = @"联系人";
                vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_contactsHL" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                vc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_contacts"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            case 2:
                vc.view.backgroundColor = [UIColor yellowColor];
                vc.tabBarItem.title = @"发现";
                vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discoverHL" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                vc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_discover"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            case 3:
                vc.view.backgroundColor = [UIColor greenColor];
                vc.tabBarItem.title = @"我";
                vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_meHL" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                vc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                break;
            default:
                break;
        }
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
             [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
        [tabController addChildViewController:vc];
    }
   HomeTabBarController* customTabController =  [HomeTabBarController createTabBarController:^HomeTabBarConfig *(HomeTabBarConfig * _Nonnull config) {
        IndexViewController* vc1 = [[IndexViewController alloc]init];
        
        UIViewController* vc2 = [[UIViewController alloc]init];
        vc2.view.backgroundColor = [UIColor orangeColor];
        
        UIViewController* vc3 = [[UIViewController alloc]init];
        vc3.view.backgroundColor = [UIColor yellowColor];
        
        UIViewController* vc4 = [[UIViewController alloc]init];
        vc4.view.backgroundColor = [UIColor greenColor];
        
        config.viewController = @[vc1,vc2,vc3,vc4];
        config.title = @[@"微信", @"联系人",@"发现",@"我"];
        config.normalImage = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
        config.seletedImages = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
        config.isNavigation = NO;
        return config;
    }];
//    不使用系统的导航栏，所以不能用navigationviewcontroller
//    UINavigationController *rootViewController = [[UINavigationController alloc]initWithRootViewController:customTabController];
//    rootViewController.view.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = customTabController;
    [self.window makeKeyAndVisible];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

@end
