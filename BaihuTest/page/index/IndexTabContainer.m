
//
//  IndexTabContainer.m
//  BaihuTest
//
//  Created by liudong on 2020/5/2.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "IndexTabContainer.h"
#import "DimenAdapter.h"
#import <Masonry.h>
#import "NetworkManager.h"
#import "UrlConstants.h"
#import <YYModel.h>
#import "CategoryModel.h"
#import "UIColor+Addition.h"
#import <Masonry.h>

@interface IndexTabContainer ()
@property (nonatomic, strong, readwrite) NSMutableArray<UILabel *> *topTabs;
@property (nonatomic, strong, readwrite) UIImageView *rankIcon;
@property (nonatomic, strong, readwrite) UIImageView *signIcon;
@end

@implementation IndexTabContainer
- (instancetype)init
{
    self = [super init];
    _topTabs = [NSMutableArray arrayWithCapacity:4];
    if (self) {
        CGRect newFrame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        self.frame = newFrame;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray<UIView *> *children =  [self subviews];
    for (UIView *child in children) {
        NSLog(@"child: %d", child.hash);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *selectedView = ((UITouch *)[touches anyObject]).view;
    for (UIView *child in [self subviews]) {
        if (child == selectedView) {
            if (_tabClickDelegate && [_tabClickDelegate respondsToSelector:@selector(onTabClick:)]) {
                [_tabClickDelegate onTabClick:child.tag];
            }
        }
    }
}

- (void)setTabData:(NSArray<NSString *> *)tabData {
    _tabData = tabData;
    if (_topTabs != nil) {
        [_topTabs removeAllObjects];
    } else {
        _topTabs = [NSMutableArray arrayWithCapacity:tabData.count];
    }
    NSInteger currentX = UI(15);
    //    [DimenAdapter dimenAutoFit:UI(50)] * i + UI(15)
    for (NSInteger i = 0; i < tabData.count; i++) {
        NSString *text = tabData[i];
        NSInteger tabWidth = [DimenAdapter dimenAutoFit:UI(20 * (text.length / 2) * 2)];
        UILabel *tab = [[UILabel alloc]initWithFrame:CGRectMake(currentX, 0, tabWidth, NAVIGATIONBAR_HEIGHT - 1)];
        tab.userInteractionEnabled = YES;
        tab.textAlignment = NSTextAlignmentCenter;
        tab.backgroundColor = [UIColor whiteColor];
        tab.textColor = [UIColor colorWithHexString:@"#777777"];
        tab.font = [UIFont systemFontOfSize:14];
        tab.tag = i;
        tab.text = tabData[i];
        //        [tab sizeToFit];
        if (i == 0) {
            tab.textColor = [UIColor colorWithHexString:@"#222222"];
            tab.transform = CGAffineTransformScale(tab.transform, 1.4, 1.4);
        }
        [_topTabs addObject:tab];
        [self addSubview:tab];
        currentX = currentX + tabWidth + UI(10);
    }
    [self drawBottomDivider];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentSelectedPage"]) {
        NSInteger newPage =
            [(NSNumber *)[change objectForKey:NSKeyValueChangeNewKey] intValue];
        NSInteger oldPage = [(NSNumber *)[change objectForKey:NSKeyValueChangeOldKey] intValue];
        [self updateSelectIndex:newPage oldselect:oldPage];
    }
}

- (void)updateSelectIndex:(NSInteger)selectIndex oldselect:(NSInteger)oldSelected {
    if (selectIndex < 0 ||  selectIndex >= _topTabs.count) {
        NSLog(@"异常");
        return;
    }
    __weak typeof(self) wself = self;
    for (NSInteger i = 0; i < _topTabs.count; i++) {
        __strong typeof(wself) sself = wself;
        if (selectIndex == i) {
            //放大动画
            UILabel *label =  sself.topTabs[i];
            label.textColor = [UIColor colorWithHexString:@"#222222"];

            [UIView animateWithDuration:0.2
                             animations:^{
                                 label.transform = CGAffineTransformScale(label.transform, 1.4, 1.4);
                             }];
        } else if (oldSelected == i) {
            //缩小动画
            UILabel *label =  sself.topTabs[i];
            //            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"#777777"];

            [UIView animateWithDuration:0.2
                             animations:^{
                                 UILabel *label =  sself.topTabs[i];
                                 label.transform = CGAffineTransformIdentity;
                             }];
        }
    }
}

- (void)drawBottomDivider {
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(0, NAVIGATIONBAR_HEIGHT)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(self.frame.size.width, NAVIGATIONBAR_HEIGHT)];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor colorWithHexString:@"#E1E1E1"].CGColor;
    lineLayer.path = linePath.CGPath;
    [self.layer addSublayer:lineLayer];
}

@end
