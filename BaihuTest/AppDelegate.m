//
//  AppDelegate.m
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import "UrlConstants.h"
#import "InitAccountResponseModel.h"
#import "Constants.h"
#import "NetworkManager.h"
#import "ConfigBeanModel.h"
#import "AppConfig.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self getAccessToken];
    [self getConfigBean];
    return YES;
}

#pragma mark - 获取服务器初始化相关设置
-(void)getAccessToken{
    id token =  [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ACCESS_TOKEN];
    if (token == nil) {
        //需要获取
        NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configuration];
        [manager POST:[UrlConstants getInitAccountUrl] parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            AccessTokenResponse* model = [AccessTokenResponse yy_modelWithDictionary:responseObject];
            [[NSUserDefaults standardUserDefaults] setObject:model.data forKey:KEY_ACCESS_TOKEN];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
    }
}


-(void)getConfigBean {
    [[NetworkManager getHttpSessionManager] GET:[UrlConstants getConfigUrl] parameters:nil headers:[NetworkManager getCommonHeaders] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ConfigBeanModel* model = [ConfigBeanModel yy_modelWithDictionary:responseObject];
        [[AppConfig getInstance]setConfigModel:model];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"getConfigUrl error %d",(long)error.code);
    }];
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
