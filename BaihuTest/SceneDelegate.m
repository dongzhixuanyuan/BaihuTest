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
#import "NetworkManager.h"
#import "RecommendViewController.h"
#import "UrlConstants.h"
#import "Test.h"
#import "Beauty-Swift.h"
#import "HistoryViewControllerOC.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.window = [[UIWindow alloc]initWithWindowScene:(UIWindowScene *)scene];
    
    HomeTabBarController* customTabController =  [HomeTabBarController createTabBarController:^HomeTabBarConfig *(HomeTabBarConfig * _Nonnull config) {
        IndexViewController* indexVC = [[IndexViewController alloc]init];
        
        RecommendViewController* recommendVC = [[RecommendViewController alloc]init];
        
        
        HistoryViewControllerOC* vc3 = [[HistoryViewControllerOC alloc]init];
        
        
        //        UIViewController* vc4 = [[UIViewController alloc]init];
        //        vc4.view.backgroundColor = [UIColor greenColor];
        
        config.viewController = @[indexVC,recommendVC,vc3];
        config.title = @[@"首页", @"发现",@"收藏"];
        config.normalImage = @[@"index",@"found",@"favourite_unselected"];
        config.seletedImages = @[@"index_selected",@"found_selected",@"favourite_selected"];
        config.isNavigation = NO;
        config.selectedColor = [UIColor colorWithHexString:@"#FFFF6B9C"];
        return config;
    }];
    //    不使用系统的导航栏，所以不能用navigationviewcontroller
    UINavigationController *rootViewController = [[UINavigationController alloc]initWithRootViewController:customTabController];
    rootViewController.view.backgroundColor = [UIColor whiteColor];
    rootViewController.navigationBarHidden = YES;
    self.window.rootViewController = rootViewController;
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
