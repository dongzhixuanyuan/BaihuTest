//
//  ModelPage.h
//  BaihuTest
//
//  Created by liudong on 2020/6/8.
//  Copyright © 2020 liudong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendDetailBasePage : UIView
@property(nonatomic,strong,readwrite)NSMutableArray<id>* data;
-(void)fetchAllModels;
-(NSString*)loadUrl;

@end

NS_ASSUME_NONNULL_END
