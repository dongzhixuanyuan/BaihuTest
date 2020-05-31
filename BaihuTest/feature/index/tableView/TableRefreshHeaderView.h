//
//  TableRefreshHeaderView.h
//  BaihuTest
//
//  Created by liudong on 2020/5/25.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    REFRESH_INIT,
    REFRESH_DRAGING,
    REFRESH_WILL_LOADING,
    REFRESH_LOADING,
    REFRESH_LOADED
} RefreshState;


@interface TableRefreshHeaderView : UIView
@property(nonatomic,strong)UIActivityIndicatorView* loadingIndicatorView;
@property(nonatomic,strong)UILabel* refreshText;
-(void)setRefreshMode:(RefreshState)state;
@end

NS_ASSUME_NONNULL_END
