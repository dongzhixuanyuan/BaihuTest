//
//  ModelInfoViewController.swift
//  BaihuTest
//
//  Created by liudong on 2020/6/30.
//  Copyright © 2020 liudong. All rights reserved.
//

import Alamofire
import UIKit

class ModelInfoViewController: DetailInfoControllerBridgeViewController, AlbumInfoForModelOrTagProtocol {
    func paramsForCount() -> [AnyHashable: Any] {
        return ["model_id": (model as! Model).id]
    }

    func paramsForAlbumList() -> [AnyHashable: Any] {
        return ["model_id": (model as! Model).id!, "page": page, "size": pageSize]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.protocolDelegate = self
        //        TODO: 添加模特顶部view
        let nameBg = UIView()
        nameBg.backgroundColor = UIColor(hexString: "#66000000")
        nameBg.layer.cornerRadius = 25
        nameBg.layer.masksToBounds = true
        let nameLabel = UILabel()
        nameLabel.text = (model as! Model).name
        nameLabel.font = UIFont(name: "PingFang-SC-Bold", size: 18)

        nameLabel.textColor = UIColor.white
        nameBg.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        view.addSubview(nameBg)
        nameBg.snp.makeConstraints { maker in
            maker.width.equalTo(125)
            maker.height.equalTo(50)
            maker.left.equalToSuperview().offset(60)
            maker.top.equalTo(backIcon.snp.bottom).offset(23)
        }
        view.addSubview(avatarIcon)
        avatarIcon.snp.makeConstraints { maker in
            maker.size.equalTo(70)
            maker.left.equalToSuperview().offset(15)
            maker.top.equalTo(backIcon.snp.bottom).offset(13)
        }
        initTags((model as! Model).tags)
        view.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { maker in
            maker.top.equalTo(topImage.snp.bottom).offset(20)
            maker.left.equalToSuperview().offset(15)
            maker.right.equalToSuperview().offset(-15)
        }

        fetchPhotosCount()
        view.addSubview(pictCount)
        pictCount.snp.makeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(17)
        }

        view.addSubview(photoList)
        photoList.snp.makeConstraints { maker in
            maker.top.equalTo(pictCount.snp.bottom).offset(15)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        fetchPhotos(page: page, pageSize: pageSize)
    }

    func albumsCountUrl() -> String {
        return UrlConstants.getAlbumCountForModel()
    }

    func albumListUrl() -> String {
        return UrlConstants.getAlbumsForModel()
    }

    lazy var avatarIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.sd_setImage(with: (model as! Model).avatar_image_url.keyStrToUrl(isThumb: true), completed: nil)
        imageview.layer.cornerRadius = 35
        imageview.layer.masksToBounds = true
        return imageview
    }()

    lazy var descriptionView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = (model as! Model).summary
        label.sizeToFit()
        label.textColor = UIColor(hexString: "#FF999999")
        label.font = UIFont(name: "PingFang-SC-Medium", size: 14)
        return label
    }()

    func initTags(_ tagStr: String) {
        var tags = [String]()

        tagStr.components(separatedBy: "|").forEach { it in
            tags.append(it)
        }

        let tagView = CustomTagView(tags: tags, frame: CGRect.zero)
        view.addSubview(tagView)
        tagView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.height.equalTo(100)
            maker.top.equalTo(avatarIcon.snp.bottom).offset(20)
        }
        print("")
    }
}
