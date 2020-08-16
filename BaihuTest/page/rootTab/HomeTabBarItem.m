//
//  HomeTabBarItem.m
//  BaihuTest
//
//  Created by liudong on 2020/4/27.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "HomeTabBarItem.h"
#import <SDWebImageWebPCoder.h>
#import "DimenAdapter.h"
#import <Masonry.h>
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
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(UI(26));
            make.centerX.mas_equalTo(self);
        }];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(UI(6));
        }];
        
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:icon ofType:@"webp"];
    if (path == nil) {
        self.iconImageView.image = [UIImage imageNamed:icon];
    }else {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        UIImage *img = [UIImage sd_imageWithWebPData:data];
        self.iconImageView.image = img;
    }
    //    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    //    UIImage *img = [UIImage sd_imageWithWebPData:data];
    //    self.imageView.image = img;
    //    [SDImageWebPCoder sharedCoder] decodedImageWithData:<#(nullable NSData *)#> options:<#(nullable SDImageCoderOptions *)#>
    
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}


- (void)itemClicked:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarItem:didSelectIndex:)]) {
        [_delegate tabBarItem:self didSelectIndex:self.tag - defaultTag];
    }
}

@end
