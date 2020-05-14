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

+ (void)urlTest {
   NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
   AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:configuration];
   [manager GET:[UrlConstants getCategoryUrl] parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSString* result =  [Test dictionary2String:responseObject ];
       NSLog(@"%@",result);
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"error:%@",error);
   }];
    
}




@end
