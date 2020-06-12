//
//  AlbumInfoViewController.h
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwipeBack.h>
#import "PhotoItemResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ModelInfoViewController : UIViewController
+(instancetype)initWithModel:(Model*)model;
@end

NS_ASSUME_NONNULL_END
