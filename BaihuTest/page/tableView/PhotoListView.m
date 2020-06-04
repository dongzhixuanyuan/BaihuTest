//
//  PhotoListView.m
//  BaihuTest
//
//  Created by liudong on 2020/5/9.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "PhotoListView.h"
#import "PhotoListItemView.h"
#import "NetworkManager.h"
#import "PhotoItemResponseModel.h"
#import  <YYModel.h>

@interface PhotoListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong, readwrite) NSMutableArray<PhotoItemDataItem *> *data;
@property(nonatomic,assign)BOOL isTouchDown;
@end

@implementation PhotoListView

- (instancetype)initWithUrl:(NSString *)url {
    self.url = url;
    self = [super init];
    _page = 0;
    _pageSize = 20;
    if (self) {
        self.isTouchDown = NO;
        self.delegate = self;
        self.dataSource = self;
        self.data = [[NSMutableArray alloc]init];
        [self reFetchData:nil];
        
    }
    return self;
}

# pragma mark 数据加载相关
- (void)reFetchData:   (_Nullable  id<PhotoListFetchCallback>) callback {
    _page = 0;
    [self fecthListData:NO callback:callback];
}

- (void)loadMoreData:(id<PhotoListFetchCallback>) callback {
    _page++;
    [self fecthListData:YES callback:callback];
}

- (void)fecthListData:(BOOL)loadMore callback :(id<PhotoListFetchCallback>) callback {
    __weak typeof(self) wself = self;
    [ [NetworkManager getHttpSessionManager] GET:_url parameters:@{ @"page": [NSNumber numberWithInt:_page], @"size":  [ NSNumber numberWithInt:_pageSize] } headers:[NetworkManager getCommonHeaders] progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        __strong typeof(wself) sself = wself;
        PhotoItemResponseModel *model = [PhotoItemResponseModel yy_modelWithDictionary:responseObject];
        if (!loadMore) {
            [sself.data removeAllObjects];
        }
        [sself.data addObjectsFromArray:model.data];
        [sself reloadData];
        [callback fetchSuccessed: loadMore? LOAD_MORE:REFERSH  ];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        NSLog(@"error %ld",error.code);
        [callback fetchFailed: loadMore? LOAD_MORE:REFERSH];
    }];
}

# pragma mark tableview回调
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count =  self.data == nil ? 0 : self.data.count;
    NSLog(@"元素个数:%d",count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoListItemView *itemView = nil;
    itemView = [tableView dequeueReusableCellWithIdentifier:@"PhotoListItemView"];
    if (itemView == nil) {
        itemView = [[PhotoListItemView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoListItemView"];
    }
    itemView.clickCallback = _clickCallback;
    [itemView fillData:[_data objectAtIndex:indexPath.item]];
    return itemView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoItemDataItem* selectedItem =   [_data objectAtIndex:indexPath.item];
    _clickCallback(selectedItem);
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   NSLog(@"scrollViewWillBeginDragging");
    _isTouchDown = YES;
}

//手指弹起，没有自动回弹动画时，调用该方法。
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging，decelerate : %@",decelerate?@"true":@"false");
    if (!decelerate && _dragEndListener ) {
        _isTouchDown = NO;
        _dragEndListener();
    }
}

//当有自动回弹动画时，会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    if (_isTouchDown && _dragEndListener) {
        _isTouchDown = NO;
        _dragEndListener();
    }
}


@end
