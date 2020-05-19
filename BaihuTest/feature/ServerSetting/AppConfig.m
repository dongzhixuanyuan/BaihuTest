//
//  AppConfig.m
//  BaihuTest
//
//  Created by liudong on 2020/5/19.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "AppConfig.h"

@interface AppConfig ()
@property (nonatomic, copy, readwrite) ConfigBeanModel *configModel;
@end

@implementation AppConfig

+ (instancetype)getInstance {
    static AppConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppConfig alloc]init];
    });
    return instance;
}

- (void)setConfigModel:(ConfigBeanModel *)model {
    _configModel = model;
}

- (NSString *)getPhotoPrefix {
    for (ConfigDataItem *item in _configModel.data) {
        if ([item.key isEqualToString:@"sys.img_url"]) {
            return item.value;
        }
    }
    return @"";
}

- (NSString *)getPhotoWholeUrl:(NSString *)key isThumb:(BOOL)thumb {
    if ([[self getPhotoPrefix] containsString:@"img.baihu.mobi"]) {
        if (thumb) {
            return [[[self getPhotoPrefix] stringByAppendingString:key]stringByAppendingString:@"_thumb.jpg"];
        }
        return [[[self getPhotoPrefix] stringByAppendingString:key]stringByAppendingString:@".jpg"];
    } else {
        return [[self getPhotoPrefix] stringByAppendingString:key];
    }
}

@end
