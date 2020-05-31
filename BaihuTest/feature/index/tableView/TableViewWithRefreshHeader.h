//
//  TableViewWithRefreshHeader.h
//  BaihuTest
//
//  Created by liudong on 2020/5/25.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListView.h"
#import "TableRefreshHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewWithRefreshHeader : UIView
@property (nonatomic, strong, readwrite) PhotoListView *tableView;
@property (nonatomic, strong, readwrite) TableRefreshHeaderView *refreshView;
- (instancetype)initWithParams:(NSString *)url itemClickListener:(itemClickListener)clickCallback;
//@property (nonatomic, copy) NSString *url;
//@property (nonatomic, copy) itemClickListener clickCallback;
@end

NS_ASSUME_NONNULL_END
