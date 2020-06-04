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
#import "TableRefreshFooterView.h"
@interface TableViewWithRefreshHeader ()<UIScrollViewDelegate, PhotoListFetchCallback>
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
        _footerView = [[TableRefreshFooterView alloc]init];
        [self addSubview:_tableView];

        [_tableView setTableHeaderView:_refreshView];
        [_tableView setTableFooterView:_footerView];


        __weak typeof(self) wself = self;
        _tableView.dragEndListener = ^{
            __strong typeof(wself) sself = wself;
            CGFloat curContentOffsetY = sself.tableView.contentOffset.y;
            NSLog(@"dragend offset:%f",curContentOffsetY);
            if (curContentOffsetY <= sself.refreshView.frame.size.height) {
                //下拉操作
                if (curContentOffsetY <= 0) {
                    //到达下拉刷新的临界线
                    [sself.refreshView setRefreshMode:REFRESH_LOADING];
                    [sself startRefreshing];
                } else {
                    [sself.refreshView setRefreshMode:REFRESH_INIT];
                    [sself resetRefreshNormalState:nil];
                }
            } else if (curContentOffsetY + sself.tableView.frame.size.height > sself.tableView.contentSize.height - sself.footerView.frame.size.height) {
                //                上拉操作
                if (curContentOffsetY + sself.tableView.frame.size.height > sself.tableView.contentSize.height) {
                    //到达了上拉加载的临界线
                    [sself.footerView setRefreshMode:REFRESH_LOADING];
                    [sself startLoadingMore];
                } else {
                    [sself.footerView setRefreshMode:REFRESH_INIT];
                    [sself resetLoadNormalState:nil];
                }
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
        UIEdgeInsets insets =   _tableView.contentInset;
        NSLog(@"content size:%f", _tableView.contentSize.height);
        NSLog(@"frame height:%f", _tableView.frame.size.height);
        NSLog(@"top:%f,left:%f,bottom:%f,right:%f", insets.top, insets.left, insets.bottom, insets.right);

        if (_tableView.isDragging) {
            if (curContentOffset.y <= _refreshView.frame.size.height) {
                //下拉操作
                if (curContentOffset.y <= 0) {
                    //到达下拉刷新的临界线
                    [_refreshView setRefreshMode:REFRESH_WILL_LOADING];
                    NSLog(@"%@", @"REFRESH_WILL_LOADING");
                } else {
                    [_refreshView setRefreshMode:REFRESH_INIT];
                    NSLog(@"%@", @"isDragging REFRESH_INIT");
                }
            } else if (curContentOffset.y + _tableView.frame.size.height > _tableView.contentSize.height - _footerView.frame.size.height) {
                //                上拉操作
                if (curContentOffset.y + _tableView.frame.size.height > _tableView.contentSize.height) {
                    //到达了上拉加载的临界线
                    [_footerView setRefreshMode:REFRESH_WILL_LOADING];
                } else {
                    [_footerView setRefreshMode:REFRESH_INIT];
                }
            }
        }
    }
}

- (void)resetRefreshNormalState:(void (^__nullable)(BOOL finished))complete {
    [UIView animateWithDuration:0.3
                     animations:^{
        self.tableView.contentOffset = CGPointMake(0,  self.refreshView.frame.size.height);
    } completion:^(BOOL finished) {
        if (complete != nil) {
            complete(finished);
        }
    }];
}

- (void)resetLoadNormalState:(void (^__nullable)(BOOL finished))complete {
    [UIView animateWithDuration:0.3
                     animations:^{
        self.tableView.contentOffset = CGPointMake(0,  self.tableView.contentSize.height - self.footerView.frame.size.height - self.tableView.frame.size.height);
    } completion:^(BOOL finished) {
        if (complete != nil) {
            complete(finished);
        }
    }];
}

- (void)startRefreshing {
    if (_isRefreshing) {
        return;
    }
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

- (void)startLoadingMore {
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.3
                     animations:^{
        self.tableView.contentOffset = CGPointMake(0,  self.tableView.contentSize.height - self.tableView.frame.size.height);
    } completion:^(BOOL finished) {
        __strong typeof(wself) sself = wself;
        [sself.tableView loadMoreData:sself];
    }];
}

- (void)fetchSuccessed:(FetchType)type {
    NSLog(@"fetchSuccessed");
    if (type == REFERSH) {
        [self.refreshView setRefreshMode:REFRESH_INIT];
        [self resetRefreshNormalState:^(BOOL finished) {
            self.isRefreshing = NO;
        }];
    } else {
        [self.footerView setRefreshMode:REFRESH_INIT];
        [self resetLoadNormalState:^(BOOL finished) {
            self.isLoading = NO;
        }];
    }
}

- (void)fetchFailed:(FetchType)type {
    NSLog(@"fetchFailed");
    if (type == REFERSH) {
        [self.refreshView setRefreshMode:REFRESH_INIT];
        [self resetRefreshNormalState:^(BOOL finished) {
            self.isRefreshing = NO;
        }];
    } else {
        [self.footerView setRefreshMode:REFRESH_INIT];
        [self resetLoadNormalState:^(BOOL finished) {
            self.isLoading = NO;
        }];
    }
}

@end