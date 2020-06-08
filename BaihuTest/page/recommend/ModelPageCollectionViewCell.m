//
//  ModelPageCollectionViewCell.m
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "ModelPageCollectionViewCell.h"
#import "DimenAdapter.h"
#import <SDWebImage.h>
@interface ModelPageCollectionViewCell()
@property(nonatomic,strong,readwrite)UIImageView* modelIcon;
@end

@implementation ModelPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self addSubview:self.modelIcon];
    }
    return self;
}

- (void)loadImage:(NSString *)imageUrl {
    [_modelIcon sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (UIImageView *)modelIcon {
    if (!_modelIcon) {
        _modelIcon = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _modelIcon;
}
@end
        
