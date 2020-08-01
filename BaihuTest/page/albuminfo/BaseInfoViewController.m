//
//  AlbumInfoViewController.m
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "BaseInfoViewController.h"
#import <Masonry.h>
#import <SDWebImage.h>
#import "AppConfig.h"
#import "TagResponseModel.h"
#import "DimenAdapter.h"
#import "NetworkManager.h"
#import "BaihuTest-Swift.h"
#import <YYModel.h>
@interface BaseInfoViewController ()

@end

@implementation BaseInfoViewController

+ (instancetype)initWithModel:(id)model {
    if ([model isKindOfClass:[Model class]]) {
        ModelInfoViewController* vc = [[ModelInfoViewController alloc]init];
        vc.model = model;
        return vc;
    } else {
        TagInfoViewController* vc = [[TagInfoViewController alloc]init];
        vc.model = model;
        return vc;
    }
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topImage];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(UI(235));
    }];
    
    _backIcon = [[UIButton alloc]init];
      [_backIcon setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
      [_backIcon addTarget:self action:@selector(popPage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backIcon];
    [_backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(33);
        make.left.equalTo(self.view.mas_left).offset(12);
    }];
    
    NSString *converUrl = nil;
    if ([_model isKindOfClass:[Model class]]) {
        converUrl =   [[AppConfig getInstance]getPhotoWholeUrl:((Model *)_model).cover_image_url isThumb:NO];
        
    } else if ([_model isKindOfClass:[TagItem class]]) {
        converUrl =   [[AppConfig getInstance]getPhotoWholeUrl:((TagItem *)_model).image_url isThumb:NO];
    }
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:converUrl]];
    
    [self.view addSubview:self.pictCount];

    
}


- (void)fetchPhotosCount {
    if (_protocolDelegate) {
        [[NetworkManager getHttpSessionManager] GET: [_protocolDelegate  albumsCountUrl] parameters:[_protocolDelegate params] headers:[NetworkManager getCommonHeaders] progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            AlbumCountResponse* bean =     [AlbumCountResponse  yy_modelWithDictionary:responseObject];
            NSString* text =[ NSString stringWithFormat:@"图集(%d)套",bean.data];
          
            self.pictCount.text =   text;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    
         
    }
}


- (UIImageView *)topImage {
    if (!_topImage) {
        _topImage = [[UIImageView alloc]init];
    }
    return _topImage;
}
- (UILabel *)pictCount {
    if (!_pictCount) {
        _pictCount = [[UILabel alloc]init];
        _pictCount.textColor = [UIColor colorWithHexString:@"#FF333333"];
        _pictCount.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 16];
    }
    return _pictCount;
}


- (void)popPage {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
