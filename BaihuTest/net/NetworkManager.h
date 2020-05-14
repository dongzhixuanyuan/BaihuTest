//
//  NetworkManager.h
//  BaihuTest
//
//  Created by liudong on 2020/5/11.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject
+(instancetype) getInstance;
+(NSString*) buildAccountUrl;
+(void)urlTest;
+(AFHTTPSessionManager*)getHttpSessionManager;
@end






NS_ASSUME_NONNULL_END
