//
//  FavouriteTableiew.swift
//  BaihuTest
//
//  Created by liudong on 2020/8/16.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class FavouriteTableiew: UITableView, UITableViewDelegate, UITableViewDataSource {
    let cellIndentifier = "PhotoListItemView"
    var data = [FavouriteDataItem]()

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        separatorStyle = .none
        register(PhotoListItemView.self, forCellReuseIdentifier: cellIndentifier)
        mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadData()
        })

        mj_header!.beginRefreshing()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadData() {
        NetworkManager.getHttpSessionManager().get(UrlConstants.getAllFavourite(), parameters: nil, headers: NetworkManager.getCommonHeaders(), progress: nil, success: { [weak self] _, response in
            guard let myself = self else { return }
            myself.mj_header?.endRefreshing {
                let result = FavouriteResponseModel.yy_model(with: response as! [AnyHashable: Any])
                myself.data.removeAll()
                myself.data.append(contentsOf: (result?.data)!)
                myself.reloadData()
            }

        }) { [weak self] _, error in
            NSLog("\(error.localizedDescription)")
            self?.mj_header?.endRefreshing(completionBlock: {
            })
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemView = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        (itemView as! PhotoListItemView).fillFavouriteData(data[indexPath.row])
        return itemView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("fff")
        let item = data[indexPath.row]
        NetworkManager.getHttpSessionManager().get(UrlConstants.getAlbumsFromInfo(item.album.id), parameters: nil, headers: NetworkManager.getCommonHeaders(), progress: nil, success: { [weak self] _, response in
            guard let self = self else { return }

            let result = PhotoItemResponseModel.yy_model(with: response as! [AnyHashable: Any])

            let photoViewVC = PhotoWatchViewController.initWithBean((result?.data)!)
            let curController = self.getController()
            if curController != nil {
                curController?.navigationController?.pushViewController(photoViewVC, animated: true)
            }

        }) { _, _ in
        }
    }
}
