//
//  TableRefreshHeaderView.m
//  BaihuTest
//
//  Created by liudong on 2020/5/25.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "TableRefreshHeaderView.h"
#import "DimenAdapter.h"
#import <Masonry.h>

@interface TableRefreshHeaderView()
@property(nonatomic,assign)RefreshState curState;
@end



@implementation TableRefreshHeaderView


- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, UI(60))];
    if (self) {
        [self addSubview:self.loadingIndicatorView];
        [self addSubview:self.refreshText];
        [_loadingIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(100);
            make.height.equalTo(@40);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [_refreshText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_loadingIndicatorView.mas_right);
            make.height.equalTo(@40);
            make.centerY.equalTo(self.mas_centerY);
        }];
        self.curState = REFRESH_INIT;
    }
    return self;
}


- (UIActivityIndicatorView *)loadingIndicatorView {
    if (!_loadingIndicatorView) {
        _loadingIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
        [_loadingIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleMedium];
        _loadingIndicatorView.backgroundColor = [UIColor clearColor];
    }
    return _loadingIndicatorView;
}

- (UILabel *)refreshText {
    if (!_refreshText) {
        _refreshText = [[UILabel alloc]initWithFrame:CGRectZero];
        _refreshText.font = [UIFont fontWithName:@"Arial" size:14];
        _refreshText.textColor = [UIColor blackColor];
        _refreshText.text = @"继续下拉刷新";
    }
    return _refreshText;
}

- (void)setRefreshMode:(RefreshState)state {
    if (_curState == state) {
        return;
    }
    switch (state) {
        case REFRESH_INIT:
            _refreshText.hidden = NO;
            _refreshText.text = @"继续下拉刷新";
            _loadingIndicatorView.hidden = NO;
            [_loadingIndicatorView   stopAnimating];
            break;
        case REFRESH_WILL_LOADING:
            _refreshText.hidden = NO;
            _refreshText.text = @"松开立即刷新";
            _loadingIndicatorView.hidden = NO;
            [_loadingIndicatorView   stopAnimating];
            break;
        case REFRESH_LOADING:
            _refreshText.hidden = NO;
            _refreshText.text = @"精彩马上就来";
            _loadingIndicatorView.hidden = NO;
            [_loadingIndicatorView   startAnimating];
            break;
        case REFRESH_LOADED:
            _refreshText.text = @"";
            _refreshText.hidden = YES;
            [_loadingIndicatorView stopAnimating];
            _loadingIndicatorView.hidden = YES;
        default:
            break;
    }
    _curState = state;
}

@end
