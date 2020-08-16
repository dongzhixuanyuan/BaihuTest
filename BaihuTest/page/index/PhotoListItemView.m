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
#import "UIColor+Addition.h"
#import "BaihuTest-Swift.h"

@interface PhotoListItemView ()
@property (nonatomic, strong, readwrite) UIImageView *first;
@property (nonatomic, strong, readwrite) UIImageView *second;
@property (nonatomic, strong, readwrite) UIImageView *third;
@property (nonatomic, strong, readwrite) UIImageView *avart;
@property (nonatomic, strong, readwrite) UILabel *photoDes;
@property (nonatomic, strong, readwrite) UILabel *modelName;
@property (nonatomic, strong, readwrite) UIButton *favouriteBtn;
@property (nonatomic, strong, readwrite) PhotoItemDataItem *item;
@property (nonatomic,strong,readwrite)FavouriteDataItem* favouriteItem;
@end

@implementation PhotoListItemView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _first = [[UIImageView alloc]init];
        _first.backgroundColor = [UIColor grayColor];
        _first.layer.cornerRadius = 6;
        _first.layer.masksToBounds = YES;
        _second = [[UIImageView alloc]init];
        _second.backgroundColor = [UIColor grayColor];
        _second.layer.cornerRadius = 6;
        _second.layer.masksToBounds = YES;
        _third = [[UIImageView alloc]init];
        _third.backgroundColor = [UIColor grayColor];
        _third.layer.cornerRadius = 6;
        _third.layer.masksToBounds = YES;
        _avart = [[UIImageView alloc]init];
        _favouriteBtn = [[UIButton alloc]init];
        
        [_favouriteBtn setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
        
        [_favouriteBtn addTarget:self action:@selector(favouriteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _photoDes = [[UILabel alloc]init];
        _modelName = [[UILabel alloc]init];
        _modelName.textColor = [UIColor colorWithHexString:@"#333333"];
        _modelName.font = [UIFont fontWithName:@"PingFang SC" size:14];
        _modelName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_first];
        [self.contentView addSubview:_second];
        [self.contentView addSubview:_third];
        [self.contentView addSubview:_avart];
        [self.contentView addSubview:_favouriteBtn];
        [self.contentView addSubview:_photoDes];
        [self.contentView addSubview:_modelName];
        _photoDes.text = @"占位文字";
        _photoDes.textColor = [UIColor colorWithHexString:@"#777777"];
        _photoDes.font = [UIFont fontWithName:@"PingFang SC" size:13];
        _photoDes.textAlignment = NSTextAlignmentLeft;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoPhotoDetailPage:)];
        [_first addGestureRecognizer:recognizer];
        [_second addGestureRecognizer:recognizer];
        [_third addGestureRecognizer:recognizer];
        _first.tag = 1;
        _second.tag = 2;
        _third.tag = 3;
        
        [_first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(UI(15));
            make.top.equalTo(self.contentView.mas_top).offset(UI(15));
            make.width.mas_equalTo(UI(110));
            make.height.mas_equalTo(UI(150));
        }];
        [_second mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_first.mas_right).offset(UI(15));
            make.width.mas_equalTo(UI(110));
            make.top.mas_equalTo(_first.mas_top);
            make.bottom.mas_equalTo(_first.mas_bottom);
        }];
        [_third mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_second.mas_right).offset(UI(15));
            make.right.equalTo(self.contentView.mas_right).offset(-UI(15));
            make.top.and.bottom.equalTo(_first);
        }];
        [_avart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_first.mas_bottom).offset(UI(15));
            make.left.equalTo(_first.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-UI(15));
            make.width.and.height.mas_equalTo(UI(44));
        }];
        
        [_favouriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_third);
            make.size.mas_equalTo(UI(26));
            make.centerY.mas_equalTo(_avart);
        }];
        
        [_modelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.lessThanOrEqualTo(_avart.mas_top).offset(UI(5));
            make.left.mas_equalTo(_avart.mas_right).offset(UI(8));
            make.right.lessThanOrEqualTo(_favouriteBtn.mas_left);
        }];
        
        [_photoDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_modelName.mas_left);
            make.bottom.mas_equalTo(_avart.mas_bottom).offset(-UI(6.5));
            
            make.right.lessThanOrEqualTo(_favouriteBtn.mas_left);
        }];
    }
    return self;
}

