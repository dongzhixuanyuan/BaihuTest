//
//  PhotoWatchViewController.m
//  BaihuTest
//
//  Created by liudong on 2020/5/19.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "PhotoWatchViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoItemListResponseModel.h"
#import "PhotoCollectionViewCell.h"
#import "DimenAdapter.h"
#import <Masonry.h>
#import <SDWebImage.h>
#import "BaihuTest-Swift.h"
#import "AppConfig.h"
@interface PhotoWatchViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,ScaleableImageViewTapped>
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) PhotoItemDataItem *bean;

@property (nonatomic, strong, readwrite) UIView *topBar;
@property (nonatomic, strong, readwrite) UIButton *backIcon;
@property (nonatomic, strong, readwrite) UIImageView *topAvartar;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *count;
@property (nonatomic, strong, readwrite) UIButton *favourite;
@property (nonatomic, strong, readwrite) UIButton *jumpToPhotoList;
@property (nonatomic,assign)Boolean topBarShow;

@end

static const NSString *collectionCellIdentifier = @"PhotoCollectionViewCell";

@implementation PhotoWatchViewController

+ (instancetype)initWithBean:(PhotoItemDataItem *)item {
    PhotoWatchViewController *instance = [[PhotoWatchViewController alloc]init];
    if (instance) {
        instance.bean = item;
    }
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
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
        make.top.bottom.left.right.mas_equalTo(self.view);
    }];
    if(@available(iOS 11.0,*)) {
        _collectionView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _topBar = [[UIView alloc]initWithFrame:CGRectZero];
    _topBar.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor blackColor];
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
    [_topBar addSubview:self.topAvartar];
    [self.topAvartar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(UI(26));
        make.left.mas_equalTo(_backIcon.mas_right).offset(UI(19));
        make.centerY.mas_equalTo(_topBar);
    }];
    [_topAvartar sd_setImageWithURL:[ NSURL URLWithString:[[AppConfig getInstance]getPhotoWholeUrl:_bean.info.model.avatar_image_url isThumb:YES]]];
    [self.topBar addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topAvartar.mas_right).offset(UI(9.5));
        make.centerY.mas_equalTo(self.topBar);
    }];
    _titleLabel.text = _bean.info.model.name;
    [self.topBar addSubview:self.jumpToPhotoList];
    [_jumpToPhotoList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_topBar.mas_right).mas_offset(UI(-15));
        make.centerY.mas_equalTo(_topBar.mas_centerY);
        make.size.mas_equalTo(UI(26));
    }];
    
    [self.topBar addSubview:self.favourite];
    [_favourite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_jumpToPhotoList.mas_left).mas_offset(UI(-10));
        make.size.mas_equalTo(UI(26));
        make.centerY.mas_equalTo(_topBar.mas_centerY);
    }];
    
    [self.topBar addSubview:self.count];
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_favourite.mas_left).mas_offset(UI(-22));
        make.centerY.mas_equalTo(_topBar.mas_centerY);
        make.width.mas_equalTo(UI(53.5));
        make.height.mas_equalTo(UI(26));
    }];
    _topBarShow = YES;
}

- (UIImageView *)topAvartar {
    if (!_topAvartar) {
        _topAvartar = [[UIImageView alloc]init];
        _topAvartar.layer.cornerRadius = UI(26) / 2;
        _topAvartar.layer.masksToBounds = YES;
    }
    return _topAvartar;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel sizeToFit];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)count{
    if (!_count) {
        _count = [[UILabel alloc]init];
        _count.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _count.textAlignment = NSTextAlignmentCenter;
        _count.layer.cornerRadius = UI(13);
        _count.layer.masksToBounds = YES;
        [_count sizeToFit];
        _count.font = [UIFont systemFontOfSize:14];
        _count.textColor = [UIColor whiteColor];
    }
    return _count;
}

- (UIButton *)jumpToPhotoList {
    if (!_jumpToPhotoList) {
        _jumpToPhotoList = [[UIButton alloc]init];
        [_jumpToPhotoList setImage: [UIImage imageNamed: @"photo_list"] forState:UIControlStateNormal];
        [_jumpToPhotoList addTarget:self action:@selector(pushPhotoListPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpToPhotoList;
}
- (UIButton *)favourite {
    if (!_favourite) {
        _favourite = [[UIButton alloc]init];
        [_favourite setImage: [UIImage imageNamed: @"unfavourite_detail"] forState:UIControlStateNormal];
        [_favourite addTarget:self action:@selector(favouriteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favourite;
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _bean == nil ? 0 : _bean.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    [cell setPhoto:[_bean.photos objectAtIndex:indexPath.row]];
    _count.text = [NSString stringWithFormat:@"%d/%d",indexPath.row +1,_bean.photos.count ];
    [cell setTapDelegate:self];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.bounds.size;
}


- (void)imageViewTap {
    [_topBar setHidden:_topBarShow];
    self.navigationController.navigationBar.hidden = _topBarShow;
    _topBarShow = !_topBarShow;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return _topBarShow;
}


- (void)popPage {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushPhotoListPage{
    NSLog(@"pushPhotoListPage");
}

-(void)favouriteClick {
    NSLog(@"favouriteClick");
}

@end
