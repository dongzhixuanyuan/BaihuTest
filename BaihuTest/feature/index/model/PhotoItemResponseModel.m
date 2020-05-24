#import "PhotoItemResponseModel.h"

@implementation TagsItem
@end


@implementation Model
@end


@implementation Info
@end


@implementation PhotosItem
@end


@implementation PhotoItemDataItem

+ (NSDictionary *)modelContainerPropertyGenericClass {
  return @{@"photos": [PhotosItem class]};
}


@end


@implementation PhotoItemResponseModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"data" : [PhotoItemDataItem class],
             @"photos": [PhotosItem class],
             @"tags":[TagsItem class]
    };
}
@end
