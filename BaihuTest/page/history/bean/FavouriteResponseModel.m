#import "FavouriteResponseModel.h"

@implementation FavouriteDataItem
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"album" : [Info class],
             @"user" : [User class],
    };
}
@end


@implementation FavouriteResponseModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"data" : [FavouriteDataItem class]
    };
}
@end
