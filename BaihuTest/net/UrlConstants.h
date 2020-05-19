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
@end

NS_ASSUME_NONNULL_END
