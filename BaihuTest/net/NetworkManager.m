//
//  NetworkManager.m
//  BaihuTest
//
//  Created by liudong on 2020/5/11.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking.h>
#import "Test.h"
#import "InitAccountResponseModel.h"
#import <YYModel.h>
#import "UrlConstants.h"
#import "CategoryModel.h"
#import "Constants.h"
#import "PhotoItemResponseModel.h"

@interface NetworkManager()

@end

@implementation NetworkManager

+ (instancetype)getInstance {
    static NetworkManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkManager alloc]init];
    });
    return instance;
}

//-(void)fetchDataWithGet:(NSString*)url params:(NSDictionary*)queryMap,


+ (AFHTTPSessionManager *)getHttpSessionManager{
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configuration];
    return manager;
}


+ (NSDictionary *)getCommonHeaders {
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ACCESS_TOKEN];
    if(accessToken == nil){
        accessToken = @"";
    }
    NSDictionary* headers =[ [NSDictionary alloc]initWithObjectsAndKeys:accessToken,@"X-AUTH-TOKEN", nil];
    return headers;
}

+ (void)urlTest {
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configuration];
    [manager GET:[UrlConstants getAlbumCountForModel] parameters:@{@"model_id":@"444c5b54-2aac-42b7-a99f-de684111bac3"} headers:[NetworkManager getCommonHeaders] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* result =  [Test dictionary2String:responseObject ];
        NSLog(@"%@",result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
}

@end
