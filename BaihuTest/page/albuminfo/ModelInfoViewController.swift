//
//  ModelInfoViewController.swift
//  BaihuTest
//
//  Created by liudong on 2020/6/30.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class ModelInfoViewController: BaseInfoViewController,AlbumInfoForModelOrTagProtocol {
    func params() -> [AnyHashable : Any] {
        return ["model_id":(model as! Model).id];
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        super.protocolDelegate = self
        startFetchData();
        
    }
    
    func albumsCountUrl() -> String {
        return UrlConstants.getAlbumCountForModel()
     }
     
     func albumListUrl() -> String {
        return ""
     }
    
    
     

}
