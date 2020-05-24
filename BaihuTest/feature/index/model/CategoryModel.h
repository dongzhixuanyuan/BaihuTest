#import <Foundation/Foundation.h>
@interface CategoryDataItem :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * create_datetime;

@end


@interface CategoryModel :NSObject
@property (nonatomic , strong) NSArray <CategoryDataItem *>              * data;
@property (nonatomic , assign) NSInteger              code;


@end
