#import "TagResponseModel.h"
@implementation TagItem
@end


@implementation TagResponseModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
  return @{@"data": [TagItem class]};
}
@end
