#import <Foundation/Foundation.h>
#import "CategoryModel.h"
@interface TagsItem :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , copy) NSString              * image_url;
@property (nonatomic , copy) NSString              * name;

@end


@interface Model :NSObject
@property (nonatomic , copy) NSString              * summary;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * avatar_image_url;
@property (nonatomic , copy) NSString              * cover_image_url;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * tags;

@end


@interface Info :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , strong) CategoryDataItem              * category;
@property (nonatomic , copy) NSString              * cover_key2;
@property (nonatomic , strong) NSArray <TagsItem *>              * tags;
@property (nonatomic , assign) NSInteger              photo_quantity;
@property (nonatomic , assign) BOOL              free_limit;
@property (nonatomic , copy) NSString              * cover_key1;
@property (nonatomic , assign) NSInteger              visit_count;
@property (nonatomic , copy) NSString              * cover_key3;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , strong) Model              * model;
@property (nonatomic , copy) NSString              * name;

@end


@interface PhotosItem :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , assign) BOOL              synced;

@end


@interface PhotoItemDataItem :NSObject
@property (nonatomic , strong) Info              * info;
@property (nonatomic , strong) NSArray <PhotosItem *>              * photos;

@end


@interface PhotoItemResponseModel :NSObject
@property (nonatomic , strong) NSArray <PhotoItemDataItem *>              * data;
@property (nonatomic , assign) NSInteger              code;

@end

