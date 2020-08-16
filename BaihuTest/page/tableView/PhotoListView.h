//
//  PhotoListView.h
//  BaihuTest
//
//  Created by liudong on 2020/5/9.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItemListResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^itemClickListener)(PhotoItemDataItem*);
typedef void(^dragEndCallback)();


typedef enum:NSInteger{
    REFERSH,
    LOAD_MORE
}FetchType;
@protocol PhotoListFetchCallback <NSObject>
@required
-(void)fetchSuccessed:(FetchType)type;
-(void)fetchFailed:(FetchType)type;
@end


@interface PhotoListView : UITableView
-(instancetype)initWithUrl:(NSString*)url;
@property(nonatomic,copy)NSString* url;
@property(nonatomic,copy)itemClickListener clickCallback;
@property(nonatomic,copy)dragEndCallback dragEndListener;
- (void)reFetchData:(_Nullable id<PhotoListFetchCallback>) callback;
- (void)loadMoreData:(_Nullable  id<PhotoListFetchCallback>) callback;
@end

NS_ASSUME_NONNULL_END
