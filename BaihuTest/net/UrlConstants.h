//
//  UrlConstants.h
//  BaihuTest
//
//  Created by liudong on 2020/5/11.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString* const baseUrl;
FOUNDATION_EXPORT NSString* const tokenUrl;
FOUNDATION_EXPORT NSString* const categoryPath;
@interface UrlConstants : NSObject
+(NSString*)getInitAccountUrl;
+(NSString*)getCategoryUrl;
+(NSString*)getIndexAllUrl;
+(NSString*)getConfigUrl;
+(NSString*)getRecomandUrl;
+(NSString*)getSpeCategoryUrl:(NSString*)categoryId;
+(NSString*)getRecommendModels:(NSInteger)count;
+(NSString*)getRecommendTags:(NSInteger)count;
+(NSString*)getAllModels;
+(NSString*)getAllTags;
+(NSString*)getAllAlbumsById:(NSString*)albumId;
+(NSString*)getAlbumCountForModel;
+(NSString*)getAlbumCountForTag;
+(NSString*)getAlbumsForModel;
+(NSString*)getAlbumsForTag;


+(NSString*)joinUrlParams:(NSDictionary<NSString*,NSString*>*)params;
@end

NS_ASSUME_NONNULL_END
