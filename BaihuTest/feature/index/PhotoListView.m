//
//  PhotoListView.m
//  BaihuTest
//
//  Created by liudong on 2020/5/9.
//  Copyright © 2020 liudong. All rights reserved.
//

#import "PhotoListView.h"
#import "PhotoListItemView.h"
@interface PhotoListView()<UITableViewDelegate,UITableViewDataSource>

@end



@implementation PhotoListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
//        self.rowHeight = UITableViewAutomaticDimension;
//        self.estimatedRowHeight = 100;
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoListItemView* itemView = nil;
    itemView = [tableView dequeueReusableCellWithIdentifier:@"PhotoListItemView"];
    if (itemView == nil) {
        itemView = [[PhotoListItemView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoListItemView"];
    }
    return itemView;
}


@end
