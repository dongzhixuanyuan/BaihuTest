//
//  RecommendViewController.m
//  BaihuTest
//
//  Created by liudong on 2020/6/3.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendPage.h"
#import "RecommendDetailBasePage.h"
#import "ModelPage.h"
#import "TagPage.h"
#import "BaseInfoViewController.h"
#import <Masonry.h>
#import <SwipeBack.h>
#import "TagResponseModel.h"
#import "Beauty-Swift.h"
@interface RecommendViewController ()<AlbumIconClick>
@property (nonatomic, strong, readwrite) RecommendPage *recommendPage;
@property(nonatomic,strong,readwrite)RecommendDetailBasePage* modelPage,*tagPage;
@end

@implementation RecommendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray<NSString *> *tabLabels = @[@"推荐", @"宠物", @"标签"];
        [self.tabContaienr setTabData:tabLabels ];
        _recommendPage = [[RecommendPage alloc]initWithFrame:self.mainScrollView.bounds ];
        [self.mainScrollView addSubview:_recommendPage];
        _modelPage = [[ModelPage alloc]initWithFrame:self.mainScrollView.bounds];
        _tagPage = [[TagPage alloc]initWithFrame:self.mainScrollView.bounds];
//        todo 添加点击监听
        _modelPage.clickCallback = self;
        [_modelPage fetchAllModels];
        _tagPage.clickCallback = self;
        [_tagPage fetchAllModels];
        [self.mainScrollView addSubview:_modelPage];
        [self.mainScrollView addSubview:_tagPage];
        
    
        [self layoutAllPhotoTableViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)onItemClick:(id)item {
    if ([item isKindOfClass:[Model class]]) {
        ModelInfoViewController* albumViewController = [ModelInfoViewController initWithModel:(Model*)item ];
        [self.navigationController pushViewController:albumViewController animated:YES];
    }else if ([item isKindOfClass:[TagItem class]]){
        TagInfoViewController* vc = [TagInfoViewController initWithModel:item ];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
@end
