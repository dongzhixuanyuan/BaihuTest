//
//  UrlConstants.m
//  BaihuTest
//
//  Created by liudong on 2020/5/11.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "UrlConstants.h"

NSString *const baseUrl = @"http://129.211.27.144:8080";
NSString *const tokenUrl = @"/mobile/auth/initialize";
NSString* const categoryPath =  @"/mobile/category";
@implementation UrlConstants
+ (NSString *)getInitAccountUrl {
    return [baseUrl stringByAppendingString:tokenUrl];
}
+ (NSString *)getCategoryUrl {
    return  [baseUrl stringByAppendingString:categoryPath];
}

@end
