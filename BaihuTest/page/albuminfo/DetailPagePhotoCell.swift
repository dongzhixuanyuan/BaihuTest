//
//  DetailPagePhotoCell.swift
//  BaihuTest
//
//  Created by liudong on 2020/8/1.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class DetailPagePhotoCell: UICollectionViewCell {
    let  ALBUM_VIP_FLAG = "c_vip"
    let  ALBUM_FULI_FLAG = "c_fuli"
    var data:PhotoItemDataItem? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        image.snp.makeConstraints { (maker) in
             maker.left.top.equalToSuperview()
            maker.width.equalTo(110)
            maker.height.equalTo(150)
           
        }
        addSubview(flagView)
        flagView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview()
        }
        addSubview(pictCount)
        pictCount.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(30)
            maker.right.equalTo(image.snp.right).offset(-6)
            maker.bottom.equalTo(image.snp.bottom).offset(-6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(bean:PhotoItemDataItem)  {
        image.sd_setImage(with: bean.info.cover_key1.keyStrToUrl(isThumb: false)) { (UIImage, Error, SDImageCacheType, URL) in
            
        }
        if bean.info.category.id == ALBUM_VIP_FLAG {
            flagView.isHidden = false
            flagView.backgroundColor = UIColor.orange
            flagView.text = "VIP"
        }else {
            flagView.isHidden = true
        }
        pictCount.text = String(bean.photos.count)
    }
    
    lazy var image:UIImageView = {
        let view = UIImageView.init()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var flagView:PaddingUILabel = {
        let label = PaddingUILabel.init(insetPara: UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5))
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "PingFang-SC-Medium", size: 12)
        label.textAlignment = .center
        label.sizeToFit()
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var pictCount:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.init(hexString: "99000000")
        label.font = UIFont.init(name: "PingFang-SC-Medium", size: 12)
        label.textAlignment = .center
        label.sizeToFit()
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
}
