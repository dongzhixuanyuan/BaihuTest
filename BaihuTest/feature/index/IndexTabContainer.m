
//
//  IndexTabContainer.m
//  BaihuTest
//
//  Created by liudong on 2020/5/2.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "IndexTabContainer.h"
#import "DimenAdapter.h"
#import <Masonry.h>
#import "NetworkManager.h"
#import "UrlConstants.h"
#import <YYModel.h>
#import "CategoryModel.h"
#import "UIColor+Addition.h"

@interface IndexTabContainer()
@property(nonatomic,strong,readwrite)NSMutableArray<UIView*>* topTabs;
@end

@implementation IndexTabContainer
- (instancetype)init
{
    self = [super init];
    _topTabs = [NSMutableArray arrayWithCapacity:4];
    if (self) {
        CGRect newFrame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        self.frame = newFrame;
        self.backgroundColor = [UIColor greenColor];
        for (int i = 0; i < 2; i++) {
            UILabel *tab = [[UILabel alloc]initWithFrame:CGRectMake([DimenAdapter dimenAutoFit:60] * i + UI(15), 0, [DimenAdapter dimenAutoFit:60], NAVIGATIONBAR_HEIGHT)];
            tab.userInteractionEnabled = YES;
            tab.backgroundColor = [UIColor whiteColor];
            tab.textColor = [UIColor colorWithHexString:@"#777777"];
            tab.font = [UIFont systemFontOfSize:14];
            
            [_topTabs addObject:tab];
            switch (i) {
                case 0:
                    tab.text = @"精选";
                    tab.tag = 0;
                    break;
                case 1:
                    tab.text = @"最新";
                    tab.tag = 1;
                    break;
                default:
                    break;
            }
            [self addSubview:tab];
        }
    }
    [self fetchCategories];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIView* selectedView = ((UITouch*)[touches anyObject]).view;
    for (UIView* child in [self subviews]) {
        if(child == selectedView){
            if (_tabClickDelegate && [_tabClickDelegate respondsToSelector:@selector(onTabClick:)]) {
                [_tabClickDelegate onTabClick : child.tag];
            }
        }
    }
}


-(void)fetchCategories{
    __weak __typeof(self) weakSelf = self;
    [NetworkManager.getHttpSessionManager GET:[UrlConstants getCategoryUrl] parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong __typeof(weakSelf) sself = weakSelf;
        CategoryModel* model = [CategoryModel yy_modelWithDictionary:responseObject];
        NSInteger existCount = [sself.topTabs count];
        for (CategoryDataItem* item in model.data) {
            UILabel *tab = [[UILabel alloc]initWithFrame:CGRectMake([DimenAdapter dimenAutoFit:60] * (existCount), 0, [DimenAdapter dimenAutoFit:60], NAVIGATIONBAR_HEIGHT)];
            tab.userInteractionEnabled = YES;
            tab.backgroundColor = [UIColor whiteColor];
            tab.textColor = [UIColor colorWithHexString:@"#777777"];
            tab.text = item.name;
            tab.tag = existCount;
            tab.font = [UIFont systemFontOfSize:14];
            [sself.topTabs addObject:tab];
            [sself addSubview:tab];
            existCount++;
        }
        [sself setNeedsLayout];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
    }];
    
}

@end
