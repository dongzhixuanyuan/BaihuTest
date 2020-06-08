//
//  ModelPage.h
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AlbumIconClick <NSObject>

-(void)onItemClick:(NSString*)albumId;

@end


@interface RecommendDetailBasePage : UIView
@property (nonatomic, strong, readwrite) NSMutableArray<id> *data;
@property(nonatomic,weak,readwrite) id<AlbumIconClick> clickCallback;
- (void)fetchAllModels;
- (NSString *)loadUrl;

@end

NS_ASSUME_NONNULL_END
