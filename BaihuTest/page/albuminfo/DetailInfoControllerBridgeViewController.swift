//
//  DetailInfoControllerBridgeViewController.swift
//  BaihuTest
//
//  Created by liudong on 2020/8/2.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class DetailInfoControllerBridgeViewController: BaseInfoViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var photos = [PhotoItemDataItem]()
    let LIST_CELL_IDENTIFIER = "DetailPagePhotoCell"
    var page = 0
    var pageSize = 10
    var noMoreData = false
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LIST_CELL_IDENTIFIER, for: indexPath)
        (cell as! DetailPagePhotoCell).setData(bean: photos[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newController = PhotoWatchViewController.initWithBean(photos[indexPath.row])
        navigationController?.pushViewController(newController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(photoList)
        photoList.snp.makeConstraints { maker in
            maker.top.equalTo(pictCount.snp.bottom).offset(15)
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        fetchPhotos(page: page, pageSize: pageSize)
    }

    func fetchPhotos(page: Int, pageSize: Int) {
        if protocolDelegate != nil {
           let urlStr =  protocolDelegate.albumListUrl()
//        let urlStr = UrlConstants.getAlbumsForModel((model as! Model).id, page: page, size: pageSize)
            NetworkManager.getHttpSessionManager().get(urlStr, parameters: protocolDelegate.paramsForAlbumList(), headers: NetworkManager.getCommonHeaders(), progress: nil, success: { [weak self] _, response in
            guard let self = self else { return }
            let model = PhotoItemListResponseModel.yy_model(with: response as! [AnyHashable: Any])
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
        
    }

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
        listview.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.fetchPhotos(page: self.page, pageSize: self.pageSize)
        })
        return listview
    }()
}
