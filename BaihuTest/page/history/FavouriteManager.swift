//
//  FavouriteManager.swift
//  BaihuTest
//
//  Created by liudong on 2020/8/9.
//  Copyright © 2020 liudong. All rights reserved.
//

import UIKit

class FavouriteManager: NSObject {
    @objc static let shared = FavouriteManager()
    override private init() {
    }

    var favouriteList = [(albumId: String, favouriteId: String)]()

    @objc func isFavouriteLocalCheck(albumId: String) -> String? {
        let result = favouriteList.first { (item) -> Bool in
            item.albumId == albumId
        }
        if result == nil {
            return nil
        } else {
            return result!.favouriteId
        }
    }

    //    闭包逃逸。
    @objc func addFavourite(albumId: String, callback: ((Bool) -> Void)?) {
        NetworkManager.getHttpSessionManager().post(UrlConstants.addFavourite(), parameters: ["album_id": albumId], headers: NetworkManager.getCommonHeaders(), progress: nil, success: { _, response in
            let resObj = FavouriteOperationResponse.yy_model(with: response as! [AnyHashable: Any])
            if resObj?.error == nil {
                callback?(true)
                FavouriteManager.shared.favouriteList.append((albumId: resObj!.data!.album!.id, favouriteId: resObj!.data!.id))
            }

        }) { _, _ in
            callback?(false)
        }
    }

    @objc func removeFavourite(favouriteIdParams: String, callback: ((Bool) -> Void)?) {
        NetworkManager.getHttpSessionManager().delete(UrlConstants.deleteFavourite(favouriteIdParams), parameters: nil, headers: NetworkManager.getCommonHeaders(), success: { _, response in
            let result = CommonOperationsResponse(fromDictionary: response as! NSDictionary)
            if result.error == nil {
                callback?(true)
                FavouriteManager.shared.favouriteList.removeAll { (item) -> Bool in
                    item.favouriteId == favouriteIdParams
                }
            } else {
                callback?(false)
            }
            let value = Test.dictionary2String(response as! [AnyHashable: Any])
            print(value)
        }) { _, _ in
            callback?(false)
        }
    }

    @objc func pullFavourites() {
        NetworkManager.getHttpSessionManager().get(UrlConstants.getAllFavourite(), parameters: nil, headers: NetworkManager.getCommonHeaders(), progress: nil, success: { [weak self] _, _ in
            guard let self = self else { return }
            

        }) { _, _ in
        }
    }
}
