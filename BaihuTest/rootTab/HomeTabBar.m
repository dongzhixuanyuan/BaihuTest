//
//  HomeTabBar.m
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "HomeTabBar.h"
#import "HomeTabBarItem.h"
#import "DimenAdapter.h"
const CGFloat BOTTOM_TABS_HEIGHT = 70;
@interface HomeTabBar ()<HomeTabBarItemDelegate>

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIView *topLine;
@end

@implementation HomeTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, BOTTOM_TABS_HEIGHT);
    }
    return self;
}

- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = [UIColor grayColor];
        [self addSubview:_topLine];
    }
    return _topLine;
}

- (UIVisualEffectView *)effectView {
    if (_effectView == nil) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        _effectView.alpha = 1.0;
        [self addSubview:_effectView];
    }
    return _effectView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.effectView.frame = self.bounds;
    [self setupItems];
//    self.topLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.6);
}

- (void)setupItems {
    CGFloat padding =[DimenAdapter dimenAutoFit:10];
    CGFloat width = CGRectGetWidth(self.frame) / self.items.count;
    CGFloat height = CGRectGetHeight(self.frame ) - padding*2;

    for (int i = 0; i < self.items.count; i++) {
        HomeTabBarItem *item = [self.items objectAtIndex:i];
        item.frame = CGRectMake(i * width, padding , width, height);
        [self addSubview:item];
        item.delegate = self;
    }
    return;

    NSInteger count = _items.count;
    assert(count >= 2);

    for (int i = 0; i < count; i++) {
        HomeTabBarItem *item = [_items objectAtIndex:i];
        item.translatesAutoresizingMaskIntoConstraints = NO;
        if (i == 0) {
            [item.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
            [item.trailingAnchor constraintEqualToAnchor:_items[i + 1].leadingAnchor].active = YES;
        } else if (i == count - 1) {
            [item.leadingAnchor constraintEqualToAnchor:_items[i - 1].trailingAnchor].active = YES;
            [item.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        } else {
            [item.leadingAnchor constraintEqualToAnchor:_items[i - 1].trailingAnchor].active = YES;
            [item.trailingAnchor constraintEqualToAnchor:_items[i + 1].leadingAnchor].active = YES;
        }
    }
}

- (void)tabBar:(HomeTabBar *)tab didSelectItem:(nonnull HomeTabBarItem *)item atIndex:(NSInteger)index {
   
}



/// 这个是实现了HomeTabBarItemDelegate的点击回调的
/// 然后HomeTabBar内部又持有一个HomeTabBarDelegate，相当于两个代理做了一个沟通而已。
/// @param item 被点击的item
/// @param index
-(void)tabBarItem:(HomeTabBarItem*)item didSelectIndex:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItem:atIndex:)]) {
           [self.delegate tabBar:self didSelectItem:item atIndex:index];
       }
}


@end
