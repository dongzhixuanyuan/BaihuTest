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
#import "TagResponseModel.h"
#import "BaihuTest-Swift.h"
#import "UIColor+Addition.h"
@interface RecommendPage ()
@property (nonatomic, strong, readwrite) UILabel *recomendGirl;
@property (nonatomic, strong, readwrite) UIView *girlContaienr;
@property (nonatomic, strong, readwrite) UILabel *recomendTag;
@property (nonatomic, strong, readwrite) UIView *tagsContaienr;

@property (nonatomic, strong, readwrite) UIImageView *girl01;
@property (nonatomic, strong, readwrite) UIImageView *girl02;
@property (nonatomic, strong, readwrite) UIImageView *girl03;
@property (nonatomic, strong, readwrite) UIImageView *girl04;
@property (nonatomic, strong, readwrite) RecommendSingleView *tag01, *tag02, *tag03, *tag04;
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
            make.left.equalTo(self.mas_left).offset(14.5);
            make.top.equalTo(self.mas_top).offset(19.5);
        }];
        
        [_girlContaienr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_recomendGirl.mas_bottom).offset(15);
            make.height.mas_equalTo(UI(75));
            make.left.right.mas_equalTo(self);
        }];
        
        [_recomendTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_girlContaienr.mas_bottom).offset(24);
            make.left.equalTo(self.mas_left).offset(14.5);
        }];
        
        [_tagsContaienr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_recomendTag.mas_bottom).offset(15);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(UI(75));
        }];
        
        _recomendGirl.text = @"推荐宠物";
        [_recomendGirl sizeToFit];
        _recomendTag.text = @"推荐标签";
        [_recomendTag sizeToFit];
        
        __weak typeof(self) wself = self;
        [ [NetworkManager getHttpSessionManager] GET:[UrlConstants getRecommendModels:4] parameters:nil headers:[NetworkManager getCommonHeaders] progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            __strong typeof(wself) sself = wself;
            ModelResponseModel *response =    [ModelResponseModel yy_modelWithDictionary:responseObject];
            
            for (int i = 0; i < 4 && i < response.data.count; i++) {
                Model *model  = [response.data objectAtIndex:i];
               RecommendSingleView *image;
                if (i == 0) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(20, 10, 55, 75)];
                    sself.tag01 = image;
                } else if (i == 1) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(100, 10, 55, 75)];
                    sself.tag02 = image;
                } else if (i == 2) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(180, 10, 55, 75)];
                    sself.tag03 = image;
                } else if (i == 3) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(260, 10, 55, 75)];
                    sself.tag04 = image;
                }
                NSString *avatarImgUrl =  [[AppConfig getInstance]getPhotoWholeUrl:model.avatar_image_url isThumb:false];
                [image setDataWithImageUrl:  [NSURL URLWithString:avatarImgUrl]  name:model.name];
                [sself.girlContaienr addSubview:image];
        
            }
            
            [sself setNeedsLayout];
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSLog(@"");
        }];
        
        [ [NetworkManager getHttpSessionManager] GET:[UrlConstants getRecommendTags:4] parameters:nil headers:[NetworkManager getCommonHeaders] progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            __strong typeof(wself) sself = wself;
            NSString *responseStr = [Test dictionary2String:responseObject];
            TagResponseModel *response =    [TagResponseModel yy_modelWithDictionary:responseObject];
            
            for (int i = 0; i < 4 && i < response.data.count; i++) {
                TagItem *tag  = [response.data objectAtIndex:i];
                RecommendSingleView *image;
                if (i == 0) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(20, 10, 55, 75)];
                    sself.tag01 = image;
                } else if (i == 1) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(100, 10, 55, 75)];
                    sself.tag02 = image;
                } else if (i == 2) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(180, 10, 55, 75)];
                    sself.tag03 = image;
                } else if (i == 3) {
                    image = [[RecommendSingleView alloc]initWithFrame:CGRectMake(260, 10, 55, 75)];
                    sself.tag04 = image;
                }
                NSString *avatarImgUrl =  [[AppConfig getInstance]getPhotoWholeUrl:tag.image_url isThumb:false];
                
                [image setDataWithImageUrl:  [NSURL URLWithString:avatarImgUrl]  name:tag.name];
                [sself.tagsContaienr addSubview:image];
            }
            
            [sself setNeedsLayout];
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSLog(@"");
        }];
    }
    return self;
}

@end
