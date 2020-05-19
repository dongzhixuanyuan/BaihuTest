//
//  AppConfig.h
//  BaihuTest
//
//  Created by liudong on 2020/5/19.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigBeanModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppConfig : NSObject
+(instancetype)getInstance;
-(void)setConfigModel:(ConfigBeanModel*)model;
-(NSString*)getPhotoPrefix;
-(NSString*)getPhotoWholeUrl:(NSString*)key isThumb:(BOOL)thumb;
@end

NS_ASSUME_NONNULL_END
