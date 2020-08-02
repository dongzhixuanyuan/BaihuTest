//
//  RecommendSingleView.swift
//  BaihuTest
//
//  Created by liudong on 2020/7/12.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class RecommendSingleView: UIView {
    var bean:Any? = nil
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        icon.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview()
            maker.width.height.equalTo(55)
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(icon.snp.bottom).offset(7)
            maker.bottom.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.height.equalTo(12)
        }
    }
    
    @objc func setData(imageUrl:URL,name:String)  {
        icon.sd_setImage(with: imageUrl,completed: nil)
        nameLabel.text = name
    }
    
    @objc func setBean(data:Any)  {
        self.bean = data
    }
    
    @objc  func getBean() -> Any? {
        return bean
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var icon:UIImageView = {
        let icon = UIImageView.init()
        icon.layer.cornerRadius = 27.5
        icon.layer.masksToBounds = true
        return icon
    }()
    
    lazy var nameLabel:UILabel = {
        let name = UILabel.init()
        name.font = UIFont (name: "PingFang-SC-Medium", size: 12)
        name.textColor = UIColor.init(hexString: "#999999")
        name.sizeToFit()
        return name
    }()
    
}
