//
//  CustomTagView.swift
//  BaihuTest
//
//  Created by liudong on 2020/7/24.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class CustomTagView: UIView {
    let tagItems: Array<String>
    var tagViews: Array<UILabel>
    let horizontalPadding = CGFloat.init(14)
    let verticalPadding = CGFloat.init(5)
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tags: Array<String>, frame: CGRect) {
        tagItems = tags
        tagViews = []
        
        super.init(frame: frame)
        tagItems.forEach { it in
            let label = PaddingUILabel.init(insetPara: UIEdgeInsets.init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding))
            label.text = it
            label.backgroundColor = UIColor.init(hexString: "#7FFFFFFF")
            label.textColor = UIColor.init(hexString: "#FF222222")
            label.sizeToFit()
            label.font = UIFont.systemFont(ofSize: 12)
            label.layer.cornerRadius = 11
            label.layer.masksToBounds = true
            label.textAlignment = .center
            self.addSubview(label)
        }
    }
    
    override func layoutSubviews() {
        let count = subviews.count
        let totalWidth = frame.width
        let horizontalInterval = 6.0
        let verticalInterval = 12.0
        
        var currentX = CGFloat()
        var currentY = CGFloat()
        var lastView: UIView?
        
        for index in 0 ... (count - 1) {
            let currentView = subviews[index]
            let viewWidth = currentView.frame.width + horizontalPadding*2
            if (viewWidth + CGFloat(currentX) + CGFloat(horizontalInterval)) > totalWidth {
                // 需要换行了
                currentView.snp.makeConstraints { maker in
                    maker.top.equalTo(lastView!.snp.bottom).offset(verticalInterval)
                    maker.left.equalToSuperview()
                }
                currentX = viewWidth
                currentY += currentView.frame.height + CGFloat(verticalInterval) + verticalPadding*2
                
            } else {
                if lastView !== nil {
                    currentView.snp.makeConstraints { maker in
                        maker.left.equalTo(lastView!.snp.right).offset(horizontalInterval)
                        maker.centerY.equalTo(lastView!)
                    }
                } else {
                    currentView.snp.makeConstraints { maker in
                        maker.left.equalToSuperview()
                        maker.top.equalToSuperview()
                    }
                }
                currentX += viewWidth
            }
            lastView = currentView
        }
    }
}
