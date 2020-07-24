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
//        TODO 添加模特顶部view
        let  nameBg =  UIView.init()
        nameBg.backgroundColor = UIColor.init(hexString: "#66000000")
        nameBg.layer.cornerRadius = 25
        nameBg.layer.masksToBounds = true
        let nameLabel = UILabel.init()
        nameLabel.text = (model as! Model).name
        nameLabel.font = UIFont.init(name: "PingFang-SC-Bold", size: 18)
        
        nameLabel.textColor = UIColor.white
        nameBg.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        view.addSubview(nameBg)
        nameBg.snp.makeConstraints { (maker) in
            maker.width.equalTo(125)
            maker.height.equalTo(50)
            maker.left.equalToSuperview().offset(60)
            maker.top.equalTo(backIcon.snp.bottom).offset(23)
        }
        view.addSubview(avatarIcon)
        avatarIcon.snp.makeConstraints { (maker) in
            maker.size.equalTo(70)
            maker.left.equalToSuperview().offset(15)
            maker.top.equalTo(backIcon.snp.bottom).offset(13)
        }
        initTags((model as! Model).tags)
        
        startFetchData();
        
    }
    
    func albumsCountUrl() -> String {
        return UrlConstants.getAlbumCountForModel()
     }
     
     func albumListUrl() -> String {
        return ""
     }
    
    lazy var avatarIcon:UIImageView = {
        let imageview = UIImageView.init()
        imageview.sd_setImage(with: (model as! Model).avatar_image_url.keyStrToUrl(isThumb: true), completed: nil)
        imageview.layer.cornerRadius = 35
        imageview.layer.masksToBounds = true
        return imageview
    }()
     
    func initTags(_ tagStr:String)  {
        var tags = [String]()
        
        tagStr.components(separatedBy: "|").forEach { (it) in
            tags.append(it)
        }
        let tagView =  CustomTagView.init(tags: tags, frame: CGRect.zero)
        self.view .addSubview(tagView)
        tagView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.height.equalTo(100)
            maker.top.equalTo(avatarIcon.snp.bottom).offset(20)
        }
        print("")
    }

}