- (void)fillFavouriteData:(FavouriteDataItem *)bean {
    self.favouriteItem = bean;
    NSString *cover1UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.album.cover_key1 isThumb:false];
    
    NSString *cover2UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.album.cover_key2 isThumb:false];
    
    NSString *cover3UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.album.cover_key3 isThumb:false];
    
    [_first sd_setImageWithURL:[ NSURL URLWithString:cover1UrlStr]];
    [_second sd_setImageWithURL:[ NSURL URLWithString:cover2UrlStr]];
    [_third sd_setImageWithURL:[ NSURL URLWithString:cover3UrlStr]];
    __weak typeof(self) wself = self;
    if (bean.album.model != nil) {
        _modelName.text = bean.album.model.name;
        NSString *avatar = [[AppConfig getInstance]getPhotoWholeUrl:bean.album.model.avatar_image_url isThumb:YES];
        [_avart sd_setImageWithURL:[NSURL URLWithString:avatar] completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
            __strong typeof(wself) sself = wself;
            sself.avart.image = image;
            sself.avart.layer.cornerRadius = UI(22);
            sself.avart.layer.masksToBounds = YES;
        }];
    } else {
        _modelName.text = @"素人";
        [_avart sd_setImageWithURL:[ NSURL URLWithString:cover1UrlStr] completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
            __strong typeof(wself) sself = wself;
            sself.avart.image = image;
            sself.avart.layer.cornerRadius = UI(22);
            sself.avart.layer.masksToBounds = YES;
        }];
    }
    _photoDes.text = bean.album.name;
    
    NSString* favouriteId = [FavouriteManager.shared isFavouriteLocalCheckWithAlbumId:bean.album.id];
    if (favouriteId) {
        [_favouriteBtn setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
    } else {
        [_favouriteBtn setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
    }
}


- (void)fillData:(PhotoItemDataItem *)bean {
    self.item = bean;
    NSString *cover1UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.info.cover_key1 isThumb:false];
    
    NSString *cover2UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.info.cover_key2 isThumb:false];
    
    NSString *cover3UrlStr =  [[AppConfig getInstance]getPhotoWholeUrl:bean.info.cover_key3 isThumb:false];
    
    [_first sd_setImageWithURL:[ NSURL URLWithString:cover1UrlStr]];
    [_second sd_setImageWithURL:[ NSURL URLWithString:cover2UrlStr]];
    [_third sd_setImageWithURL:[ NSURL URLWithString:cover3UrlStr]];
    __weak typeof(self) wself = self;
    if (bean.info.model != nil) {
        _modelName.text = bean.info.model.name;
        NSString *avatar = [[AppConfig getInstance]getPhotoWholeUrl:bean.info.model.avatar_image_url isThumb:YES];
        [_avart sd_setImageWithURL:[NSURL URLWithString:avatar] completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
            __strong typeof(wself) sself = wself;
            sself.avart.image = image;
            sself.avart.layer.cornerRadius = UI(22);
            sself.avart.layer.masksToBounds = YES;
        }];
    } else {
        _modelName.text = @"素人";
        [_avart sd_setImageWithURL:[ NSURL URLWithString:cover1UrlStr] completed:^(UIImage *_Nullable image, NSError *_Nullable error, SDImageCacheType cacheType, NSURL *_Nullable imageURL) {
            __strong typeof(wself) sself = wself;
            sself.avart.image = image;
            sself.avart.layer.cornerRadius = UI(22);
            sself.avart.layer.masksToBounds = YES;
        }];
    }
    _photoDes.text = bean.info.name;
    
    NSString* favouriteId = [FavouriteManager.shared isFavouriteLocalCheckWithAlbumId:bean.info.id];
    if (favouriteId) {
        [_favouriteBtn setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
    } else {
        [_favouriteBtn setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
    }
}

- (void)gotoPhotoDetailPage:(UITapGestureRecognizer *)sender {
    if (_clickCallback) {
        _clickCallback(_item);
    }
}

- (void)favouriteBtnClick:(UITapGestureRecognizer *)event {
    NSString* favouriteId = [FavouriteManager.shared isFavouriteLocalCheckWithAlbumId:_item.info.id];
    __weak typeof(self) wself = self;
    if (favouriteId!=nil) {
        [FavouriteManager.shared removeFavouriteWithFavouriteIdParams:favouriteId callback: ^(BOOL success) {
            __strong typeof(wself) sself = wself;
            if (success) {
                [sself.favouriteBtn setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
                
            }else {
                [sself.favouriteBtn setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
                
            }
            
        }];
    } else {
        
        [ FavouriteManager.shared addFavouriteWithAlbumId:_item.info.id
                                                 callback:^(BOOL success) {
            __strong typeof(wself) sself = wself;
            if (success) {
                [sself.favouriteBtn setImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
            }else {
                [sself.favouriteBtn setImage:[UIImage imageNamed:@"unfavourite"] forState:UIControlStateNormal];
                
            }
            
        }];
    }
}

@end
