#import "FavouriteOperationResponse.h"

@implementation User
@end


@implementation Data
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"user" : [User class]
    };
}
@end


@implementation FavouriteOperationResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"data" : [Data class]
    };
}
@end
