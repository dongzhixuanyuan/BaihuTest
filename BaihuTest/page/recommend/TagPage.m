//
//  TagPage.m
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//


#import "TagPage.h"
#import "UrlConstants.h"
@implementation TagPage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSString *)loadUrl {
    return [UrlConstants getAllTags];
}

@end
