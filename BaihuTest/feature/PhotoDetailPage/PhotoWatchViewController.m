//
//  PhotoWatchViewController.m
//  BaihuTest
//
//  Created by liudong on 2020/5/19.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "PhotoWatchViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoItemResponseModel.h"
#import "PhotoCollectionViewCell.h"
#import "DimenAdapter.h"
#import <Masonry.h>

@interface PhotoWatchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong,readwrite)UICollectionView* collectionView;
@property(nonatomic,strong,readwrite)PhotoItemDataItem* bean;

@property(nonatomic,strong,readwrite)UIView* topBar;
@property(nonatomic,strong,readwrite)UIButton* backIcon;
@property(nonatomic,strong,readwrite)UIImageView* avartar;
@property(nonatomic,strong,readwrite)UILabel* title;
@property(nonatomic,strong,readwrite)UILabel* count;
@property(nonatomic,strong,readwrite)UIButton* favourite;
@property(nonatomic,strong,readwrite)UIButton* jumpToPhotoList;

@end

static const NSString* collectionCellIdentifier = @"PhotoCollectionViewCell";

@implementation PhotoWatchViewController



+ (instancetype)initWithBean:(PhotoItemDataItem *)item {
    PhotoWatchViewController*  instance = [[PhotoWatchViewController alloc]init];
    if (instance) {
        instance.bean = item;
    }
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _topBar = [[UIView alloc]initWithFrame: CGRectZero];
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
    
    
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topBar.mas_bottom);
        make.bottom.left.right.mas_equalTo(self.view);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _bean == nil ? 0 :  _bean.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell* cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    [cell setPhoto: [_bean.photos objectAtIndex:indexPath.row]];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
}

-(void)popPage {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
