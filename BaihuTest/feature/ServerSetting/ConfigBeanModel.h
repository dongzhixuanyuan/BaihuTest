#import <Foundation/Foundation.h>
@interface ConfigDataItem :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * value;

@end


@interface ConfigBeanModel :NSObject
@property (nonatomic , assign) NSInteger              code;
@property (nonatomic , strong) NSArray <ConfigDataItem *>              * data;

@end
