//
//  HistoryViewControllerOC.m
//  BaihuTest
//
//  Created by liudong on 2020/8/15.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "HistoryViewControllerOC.h"
#import "Beauty-Swift.h"
#import <Masonry.h>
@interface HistoryViewControllerOC ()

@end

@implementation HistoryViewControllerOC

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray<NSString*>* tabTitles = @[@"我的收藏",@"浏览记录"];
        self.tabContaienr.tabData = tabTitles;
        FavouriteTableiew* favourite = [[FavouriteTableiew alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        TableViewWithRefreshHeader* history = [[TableViewWithRefreshHeader alloc]initWithParams:[UrlConstants getScanHistory] itemClickListener:^(PhotoItemDataItem * _Nonnull bean) {
            
        }];
        
        [self.mainScrollView addSubview:favourite];
        [favourite mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self.mainScrollView);
            
            make.size.equalTo(self.mainScrollView);
        }];
        
        [self.mainScrollView addSubview:history];
        [self layoutAllPhotoTableViews];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
