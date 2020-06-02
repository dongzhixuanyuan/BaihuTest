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

@interface TableViewWithRefreshHeader ()<UIScrollViewDelegate,PhotoListFetchCallback>
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isRefreshing;
@end

@implementation TableViewWithRefreshHeader

- (instancetype)initWithParams:(NSString *)url
             itemClickListener:(itemClickListener)clickCallback {
    self = [super init];
    if (self) {
        _isLoading = _isRefreshing = NO;
        _tableView = [[PhotoListView alloc]initWithUrl:url];
        [_tableView setClickCallback:clickCallback];
        
        _refreshView = [[TableRefreshHeaderView alloc]init];
        
        [self addSubview:_tableView];
        
        [_tableView setTableHeaderView:_refreshView];
        __weak typeof(self) wself = self;
        _tableView.dragEndListener = ^{
            __strong typeof(wself) sself = wself;
            if (sself.tableView.contentOffset.y <= 0) {
                //                进行刷新的操作
                [sself.refreshView setRefreshMode:REFRESH_LOADING];
                [sself startRefreshing];
                NSLog(@"%@", @"REFRESH_LOADING");
            } else if(sself.tableView.contentOffset.y < sself.refreshView.frame.size.height ) {
                [sself.refreshView setRefreshMode:REFRESH_INIT];
                [sself resetNormalState:nil];
                NSLog(@"%@", @"REFRESH_INIT");
            }
        };
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.right.equalTo(self);
        }];
        //这个地方之所以需要用dispatch，是因为在ios sdk中，view的布局更新啥的不一定是在主线程中执行的，所以有关UI的操作全部需要派发到主线程中执行。
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(wself) sself = wself;
            sself.tableView.contentOffset = CGPointMake(0, sself.refreshView.frame.size.height);
        });
        
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && !_isLoading && !_isRefreshing) {
        CGPoint curContentOffset = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"offset:%f", curContentOffset.y);
        if (_tableView.isDragging) {
            if (curContentOffset.y <= 0) {
                //到达下拉刷新的临界线
                [_refreshView setRefreshMode:REFRESH_WILL_LOADING];
                NSLog(@"%@", @"REFRESH_WILL_LOADING");
            } else {
                [_refreshView setRefreshMode:REFRESH_INIT];
                NSLog(@"%@", @"isDragging REFRESH_INIT");
            }
        }
    }
}

- (void)resetNormalState:(void (^__nullable)(BOOL finished))complete {
    [UIView animateWithDuration:0.3
                     animations:^{
        self.tableView.contentOffset = CGPointMake(0,  self.refreshView.frame.size.height);
    } completion:^(BOOL finished) {
        if (complete != nil) {
            complete(finished);
        }
    }];
}

- (void)startRefreshing {
    _isRefreshing = YES;
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.3
                     animations:^{
        self.tableView.contentOffset = CGPointMake(0,  0);
    } completion:^(BOOL finished) {
        __strong typeof(wself) sself = wself;
        [sself.tableView reFetchData:sself];
    }];
}


- (void)fetchSuccessed {
    NSLog(@"fetchSuccessed");
    [self.refreshView setRefreshMode:REFRESH_INIT];
    [self resetNormalState:^(BOOL finished) {
        self.isRefreshing = NO;
    }];
}

- (void)fetchFailed {
    NSLog(@"fetchFailed");
    [self.refreshView setRefreshMode:REFRESH_INIT];
    [self resetNormalState:^(BOOL finished) {
        self.isRefreshing = NO;
    }];
}

@end
