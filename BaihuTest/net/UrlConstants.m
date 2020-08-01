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
NSString *const categoryPath =  @"/mobile/category";
NSString *const indexAllPath = @"/mobile/album/all";
NSString *const indexRecommandPath = @"/mobile/album/recommend";
NSString *const indexCategoryPath = @"/mobile/album/all_by_category?";
NSString *const configPath = @"/mobile/config";
NSString *const modelRecommendPath = @"/mobile/model/recommends?";
NSString *const tagRecommendPath = @"/mobile/tag/recommends?";
NSString *const allModelPath = @"/mobile/model";
NSString *const allTagPath = @"/mobile/tag";
NSString *const albumPath =  @"/mobile/album/";
NSString *const albumCountForModel = @"/mobile/album/count_by_model";
NSString *const albumCountForTag = @"/mobile/album/count_by_tag";
NSString *const albumsForModel = @"/mobile/album/all_by_model?";
NSString *const albumsForTAG = @"/mobile/album/all_by_tag?";

@implementation UrlConstants
+ (NSString *)getInitAccountUrl {
    return [baseUrl stringByAppendingString:tokenUrl];
}

+ (NSString *)getCategoryUrl {
    return [baseUrl stringByAppendingString:categoryPath];
}

+ (NSString *)getIndexAllUrl {
    return [baseUrl stringByAppendingString:indexAllPath];
}

+ (NSString *)getConfigUrl {
    return [baseUrl stringByAppendingString:configPath];
}

+ (NSString *)getRecomandUrl {
    return [baseUrl stringByAppendingString:indexRecommandPath];
}

+ (NSString *)getSpeCategoryUrl:(NSString *)categoryId {
    NSString *path = [[indexCategoryPath stringByAppendingString:@"category_id="]stringByAppendingString:categoryId];
    return [baseUrl stringByAppendingString:path];
}

+ (NSString *)getRecommendModels:(NSInteger)count {
    NSString *path = [modelRecommendPath stringByAppendingFormat:@"quantity=%ld", count];
    return [baseUrl stringByAppendingString:path];
}

+ (NSString *)getRecommendTags:(NSInteger)count {
    NSString *path = [tagRecommendPath stringByAppendingFormat:@"quantity=%ld", count];
    return [baseUrl stringByAppendingString:path];
}

+ (NSString *)getAllModels {
    return [baseUrl stringByAppendingString:allModelPath];
}

+ (NSString *)getAllTags {
    return [baseUrl stringByAppendingString:allTagPath];
}

+ (NSString *)getAllAlbumsById:(NSString *)albumId {
    return [baseUrl stringByAppendingString:[albumPath stringByAppendingString:albumId]];
}

+ (NSString *)getAlbumCountForModel {
    return [baseUrl stringByAppendingString:albumCountForModel];
}

+ (NSString *)getAlbumCountForTag {
    return [baseUrl stringByAppendingString:albumCountForTag];
}

+ (NSString *)getAlbumsForModel:(NSString *)modelId page:(NSInteger)page size:(NSInteger)pageSize {
    NSDictionary<NSString *, NSString *> *dictParams =  [NSDictionary dictionaryWithObjectsAndKeys:modelId, @"model_id",
                                                         [NSString stringWithFormat:@"%ld", (long)page], @"page",
                                                         [NSString stringWithFormat:@"%ld", (long)pageSize], @"size",  nil];
    NSString *subfix =  [UrlConstants joinUrlParams:dictParams];
    NSString *prefix =  [baseUrl stringByAppendingString:albumsForModel];
    return [prefix stringByAppendingFormat:@"%@", subfix];
}

+ (NSString *)getAlbumsForTag:(NSString *)tagId page:(NSInteger)page size:(NSInteger)pageSize {
    NSDictionary<NSString *, NSString *> *dictParams =  [NSDictionary dictionaryWithObjectsAndKeys:tagId, @"tag_id", [NSString stringWithFormat:@"%ld", (long)page],  @"page", [NSString stringWithFormat:@"%ld", (long)pageSize],   @"size",  nil];
    NSString *subfix =  [UrlConstants joinUrlParams:dictParams];
    
    return [ [ baseUrl stringByAppendingString:albumsForTAG] stringByAppendingFormat:@"%@", subfix];
}

+ (NSString *)joinUrlParams:(NSDictionary<NSString *, NSString *> *)params {
    NSString *subfix = @"";
    NSArray<NSString *> *keys =  params.allKeys;
    for (NSInteger i = 0; i < keys.count; i++) {
        if (i != 0) {
            subfix = [subfix stringByAppendingFormat:@"&"];
        }
        subfix =  [subfix stringByAppendingFormat:@"%@=%@", keys[i], [params objectForKey:keys[i]]  ];
    }
    return subfix;
}

@end
