//
//  String+URL.swift
//  BaihuTest
//
//  Created by liudong on 2020/7/11.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

extension NSString {
    var toUrl:NSURL {
        return NSURL.init(string: self as String)!
    }
}


