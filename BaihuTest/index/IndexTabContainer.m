
//
//  IndexTabContainer.m
//  BaihuTest
//
//  Created by liudong on 2020/5/2.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "IndexTabContainer.h"
#import "DimenAdapter.h"
@implementation IndexTabContainer
- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect newFrame = CGRectMake(0, 0,SCREEN_WIDTH , NAVIGATIONBAR_HEIGHT);
        self.frame = newFrame;
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
