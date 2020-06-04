//
//  RecommendPage.m
//  BaihuTest
//
//  Created by liudong on 2020/6/4.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "RecommendPage.h"
#import <Masonry.h>
#import <YYModel.h>
#import "NetworkManager.h"
#import "UrlConstants.h"
#import "Test.h"
#import "ModelResponseModel.h"
#import <SDWebImage.h>
#import "AppConfig.h"
#import "DimenAdapter.h"

@interface RecommendPage()
@property(nonatomic,strong,readwrite)UILabel* recomendGirl;
@property(nonatomic,strong,readwrite)UIView* girlContaienr;
@property(nonatomic,strong,readwrite)UILabel* recomendTag;
@property(nonatomic,strong,readwrite)UIView* tagsContaienr;
@end


@implementation RecommendPage


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _recomendGirl = [[UILabel alloc]init];
        _recomendTag = [[UILabel alloc]init];
        _girlContaienr = [[UILabel alloc]init];
        _tagsContaienr = [[UILabel alloc]init];
        [self addSubview:_recomendTag];
        [self addSubview:_recomendGirl];
        [self addSubview:_girlContaienr];
        [self addSubview:_tagsContaienr];
        [_recomendGirl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self);
        }];
        
        [_girlContaienr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_recomendGirl.mas_bottom);
            make.left.right.mas_equalTo(self);
        }];
        
        
        [_recomendTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_girlContaienr.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
        }];
        
        [_tagsContaienr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_recomendTag.mas_bottom);
            make.left.right.mas_equalTo(self);
        }];
        
        
        _recomendGirl.text = @"推荐宠物";
        [_recomendGirl sizeToFit];
        _recomendTag.text = @"推荐标签";
        [_recomendTag sizeToFit];
        
        __weak typeof(self) wself = self;
        [ [NetworkManager getHttpSessionManager] GET: [UrlConstants getRecommendModels:4] parameters:nil headers: [NetworkManager getCommonHeaders] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             __strong typeof(wself) sself = wself;
            ModelResponseModel * response =    [ModelResponseModel yy_modelWithDictionary:responseObject];
            
            for (Model* model in response.data) {
                UIImageView* image = [[UIImageView alloc]init];
                NSString* avatarImgUrl =  [[AppConfig getInstance]getPhotoWholeUrl:model.avatar_image_url isThumb:false] ;
                [image sd_setImageWithURL: [NSURL URLWithString:avatarImgUrl]];
                [sself.girlContaienr addSubview:image];
                [image mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.equalTo(UI(50));
                }];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"");
        }];
        
    }
    return self;
}


@end
