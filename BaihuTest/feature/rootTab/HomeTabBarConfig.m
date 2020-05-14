//
//  HomeTabBarConfig.m
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "HomeTabBarConfig.h"

@implementation HomeTabBarConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isNavigation = YES;
        _normalColor = [UIColor grayColor];
        _selectedColor = [UIColor greenColor];
    }
    return self;
}

@end
