//
//  HistoryViewController.swift
//  BaihuTest
//
//  Created by liudong on 2020/8/15.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewPager {
    
    var favouriteTable: TableViewWithRefreshHeader? = nil
    
    var historyTable: TableViewWithRefreshHeader? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tabContaienr.tabData = ["我的收藏","浏览记录"]
        
        
        favouriteTable = TableViewWithRefreshHeader.init(params: UrlConstants.getAllFavourite()) { (photoItemDataItem) in
            
        }
        
        historyTable = TableViewWithRefreshHeader.init(params: UrlConstants.getScanHistory()) { (photoItemDataItem) in
            
        }
        scrollView.addSubview(favouriteTable!)
        scrollView.addSubview(historyTable!)
        
    }
    
    
    
    
}
