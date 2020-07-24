//
//  PaddingUILabel.swift
//  BaihuTest
//
//  Created by liudong on 2020/7/24.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class PaddingUILabel: UILabel {
    
    var inset:UIEdgeInsets
    
    init(insetPara:UIEdgeInsets){
       inset = insetPara
        super.init(frame:CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: inset.top , left: inset.left, bottom: inset.bottom, right: inset.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += (inset.top
            + inset.bottom )
        intrinsicSuperViewContentSize.width += (inset.left  + inset.right )
        return intrinsicSuperViewContentSize ;
    }
    
    func setContentEginset(edgeInset:UIEdgeInsets)  {
        inset = edgeInset
        self.intrinsicContentSize
    }
}
