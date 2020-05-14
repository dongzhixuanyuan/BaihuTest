//
//  PhotoListItemView.m
//  BaihuTest
//
//  Created by liudong on 2020/5/14.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "PhotoListItemView.h"
#import <Masonry.h>
#import "DimenAdapter.h"

@interface PhotoListItemView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong, readwrite) UIImageView *first;
@property (nonatomic, strong, readwrite) UIImageView *second;
@property (nonatomic, strong, readwrite) UIImageView *third;
@property (nonatomic, strong, readwrite) UIImageView *avart;
@property (nonatomic, strong, readwrite) UILabel *modelDes;
@property (nonatomic, strong, readwrite) UIImageView *favouriteBtn;
@end

@implementation PhotoListItemView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _first = [[UIImageView alloc]init];
        _first.backgroundColor = [UIColor blackColor];
        _second = [[UIImageView alloc]init];
        _second.backgroundColor = [UIColor blueColor];
        _third = [[UIImageView alloc]init];
        _third.backgroundColor = [UIColor redColor];
        _avart = [[UIImageView alloc]init];
        _avart.backgroundColor = [UIColor orangeColor];
        _avart.layer.cornerRadius = UI(25);
        _favouriteBtn = [[UIImageView alloc]init];
        _favouriteBtn.backgroundColor = [UIColor systemPinkColor];
        _modelDes = [[UILabel alloc]init];
        [self.contentView addSubview:_first];
        [self.contentView addSubview:_second];
        [self.contentView addSubview:_third];
        [self.contentView addSubview:_avart];
        [self.contentView addSubview:_favouriteBtn];
        [self.contentView addSubview:_modelDes];
        _modelDes.text = @"离屏渲染的地方也就不用离屏渲染了,\n 通过设置view.layer的mask属性";
        _modelDes.textAlignment = NSTextAlignmentLeft | NSTextAlignmentCenter;
        [_first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20.0);
            make.top.equalTo(self.contentView.mas_top).offset(20.0);
            make.width.mas_equalTo(UI(100));
            make.height.mas_equalTo(UI(100));
        
        }];
        [_second mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_first.mas_right).offset(20);
            make.width.mas_equalTo(UI(100));
            make.top.mas_equalTo(_first.mas_top);
            make.bottom.mas_equalTo(_first.mas_bottom);
        }];
        [_third mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_second.mas_right).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-20.0);
            make.top.and.bottom.equalTo(_first);
        }];
        [_avart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_first.mas_bottom).offset(10);
            make.left.equalTo(_first.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
            make.width.and.height.mas_equalTo(UI(50));
        }];
        [_favouriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_third);
            make.size.mas_equalTo(40);
            make.centerY.mas_equalTo(_avart);
        }];
        [_modelDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_avart.mas_centerY);
            make.left.mas_equalTo(_avart.mas_right).offset(10);
            make.right.lessThanOrEqualTo(_favouriteBtn.mas_left);
        }];
        
        
    }
    return self;
}

@end
