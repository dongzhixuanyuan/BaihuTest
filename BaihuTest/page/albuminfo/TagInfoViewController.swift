//
//  TagInfoViewController.swift
//  BaihuTest
//
//  Created by liudong on 2020/6/30.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class TagInfoViewController: DetailInfoControllerBridgeViewController, AlbumInfoForModelOrTagProtocol {
    func paramsForCount() -> [AnyHashable: Any] {
        return ["tag_id": (model as! TagItem).id!]
    }

    func paramsForAlbumList() -> [AnyHashable: Any] {
        return ["tag_id": (model as! TagItem).id!, "page": page, "size": pageSize]
    }

    func albumListUrl() -> String {
        return UrlConstants.getAlbumsForTag()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.protocolDelegate = self
        view.addSubview(flagView)
        flagView.snp.makeConstraints { maker in
            maker.center.equalTo(topImage)
        }
        flagView.text = (model as! TagItem).name
        view.addSubview(pictCount)
        pictCount.snp.makeConstraints { maker in
            maker.top.equalTo(topImage.snp.bottom).offset(20)
            maker.left.equalToSuperview().offset(17)
        }
        fetchPhotosCount()
        fetchPhotos(page: page, pageSize: pageSize)
    }

    lazy var flagView: PaddingUILabel = {
        let label = PaddingUILabel(insetPara: UIEdgeInsets(top: 17, left: 32, bottom: 17, right: 32))
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.backgroundColor = UIColor(hexString: "#66000000")
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true

        return label
    }()

    func albumsCountUrl() -> String {
        return UrlConstants.getAlbumCountForTag()
    }
}
