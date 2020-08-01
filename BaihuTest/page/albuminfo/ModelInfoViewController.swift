//
//  ModelInfoViewController.swift
//  BaihuTest
//
//  Created by liudong on 2020/6/30.
//  Copyright © 2020 liudong. All rights reserved.
//

import Alamofire
import UIKit

class ModelInfoViewController: BaseInfoViewController, AlbumInfoForModelOrTagProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var photos = [PhotoItemDataItem]()
    let LIST_CELL_IDENTIFIER = "DetailPagePhotoCell"
    var page = 0
    var pageSize = 10
    var noMoreData = false
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: LIST_CELL_IDENTIFIER, for: indexPath)
        (cell as! DetailPagePhotoCell).setData(bean: photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func params() -> [AnyHashable: Any] {
        return ["model_id": (model as! Model).id]
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
    
    func fetchPhotos(page: Int, pageSize: Int) {
        let urlStr = UrlConstants.getAlbumsForModel((model as! Model).id, page: page, size: pageSize)
        NetworkManager.getHttpSessionManager().get(urlStr, parameters: nil, headers: NetworkManager.getCommonHeaders(), progress: nil, success: { [weak self] _, response in
            guard let self = self else { return }
            let model = PhotoItemResponseModel.yy_model(with: response as! [AnyHashable: Any])
            let existCount = self.photos.count
            let newComeDataCount = (model!.data!).count
            
            var insertRows = [IndexPath]()
            for i in 0 ..< newComeDataCount {
                insertRows.append(IndexPath(row: existCount + i, section: 0))
            }
            self.photos.append(contentsOf: model!.data!)
            self.photoList.insertItems(at: insertRows)
            self.page += 1
            if newComeDataCount < pageSize {
                self.noMoreData = true
                self.photoList.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                self.photoList.mj_footer?.endRefreshing()
            }
            
            
        }) { _, _ in
        }
    }
    
    func albumsCountUrl() -> String {
        return UrlConstants.getAlbumCountForModel()
    }
    
    func albumListUrl() -> String {
        return ""
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
    
    lazy var photoList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        
        layout.itemSize = CGSize(width: DimenAdapter.dimenAutoFit(110), height: DimenAdapter.dimenAutoFit(150))
        let listview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        listview.backgroundColor = UIColor.white
        listview.delegate = self
        listview.dataSource = self
        listview.register(DetailPagePhotoCell.self, forCellWithReuseIdentifier: LIST_CELL_IDENTIFIER)
        listview.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock:  {
            self.fetchPhotos(page: self.page, pageSize: self.pageSize)
        })
        return listview
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
    
    func addCollectionView() {
    }
}
