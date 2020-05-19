//
//  PhotoListItemView.h
//  BaihuTest
//
//  Created by liudong on 2020/5/14.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoListItemView : UITableViewCell
-(void) fillData:(PhotoItemDataItem*)bean;
@end

NS_ASSUME_NONNULL_END
