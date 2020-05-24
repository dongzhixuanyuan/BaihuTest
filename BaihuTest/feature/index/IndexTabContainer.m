
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
#import <Masonry.h>


@interface IndexTabContainer()
@property(nonatomic,strong,readwrite)NSMutableArray<UILabel*>* topTabs;
@property(nonatomic,strong,readwrite)UIImageView* rankIcon;
@property(nonatomic,strong,readwrite)UIImageView* signIcon;
@end

@implementation IndexTabContainer
- (instancetype)init
{
    self = [super init];
    _topTabs = [NSMutableArray arrayWithCapacity:4];
    if (self) {
        CGRect newFrame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        self.frame = newFrame;
//        self.backgroundColor = [UIColor greenColor];
        for (int i = 0; i < 2; i++) {
            UILabel *tab = [[UILabel alloc]initWithFrame:CGRectMake([DimenAdapter dimenAutoFit:UI(50)] * i + UI(15) , 0, [DimenAdapter dimenAutoFit:UI(30)], NAVIGATIONBAR_HEIGHT-1)];
            tab.userInteractionEnabled = YES;
              tab.textAlignment = NSTextAlignmentCenter;
            tab.backgroundColor = [UIColor whiteColor];
            tab.textColor = [UIColor colorWithHexString:@"#777777"];
            tab.font = [UIFont systemFontOfSize:14];
            
            [_topTabs addObject:tab];
            switch (i) {
                case 0:
                    tab.text = @"精选";
                    tab.tag = 0;
                    tab.textColor = [UIColor colorWithHexString:@"#222222"];

                    tab.transform = CGAffineTransformScale(tab.transform, 1.4, 1.4);
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
        _rankIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rank"]];
        
        _signIcon =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign"]];
        
        [self addSubview:_rankIcon];
        [self addSubview:_signIcon];
        
        [_rankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(UI(300));
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@24);
            make.width.equalTo(@24);
        }];
        
        [_signIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_rankIcon.mas_right).offset(UI(16));
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@24);
            make.width.equalTo(@24);
        }];
        
     
    
    }
    [self fetchCategories];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray<UIView*>* children =  [self subviews];
    for (UIView* child in children) {
        NSLog(@"child: %d",child.hash );
    }
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
            UILabel *tab = [[UILabel alloc]initWithFrame:CGRectMake([DimenAdapter dimenAutoFit:UI(50)] * (existCount) + UI(15) , 0, [DimenAdapter dimenAutoFit:UI(30)], NAVIGATIONBAR_HEIGHT - 1)];
            tab.userInteractionEnabled = YES;
            tab.textAlignment = NSTextAlignmentCenter;
            tab.backgroundColor = [UIColor whiteColor];
            tab.textColor = [UIColor colorWithHexString:@"#777777"];
            tab.text = item.name;
            tab.tag = existCount;
            tab.font = [UIFont systemFontOfSize:14];
            [sself.topTabs addObject:tab];
            [sself addSubview:tab];
            existCount++;
        }
        [sself drawBottomDivider];
        [sself setNeedsLayout];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"currentSelectedPage"]) {
        NSInteger newPage =
        [(NSNumber*)[change objectForKey:NSKeyValueChangeNewKey] intValue];
        NSInteger oldPage =[(NSNumber*) [change objectForKey:NSKeyValueChangeOldKey] intValue];
        [self updateSelectIndex:newPage oldselect:oldPage];
    }
}

-(void) updateSelectIndex:(NSInteger)selectIndex oldselect:(NSInteger)oldSelected {
    if (selectIndex < 0 ||  selectIndex >= _topTabs.count) {
        NSLog(@"异常");
        return;
    }
    __weak typeof(self) wself = self;
    for (NSInteger i = 0; i < _topTabs.count; i++) {
        __strong typeof(wself) sself = wself;
        if (selectIndex == i) {
            //放大动画
            UILabel* label =  sself.topTabs[i];
            label.textColor = [UIColor colorWithHexString:@"#222222"];
            
            [UIView animateWithDuration:0.2
                                         animations:^{
                label.transform = CGAffineTransformScale(label.transform, 1.4, 1.4);
                        }];
        } else if ( oldSelected == i){
            //缩小动画
            UILabel* label =  sself.topTabs[i];
//            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"#777777"];
            
            [UIView animateWithDuration:0.2
                                         animations:^{
                            UILabel* label =  sself.topTabs[i];
                label.transform = CGAffineTransformIdentity;
                        }];
        }
    }
    
}

-(void)drawBottomDivider {
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(0, NAVIGATIONBAR_HEIGHT-2)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(self.frame.size.width  , NAVIGATIONBAR_HEIGHT-2)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor colorWithHexString:@"#E1E1E1"].CGColor;
    lineLayer.path = linePath.CGPath;
//    lineLayer.fillColor = nil; // 默认为blackColor
    
    [self.layer addSublayer:lineLayer];
}


@end
