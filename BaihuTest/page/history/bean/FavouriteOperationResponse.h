#import <Foundation/Foundation.h>
#import "PhotoItemResponseModel.h"
@interface User :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , assign) NSInteger              album_visit_count;
@property (nonatomic , assign) NSInteger              sign_in_days;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , assign) NSInteger              number;
@property (nonatomic , assign) NSInteger              integral;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , assign) BOOL              has_bound;

@end


@interface Data :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , strong) Info              * album;
@property (nonatomic , strong) User              * user;

@end


@interface FavouriteOperationResponse :NSObject
@property (nonatomic , strong) Data              * data;
@property (nonatomic , assign) NSInteger              code;
@property (nonatomic , strong) NSObject*              error;
@end
