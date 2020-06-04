//
//  RecommendViewController.m
//  BaihuTest
//
//  Created by liudong on 2020/6/3.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendPage.h"
#import <Masonry.h>
@interface RecommendViewController ()
@property(nonatomic,strong,readwrite)RecommendPage* recommendPage;
@end

@implementation RecommendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray<NSString*>* tabLabels = @[@"推荐",@"宠物",@"标签"];
           [self.tabContaienr setTabData: tabLabels ];
        _recommendPage = [[RecommendPage alloc]initWithFrame: self.scrollView.bounds ];
           [self.scrollView addSubview:_recommendPage];
           
           [self layoutAllPhotoTableViews];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
   
}


@end
