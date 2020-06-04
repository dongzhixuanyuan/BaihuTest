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
NSString* const indexRecommandPath = @"/mobile/album/recommend";
NSString* const indexCategoryPath = @"/mobile/album/all_by_category?";
NSString* const configPath  = @"/mobile/config";
NSString* const modelRecommendPath = @"/mobile/model/recommends?";

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
+(NSString*)getRecomandUrl {
    return [baseUrl stringByAppendingString:indexRecommandPath];
}
+(NSString*)getSpeCategoryUrl:(NSString*)categoryId {
    NSString* path = [[indexCategoryPath stringByAppendingString:@"category_id="]stringByAppendingString:categoryId];
    return [baseUrl stringByAppendingString:path];
}
+ (NSString *)getRecommendModels:(NSInteger)count {
    NSString* path = [modelRecommendPath stringByAppendingFormat:@"quantity=%d",count];
    return [baseUrl stringByAppendingString:path];
}

@end
