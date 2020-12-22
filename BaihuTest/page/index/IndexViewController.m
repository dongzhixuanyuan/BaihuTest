//
//  IndexViewController.m
//  BaihuTest
//
//  Created by liudong on 2020/4/30.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

#import "IndexViewController.h"
#import "DimenAdapter.h"
#import "BaseViewPager.h"
#import "HomeTabBar.h"
#import "PhotoListView.h"
#import "UrlConstants.h"
#import "PhotoWatchViewController.h"
#import "NetworkManager.h"
#import "CategoryModel.h"
#import  <YYModel.h>
#import "TableRefreshHeaderView.h"
#import "TableViewWithRefreshHeader.h"
@interface IndexViewController ()

@property (nonatomic, strong, readwrite) UIImageView *rankIcon;
@property (nonatomic, strong, readwrite) UIImageView *signIcon;
@end

@implementation IndexViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self fetchIndexCategories];
        [self initTopBtn];
        TableViewWithRefreshHeader *newestPhotos = [[TableViewWithRefreshHeader alloc]initWithParams:[UrlConstants getIndexAllUrl] itemClickListener:^(PhotoItemDataItem *_Nonnull photoItem) {
            [self itemClick:photoItem];
        }];

        TableViewWithRefreshHeader *recommendPhotos = [[TableViewWithRefreshHeader alloc]initWithParams:[UrlConstants getRecomandUrl] itemClickListener:^(PhotoItemDataItem *_Nonnull photoItem) {
            [self itemClick:photoItem];
        }];

        [self.mainScrollView addSubview:newestPhotos];
        [self.mainScrollView addSubview:recommendPhotos];
        [self layoutAllPhotoTableViews];
    }
    return self;
}

- (void)initTopBtn {
    _rankIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rank"]];

    _signIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign"]];

    [self.view addSubview:_rankIcon];
    [self.view addSubview:_signIcon];

    [_signIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-UI(15));
        make.centerY.equalTo(self.tabContaienr.mas_centerY);
        make.size.equalTo(@24);
    }];

    [_rankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_signIcon.mas_left).offset(-UI(20));
        make.centerY.equalTo(_signIcon);
        make.size.equalTo(@24);
    }];
}

- (void)fetchIndexCategories {
    __weak __typeof(self) weakSelf = self;
    [NetworkManager.getHttpSessionManager GET:[UrlConstants getCategoryUrl] parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        __strong __typeof(weakSelf) sself = weakSelf;
        CategoryModel *model = [CategoryModel yy_modelWithDictionary:responseObject];
        NSMutableArray<NSString *> *tabData = [NSMutableArray arrayWithCapacity:model.data.count + 2];
        [tabData addObject:@"精选"];
        [tabData addObject:@"最新"];
        if ([UrlConstants getConfig]) {
            for (CategoryDataItem *item in model.data) {
                [tabData addObject:item.name];
                TableViewWithRefreshHeader *photoTableView = [[TableViewWithRefreshHeader alloc]initWithParams:[UrlConstants getSpeCategoryUrl:item.id] itemClickListener:^(PhotoItemDataItem *_Nonnull photoItem) {
                    PhotoWatchViewController *newController = [PhotoWatchViewController initWithBean:photoItem];
                    [sself.navigationController pushViewController:newController animated:YES];
                }];
                [sself.mainScrollView addSubview:photoTableView];
            }
        }

        [sself.tabContaienr setTabData:tabData];
        [sself layoutAllPhotoTableViews];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        __strong __typeof(weakSelf) sself = weakSelf;
        NSMutableArray<NSString *> *tabData = [NSMutableArray arrayWithCapacity:2];
        [tabData addObject:@"精选"];
        [tabData addObject:@"最新"];
        [sself.tabContaienr setTabData:tabData];
    }];
}

- (void)itemClick:(PhotoItemDataItem *)photoItem {
    PhotoWatchViewController *newController = [PhotoWatchViewController initWithBean:photoItem];
    [self.navigationController pushViewController:newController animated:YES];
    [[NetworkManager getHttpSessionManager] POST:[UrlConstants postVisitRecord:photoItem.info.id] parameters:[NetworkManager getCommonHeaders] headers:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSLog(@"success");
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        NSLog(@"error");
    }];
}

@end
