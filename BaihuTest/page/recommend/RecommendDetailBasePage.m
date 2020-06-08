//
//  ModelPage.m
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "ModelPage.h"
#import "TagPage.h"
#import "DimenAdapter.h"
#import "ModelPageCollectionViewCell.h"
#import "ModelResponseModel.h"
#import "TagResponseModel.h"
#import "NetworkManager.h"
#import "UrlConstants.h"
#import <YYModel.h>
#import <Masonry.h>
#import "AppConfig.h"
@interface RecommendDetailBasePage()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong,readwrite)UICollectionView* collectionView;
@end

@implementation RecommendDetailBasePage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.bottom.mas_equalTo(self).offset(UI(15));
        }];
        self.data = @[].mutableCopy;
    }
    return self;
}

- (NSString *)loadUrl {
    return @"";
}

- (void)fetchAllModels {
    __weak typeof(self) wself = self;
    [[NetworkManager  getHttpSessionManager]GET: [self loadUrl] parameters:nil headers:[NetworkManager getCommonHeaders] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!responseObject) {
            return;
        }
        __strong   typeof(wself) sself = wself;
        id response;
        [sself.data removeAllObjects];
        if ([self isKindOfClass:[ModelPage class]]) {
            response = [ModelResponseModel yy_modelWithDictionary:responseObject];
            [sself.data addObjectsFromArray:((ModelResponseModel*)response).data];

        } else if ([self isKindOfClass:[TagPage class]]){
            response = [TagResponseModel yy_modelWithDictionary:responseObject];
            [sself.data addObjectsFromArray:((TagResponseModel*)response).data];
        }
        
        [sself.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = UI(10);
        layout.minimumInteritemSpacing = UI(10);
        layout.itemSize = CGSizeMake(UI(50),UI(50));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ModelPageCollectionViewCell class] forCellWithReuseIdentifier:@"ModelPageCollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id bean = [_data objectAtIndex :indexPath.item ];
    if ([self isKindOfClass:[ModelPage class]]) {
        
    } else if ([self isKindOfClass:[TagPage class]]){
 
    }

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ModelPageCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModelPageCollectionViewCell" forIndexPath:indexPath];
    NSString* url;
    id bean = [_data objectAtIndex:indexPath.item];
    if ([self isKindOfClass:[ModelPage class]]) {
        url =  [[AppConfig getInstance]getPhotoWholeUrl:((Model*)bean).avatar_image_url isThumb:YES];
    } else if ([self isKindOfClass:[TagPage class]]){
        url =  [[AppConfig getInstance]getPhotoWholeUrl:((TagItem*)bean).image_url isThumb:YES];
    }
    
    [cell loadImage: url];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width =   (self.frame.size.width - UI(15)*4) / 4;
    return CGSizeMake(width,width);
}


@end
