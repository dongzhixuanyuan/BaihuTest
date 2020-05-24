#import "CategoryModel.h"
@implementation CategoryDataItem
@end


@implementation CategoryModel
 + (NSDictionary *)modelContainerPropertyGenericClass {
     // value should be Class or Class name.
     return @{@"data" : [CategoryDataItem class]};
 }
@end
