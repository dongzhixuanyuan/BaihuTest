//
//  AlbumInfoViewController.h
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwipeBack.h>
#import "PhotoItemResponseModel.h"
#import "TagResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AlbumInfoForModelOrTagProtocol <NSObject>

-(NSString*) albumsCountUrl;
-(NSString*) albumListUrl;
-(NSDictionary*) paramsForCount;
-(NSDictionary*) paramsForAlbumList;

@end


@interface BaseInfoViewController : UIViewController
@property (nonatomic, strong, readwrite) id model; //Model or TagItem
@property (nonatomic, strong, readwrite) UIButton *backIcon;
@property (nonatomic, strong, readwrite) UILabel *pictCount;
@property (nonatomic, strong, readwrite) UIImageView *topImage;

+(instancetype)initWithModel:(Model*)model;

@property (nonatomic,assign) id<AlbumInfoForModelOrTagProtocol> protocolDelegate;

-(void)fetchPhotosCount;

@end

NS_ASSUME_NONNULL_END
