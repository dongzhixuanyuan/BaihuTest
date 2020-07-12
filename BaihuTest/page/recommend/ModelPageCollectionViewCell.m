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
#import "BaihuTest-Swift.h"
#import <Masonry.h>
@interface ModelPageCollectionViewCell()
@property(nonatomic,strong,readwrite)RecommendSingleView* modelIcon;
@end

@implementation ModelPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.modelIcon];
        [self.modelIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setData:(NSString *)imageUrl name:(NSString *)name{
    [_modelIcon setDataWithImageUrl: [NSURL URLWithString:imageUrl] name:name];
}

- (RecommendSingleView *)modelIcon {
    if (!_modelIcon) {
        _modelIcon = [[RecommendSingleView alloc]initWithFrame:self.bounds];
    }
    return _modelIcon;
}
@end
        
