//
//  PhotoCollectionView.m
//  BaihuTest
//
//  Created by liudong on 2020/5/19.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import <SDWebImage.h>
#import "AppConfig.h"
#import <Masonry.h>
#import "DimenAdapter.h"
@interface PhotoCollectionViewCell()
@property(nonatomic,strong,readwrite)UIImageView* image;

@end


@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         
        
        _image = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
           
            
            make.left.right.bottom.top.mas_equalTo(self.contentView);
        }];
        
    }
    return self;
}


- (void)setPhoto:(PhotosItem *)photoItem {
    [_image sd_setImageWithURL:  [NSURL URLWithString: [[AppConfig getInstance]getPhotoWholeUrl:photoItem.key isThumb:NO ]]];
}

@end
