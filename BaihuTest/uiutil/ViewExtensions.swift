//
//  Extensions.swift
//  BaihuTest
//
//  Created by liudong on 2020/8/2.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit


extension UIView {
    @objc func getController() -> UIViewController? {
        var tmpResponder = self.next
        while (tmpResponder != nil) {
            if tmpResponder!.isKind(of: UIViewController.self) {
                return tmpResponder as! UIViewController
            }
            tmpResponder = tmpResponder?.next
        }
        return nil
    }
}
