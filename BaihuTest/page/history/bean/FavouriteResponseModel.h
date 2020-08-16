#import <Foundation/Foundation.h>
#import "PhotoItemListResponseModel.h"
#import "FavouriteOperationResponse.h"

@interface FavouriteDataItem :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , strong) Info              * album;
@property (nonatomic , strong) User              * user;

@end


@interface FavouriteResponseModel :NSObject
@property (nonatomic , strong) NSArray <FavouriteDataItem *>              * data;
@property (nonatomic , assign) NSInteger              code;

@end
