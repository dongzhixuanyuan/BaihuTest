//
//  TableViewWithRefreshHeader.m
//  BaihuTest
//
//  Created by liudong on 2020/5/25.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "TableViewWithRefreshHeader.h"
#import <Masonry.h>
#import "DimenAdapter.h"
#import <Foundation/Foundation.h>

@interface TableViewWithRefreshHeader()
@property(nonatomic,assign)BOOL isLoading;
@property(nonatomic,assign)BOOL isRefreshing;
@end


@implementation TableViewWithRefreshHeader

- (instancetype)initWithParams:(NSString *)url
             itemClickListener:(itemClickListener)clickCallback {
    self =[super init];
    if (self) {
        _isLoading = _isRefreshing = NO;
        _tableView = [[PhotoListView alloc]initWithUrl:url];
        [_tableView setClickCallback:clickCallback];
        
        _refreshView = [[TableRefreshHeaderView alloc]init];
        
        //        [_tableView addSubview:_refreshView];
        [self addSubview:_tableView];
        //        [_refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(_tableView.mas_top);
        //            make.left.right.equalTo(_tableView);
        //            make.height.equalTo( [ NSNumber numberWithFloat: UI(60)]);
        //        }];
        [_tableView setTableHeaderView:_refreshView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.right.equalTo(self);
        }];
        
        _tableView.contentInset = UIEdgeInsetsMake(-_refreshView.frame.size.height, 0, 0, 0);
        //        _tableView.contentOffset = CGPointMake(0, -UI(60));
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && !_isLoading && !_isRefreshing) {
        CGPoint curContentOffset = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"offset:%f",curContentOffset.y);
        if (_tableView.isDragging) {
            if (curContentOffset.y <= 0 ) {
                //到达下拉刷新的临界线
                [_refreshView setRefreshMode:REFRESH_WILL_LOADING];
            }else {
                [_refreshView setRefreshMode:REFRESH_DRAGING];
            }
        } else {
            if (curContentOffset.y <= 0 ) {
                //                进行刷新的操作
                [_refreshView setRefreshMode:REFRESH_LOADING];
                [self startRefreshing];
                
            }else {
                [_refreshView setRefreshMode:REFRESH_INIT];
            }
        }
    }
}

-(void) startRefreshing {
    _isRefreshing = YES;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    __weak typeof(self) wself = self;
    dispatch_async(dispatch_get_global_queue(000, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue()
                       , ^{
            __strong typeof(wself) sself = wself;
            sself.isRefreshing = NO;
            sself.tableView.contentInset = UIEdgeInsetsMake(- sself. refreshView.frame.size.height, 0, 0, 0);
        });
    });
}

- (void)dealloc
{
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
