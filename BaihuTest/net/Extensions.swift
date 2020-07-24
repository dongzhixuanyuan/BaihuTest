//
//  Extensions.swift
//  BaihuTest
//
//  Created by liudong on 2020/7/24.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit



extension String{
    func keyStrToUrl(isThumb:Bool) -> URL {
        return  URL.init(string:  AppConfig.getInstance().getPhotoWholeUrl(self, isThumb: isThumb))!
    }
}
