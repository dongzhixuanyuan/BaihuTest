
#import <Foundation/Foundation.h>

@interface TagItem :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * create_datetime;
@property (nonatomic , copy) NSString              * image_url;
@property (nonatomic , copy) NSString              * name;

@end


@interface TagResponseModel :NSObject
@property (nonatomic , strong) NSArray <TagItem *>              * data;
@property (nonatomic , assign) NSInteger              code;

@end
