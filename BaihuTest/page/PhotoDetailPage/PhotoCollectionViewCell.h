//
//  PhotoCollectionView.h
//  BaihuTest
//
//  Created by liudong on 2020/5/19.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemListResponseModel.h"
#import "BaihuTest-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell
//+(instancetype)initWithDelegate:(CGRect)frame tapDelegate:(id<ScaleableImageViewTapped>)delegate;
-(void)setPhoto:(PhotosItem*)photoItem;
-(void)setTapDelegate:(id<ScaleableImageViewTapped>)delegate;
-(void)resetSize;
@end

NS_ASSUME_NONNULL_END
