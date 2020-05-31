//
//  PhotoListView.h
//  BaihuTest
//
//  Created by liudong on 2020/5/9.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^itemClickListener)(PhotoItemDataItem*);

@interface PhotoListView : UITableView
-(instancetype)initWithUrl:(NSString*)url;
@property(nonatomic,copy)NSString* url;
@property(nonatomic,copy)itemClickListener clickCallback;
@end

NS_ASSUME_NONNULL_END