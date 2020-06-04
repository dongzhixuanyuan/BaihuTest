//
//  PhotoCollectionView.h
//  BaihuTest
//
//  Created by liudong on 2020/5/19.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell
-(instancetype)initWithBean:(PhotosItem*)photoItem;
-(void)setPhoto:(PhotosItem*)photoItem;
@end

NS_ASSUME_NONNULL_END
