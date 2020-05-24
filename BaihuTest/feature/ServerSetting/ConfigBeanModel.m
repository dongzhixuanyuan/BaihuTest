#import "ConfigBeanModel.h"
@implementation ConfigDataItem
@end


@implementation ConfigBeanModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"data" : [ConfigDataItem class]};
}
@end
