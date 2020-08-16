//
//  PhotoListItemView.h
//  BaihuTest
//
//  Created by liudong on 2020/5/14.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemListResponseModel.h"
#import "PhotoListView.h"
#import "FavouriteResponseModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface PhotoListItemView : UITableViewCell
-(void) fillData:(PhotoItemDataItem*)bean;
-(void) fillFavouriteData:(FavouriteDataItem*)bean;
@property(nonatomic,copy)itemClickListener clickCallback;
@end

NS_ASSUME_NONNULL_END
