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
@property (nonatomic, strong, readwrite) UIImageView *topImage;
@property (nonatomic, strong, readwrite) UIView *topBar;
@property (nonatomic, strong, readwrite) UIButton *backIcon;
@property (nonatomic,strong,readwrite)UILabel* pictCount;
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
    _topBar = [[UIView alloc]initWithFrame:CGRectZero];
    _topBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topBar];
    [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(STATUSBAR_HEIGHT);
        make.height.mas_equalTo(NAVIGATIONBAR_HEIGHT);
    }];
    _backIcon = [[UIButton alloc]init];
    [_backIcon setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backIcon addTarget:self action:@selector(popPage) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addSubview:_backIcon];
    [_backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topBar.mas_centerY);
        make.left.equalTo(_topBar.mas_left).offset(UI(15));
    }];

    [self.view addSubview:self.topImage];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_topBar.mas_bottom);
        make.height.mas_equalTo(UI(200));
    }];
    
    
    NSString *converUrl = nil;
    if ([_model isKindOfClass:[Model class]]) {
        converUrl =   [[AppConfig getInstance]getPhotoWholeUrl:((Model *)_model).cover_image_url isThumb:NO];
        
    } else if ([_model isKindOfClass:[TagItem class]]) {
        converUrl =   [[AppConfig getInstance]getPhotoWholeUrl:((TagItem *)_model).image_url isThumb:NO];
    }
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:converUrl]];
    
    [self.view addSubview:self.pictCount];
    [self.pictCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImage.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(10);
    }];
    
}


- (void)startFetchData {
    if (_protocolDelegate) {
        [[NetworkManager getHttpSessionManager] GET: [_protocolDelegate  albumsCountUrl] parameters:[_protocolDelegate params] headers:[NetworkManager getCommonHeaders] progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            AlbumCountResponse* bean =     [AlbumCountResponse  yy_modelWithDictionary:responseObject];
            self.pictCount.text = [@(bean.data) stringValue];
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
        _pictCount.textColor = [UIColor blackColor];
        _pictCount.font = [UIFont fontWithName:@"PingFang SC" size: 13];
    }
    return _pictCount;
}


- (void)popPage {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
