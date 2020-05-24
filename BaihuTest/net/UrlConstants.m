//
//  UrlConstants.m
//  BaihuTest
//
//  Created by liudong on 2020/5/11.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "UrlConstants.h"

NSString *const baseUrl = @"http://129.211.27.144:8081";
NSString *const tokenUrl = @"/mobile/auth/initialize";
NSString* const categoryPath =  @"/mobile/category";
NSString* const indexAllPath = @"/mobile/album/all";
NSString* const configPath  = @"/mobile/config";
@implementation UrlConstants
+ (NSString *)getInitAccountUrl {
    return [baseUrl stringByAppendingString:tokenUrl];
}
+ (NSString *)getCategoryUrl {
    return  [baseUrl stringByAppendingString:categoryPath];
}
+ (NSString *)getIndexAllUrl{
    return [baseUrl stringByAppendingString:indexAllPath]    ;
}
+ (NSString *)getConfigUrl {
    return [baseUrl stringByAppendingString:configPath];
}
@end
