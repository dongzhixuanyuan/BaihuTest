//
//  ModelPage.m
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "ModelPage.h"
#import "UrlConstants.h"
@implementation ModelPage


- (NSString *)loadUrl {
    return [UrlConstants getAllModels];
}
@end
