//
//  HomeTabBarItem.m
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "HomeTabBarItem.h"
static NSInteger defaultTag = 10000;
@interface HomeTabBarItem ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HomeTabBarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClicked:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)setTag:(NSInteger)tag {
    [super setTag:tag + defaultTag];
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconImageView.image = [UIImage imageNamed:icon];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_iconImageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [_iconImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_titleLabel.topAnchor constraintEqualToAnchor:self.iconImageView.bottomAnchor constant:6.0].active = YES;
    [_titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
}

- (void)itemClicked:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarItem:didSelectIndex:)]) {
        [_delegate tabBarItem:self didSelectIndex:self.tag - defaultTag];
    }
}

@end
