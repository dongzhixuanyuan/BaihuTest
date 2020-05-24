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
#import <SDWebImage.h>
#import "AppConfig.h"
@interface PhotoListItemView ()
@property (nonatomic, strong, readwrite) UIImageView *first;
@property (nonatomic, strong, readwrite) UIImageView *second;
@property (nonatomic, strong, readwrite) UIImageView *third;
@property (nonatomic, strong, readwrite) UIImageView *avart;
@property (nonatomic, strong, readwrite) UILabel *photoDes;
@property (nonatomic, strong, readwrite) UILabel *modelName;
@property (nonatomic, strong, readwrite) UIImageView *favouriteBtn;
@property (nonatomic,copy,readwrite)PhotoItemDataItem* item;
@end

@implementation PhotoListItemView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
        _photoDes = [[UILabel alloc]init];
        _modelName = [[UILabel alloc]init];
        _modelName.text = @"测试名字";
        [self.contentView addSubview:_first];
        [self.contentView addSubview:_second];
        [self.contentView addSubview:_third];
        [self.contentView addSubview:_avart];
        [self.contentView addSubview:_favouriteBtn];
        [self.contentView addSubview:_photoDes];
        [self.contentView addSubview:_modelName];
        _photoDes.text = @"离屏渲染的地方也就不用离屏渲染了,\n 通过设置view.layer的mask属性";
        _photoDes.textAlignment = NSTextAlignmentLeft ;
        _modelName.textAlignment = NSTextAlignmentLeft;
        
        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoPhotoDetailPage:)];
        [_first addGestureRecognizer:recognizer];
        [_second addGestureRecognizer:recognizer];
        [_third addGestureRecognizer:recognizer];
        _first.tag = 1;
        _second.tag = 2;
        _third.tag = 3;
        
        
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
        
        [_modelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.lessThanOrEqualTo(_avart.mas_top).offset(5);
            make.left.mas_equalTo(_avart.mas_right).offset(10);
            make.right.lessThanOrEqualTo(_favouriteBtn.mas_left);
        }];
        
        [_photoDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_modelName.mas_left);
            make.right.lessThanOrEqualTo(_favouriteBtn.mas_left);
            make.bottom.mas_lessThanOrEqualTo(_avart.mas_bottom).offset(-5);
        }];
        
    }
    return self;
}

-(void) fillData:(PhotoItemDataItem*)bean{
    
    NSString* cover1UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.info.cover_key1 isThumb:false] ;
    
    NSString* cover2UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.info.cover_key2 isThumb:false] ;
    
    NSString* cover3UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.info.cover_key3 isThumb:false] ;
    
    [_first sd_setImageWithURL:[ NSURL URLWithString: cover1UrlStr]];
    [_second sd_setImageWithURL:[ NSURL URLWithString: cover2UrlStr]];
    [_third sd_setImageWithURL:[ NSURL URLWithString: cover3UrlStr]];
    if(bean.info.model != nil){
        _modelName.text = bean.info.model.name;
        NSString* avatar = [[AppConfig getInstance]getPhotoWholeUrl:bean.info.model.avatar_image_url isThumb:YES];
        [_avart sd_setImageWithURL: [NSURL URLWithString:avatar]];
        
    } else {
        _modelName.text = @"素人";
        [_avart sd_setImageWithURL:[ NSURL URLWithString: cover1UrlStr]];
    }
    _photoDes.text = bean.info.name;
    
}

-(void)gotoPhotoDetailPage:(UITapGestureRecognizer*)sender {
    //todo 点击跳转
    NSInteger tag =  sender.view.tag;
    //    if (tag == 1) {
    //        itemClickListener()
    //    }
    if (_clickCallback) {
        _clickCallback(_item);
    }
}

@end
