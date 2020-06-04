//
//  TableRefreshFooterView.h
//  BaihuTest
//
//  Created by liudong on 2020/6/2.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableRefreshHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableRefreshFooterView : UIView
@property(nonatomic,strong)UIActivityIndicatorView* loadingIndicatorView;
@property(nonatomic,strong)UILabel* refreshText;
-(void)setRefreshMode:(RefreshState)state;
@end

NS_ASSUME_NONNULL_END
